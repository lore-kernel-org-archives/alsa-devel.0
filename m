From: Sindre =?iso-8859-1?b?QWFt5XM=?= <aamas@stud.ntnu.no>
Subject: snd_pcm_avail_update returns bogus values with the OSS
	PCM plugin
Date: Fri, 10 Jul 2009 10:29:55 +0200
Message-ID: <20090710102955.eaqs4fpsows0swwg@webmail.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bene2.itea.ntnu.no (bene2.itea.ntnu.no [129.241.56.57])
	by alsa0.perex.cz (Postfix) with ESMTP id 61F5C24565
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Jul 2009 10:29:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by bene2.itea.ntnu.no (Postfix) with ESMTP id AB84290009
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Jul 2009 10:29:55 +0200 (CEST)
Received: from webmail.ntnu.no (textus11.itea.ntnu.no [129.241.56.161])
	by bene2.itea.ntnu.no (Postfix) with ESMTP id 3279890008
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Jul 2009 10:29:55 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi.

For the attached test case snd_pcm_avail_update returns values higher  =

than the buffer size when run with the OSS PCM plugin. Output of  =

alsa-info.sh is at
http://www.alsa-project.org/db/?f=3D77a873e55d5d6ca50d67a035a9d6b7e10cca179=
d .

--- alsa_oss_pcm_avail_bug.c ---
/*
  * Public domain test case to illustrate a bug in the ALSA OSS PCM plugin
  * where snd_pcm_avail_update returns bogus values.
  */

#include <alsa/asoundlib.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static short buf[803 * 2];
static snd_pcm_t *pcm_handle =3D NULL;

void close_pcm(void)
{
	if (pcm_handle)
		snd_pcm_close(pcm_handle);

	pcm_handle =3D NULL;
}

static int set_pcm_parameters(void) {
	snd_pcm_hw_params_t *hwparams;
	snd_pcm_hw_params_alloca(&hwparams);

	if (snd_pcm_hw_params_any(pcm_handle, hwparams) < 0) {
		fprintf(stderr, "snd_pcm_hw_params_any failed.\n");
		return -1;
	}

	if (snd_pcm_hw_params_set_access(pcm_handle, hwparams,
				SND_PCM_ACCESS_RW_INTERLEAVED) < 0) {
		fprintf(stderr, "snd_pcm_hw_params_set_access failed.\n");
		return -1;
	}

	if (snd_pcm_hw_params_set_format(pcm_handle, hwparams,
				SND_PCM_FORMAT_S16) < 0) {
		fprintf(stderr, "snd_pcm_hw_params_set_format failed.\n");
		return -1;
	}

	{
		unsigned rate =3D 48000;

		if (snd_pcm_hw_params_set_rate_near(pcm_handle, hwparams,
					&rate, 0) < 0) {
			fprintf(stderr, "snd_pcm_hw_params_set_rate_near failed.\n");
			return -1;
		}
	}

	if (snd_pcm_hw_params_set_channels(pcm_handle, hwparams, 2) < 0) {
		fprintf(stderr, "snd_pcm_hw_params_set_channels failed.\n");
		return -1;
	}

	{
		unsigned ulatency =3D 100000;

		if (snd_pcm_hw_params_set_buffer_time_near(pcm_handle,
					hwparams, &ulatency, 0) < 0) {
			fprintf(stderr, "snd_pcm_hw_params_set_buffer_time_near failed.\n");
			return -1;
		}
	}

	if (snd_pcm_hw_params(pcm_handle, hwparams) < 0) {
		fprintf(stderr, "snd_pcm_hw_params failed.\n");
		return -1;
	}

	{
		snd_pcm_uframes_t bSize =3D 0;

		if (snd_pcm_hw_params_get_buffer_size(hwparams, &bSize) < 0) {
			fprintf(stderr, "snd_pcm_hw_params_get_buffer_size failed\n");
			return -1;
		}

		printf("buffer_size: %u\n", (unsigned int) bSize);
	}

	return 0;
}

static void test_loop(int n) {
	while (n--) {
		snd_pcm_sframes_t sframes =3D snd_pcm_avail_update(pcm_handle);
		printf("snd_pcm_avail: %d\n", (int) sframes);
		printf("writing %d frames\n", (int) sizeof(buf) / 4);
		sframes =3D snd_pcm_writei(pcm_handle, buf, sizeof(buf) / 4);

		if (sframes !=3D sizeof(buf) / 4) {
			if (sframes < 0)
				snd_pcm_prepare(pcm_handle);

			printf("snd_pcm_writei returned %d\n", (int) sframes);
		}
	}
}

int main(int argc, char **argv)
{
	atexit(close_pcm);

	if (argc < 2) {
		printf("usage: %s <ALSA pcm device>\n", argv[0]);
		return 0;
	}

	if (snd_pcm_open(&pcm_handle, argv[1],
				SND_PCM_STREAM_PLAYBACK, 0) < 0) {
		fprintf(stderr, "Error opening PCM device %s\n", argv[1]);
		pcm_handle =3D NULL;
		return -1;
	}

	if (set_pcm_parameters() < 0)
		return -1;

	memset(buf, 0, sizeof(buf));

	test_loop(500);

	return 0;
}

--
Sindre Aam=E5s
