From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v3 1/3] ASoC: davinci-mcasp: Constraint on
 the period and buffer size based on FIFO usage
Date: Tue, 25 Mar 2014 12:07:58 +0200
Message-ID: <5331557E.9020908@ti.com>
References: <1395148837-20850-1-git-send-email-peter.ujfalusi@ti.com>
 <1395148837-20850-2-git-send-email-peter.ujfalusi@ti.com>
 <532848D5.30806@ti.com> <53285827.1070709@ti.com>
 <20140318180732.GJ11706@sirena.org.uk> <53297BEE.4050903@ti.com>
 <20140319131457.GK11706@sirena.org.uk> <532AF15A.4090506@ti.com>
 <532AF7E7.8060702@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010904050008030300050708"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id BDEF4262610
 for <alsa-devel@alsa-project.org>; Tue, 25 Mar 2014 11:08:04 +0100 (CET)
In-Reply-To: <532AF7E7.8060702@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, nsekhar@ti.com, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, zonque@gmail.com, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

--------------010904050008030300050708
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 03/20/2014 04:15 PM, Lars-Peter Clausen wrote:
> That sounds like a bug in either the kernel or alsa-lib. We do have a r=
ule in
> place that specifies that the buffer size needs to be a integer multipl=
e of
> the period size and we have a rule in place that the period size needs =
to be a
> multiple of a constant C. Hence ALSA should be able to deduce that the =
buffer
> size needs to be at least a multiple of min_periods * C. We probably sh=
ould
> fix this for good and not workaround it in individual drivers. Do you t=
hink
> you can put together a small standalone test application that shows the=
 issue?

Now that I have 'wasted' quite some time with this I ended up writing the=
 tool
to test the issue.

It is a simple tool which:
opens the hw:0,0 (you can pass another PCM to open).
Goes and tests 44.1, 88.2, 48 and 96 KHz from 0.1s to 1s buffer time with
0.005s steps.
It prints the running test and tells if the combination failed or not. If=
 it
is OK, it is going to print the resulting buffer time.

Since the output is long for email they are in pastebin.

On am335x-evmsk only period_step =3D 32 constraint is placed by the McASP=
 driver:
http://pastebin.com/C81uQkJd

When both period_step and buffer_step is set to 32:
http://pastebin.com/D8hr3bQ1

As a note: if I run this tool on my desktop/laptop it does fail in some
combination there as well with hd_intel. What is even more interesting is=
 that
I have less failure cases with hda_intel on 64bit machines then on my old
macbook1,1 which is 32bit Linux. Basically the mcabook,1,1 behaves simila=
rly
like my am335x (when I change the hda_intel driver to place only period_s=
tep =3D
32 constraint)

--=20
P=E9ter

--------------010904050008030300050708
Content-Type: text/x-csrc; name="constraint.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="constraint.c"

#ifndef _GNU_SOURCE
#define _GNU_SOURCE
#endif

#include <stdio.h>
#include <alsa/asoundlib.h>

#define BUFFER_TIME_MIN		(100000)
#define BUFFER_TIME_MAX		(1000000)
#define BUFFER_TIME_STEP	(5000)

int try_alsa_setup(snd_pcm_t *pcm, unsigned int rate, unsigned int *buffer_time,
		   unsigned int *periods)
{
	int r;
	snd_pcm_hw_params_t *hwparams;

	snd_pcm_hw_params_alloca (&hwparams);

	r = snd_pcm_hw_params_any(pcm, hwparams);
	if (r < 0)
		return r;

	r = snd_pcm_hw_params_set_rate_resample(pcm, hwparams, 0);
	if (r < 0)
		return r;

	r = snd_pcm_hw_params_set_access(pcm, hwparams,
	                                  SND_PCM_ACCESS_RW_INTERLEAVED);
	if (r < 0)
		return r;

	r = snd_pcm_hw_params_set_format(pcm, hwparams,SND_PCM_FORMAT_S16_LE);
	if (r < 0)
		return r;

	r = snd_pcm_hw_params_set_rate_near(pcm, hwparams, &rate, NULL);
	if (r < 0)
		return r;

	r = snd_pcm_hw_params_set_channels(pcm, hwparams, 2);
	if (r < 0)
		return r;

	r = snd_pcm_hw_params_set_buffer_time_near(pcm, hwparams, buffer_time,
	                NULL);
	if (r < 0)
		return r;

	r = snd_pcm_hw_params_set_periods_near(pcm, hwparams, periods, NULL);
	if (r < 0)
		return r;

	r = snd_pcm_hw_params(pcm, hwparams);
	if (r < 0)
		return r;

	r = snd_pcm_hw_params_current(pcm, hwparams);
	if (r < 0)
		return r;

	return 0;
}

int main(int argc, char *argv[])
{
	const char *dev;
	snd_pcm_t *pcm;
	unsigned int rates[] = {44100, 88200, 48000, 96000, 0 };
	unsigned int periods = 10;
	unsigned int i;
	int r;

	dev = argc > 1 ? argv[1] : "hw:0,0";

	printf("Opening %s\n\n", dev);
	for (i = 0; rates[i]; i++) {
		unsigned int time = BUFFER_TIME_MIN;
		do {
			unsigned int buffer_time = time;
			r = snd_pcm_open(&pcm, dev, SND_PCM_STREAM_PLAYBACK, 0);
			if (r < 0) {
				printf("Failed to open %s\n", dev);
				return -1;
			}

			printf("Try of %dHz, %u us buffer: ", rates[i],
			       buffer_time);

			r = try_alsa_setup(pcm, rates[i], &buffer_time,
					   &periods);

			if (r < 0)
				printf("FAILED\n");
			else
				printf("OK (got %u us)\n", buffer_time);

			r = snd_pcm_close(pcm);
			if (r < 0) {
				printf("snd_pcm_close() failed %d\n", r);
				return r;
			}
			time += BUFFER_TIME_STEP;
		} while (time <= BUFFER_TIME_MAX);
	}

	printf("Done with %s\n\n", dev);
	return 0;
}

--------------010904050008030300050708
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------010904050008030300050708--
