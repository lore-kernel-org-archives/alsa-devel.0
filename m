From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd_pcm_wait()  More details required.
Date: Tue, 23 Mar 2004 13:33:02 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0403231325300.16790-100000@studcom.urz.uni-halle.de>
References: <Pine.LNX.4.58.0403221849440.12006@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mlucom10.urz.uni-halle.de (mlucom10.urz.Uni-Halle.DE [141.48.3.4])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id NAA29967
	for <alsa-devel@alsa-project.org>; Tue, 23 Mar 2004 13:33:07 +0100
In-reply-to: <Pine.LNX.4.58.0403221849440.12006@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: James Courtier-Dutton <James@superbug.demon.co.uk>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:

> On Mon, 22 Mar 2004, James Courtier-Dutton wrote:
>
> > My current tests were not using the resampler. i.e. app using 48k, sound
> > card using 48k. I will try some tests that would use the resampler.
>
> Then I need more info how I can reproduce the bug.

The following test program shows strange behaviour:

// ---------- bite off here ----------------------------------------
#include <alsa/asoundlib.h>

#define CHECK(command) do { \
	err = (command); \
	if (err < 0) { \
		printf("%s failed: %s\n", #command, snd_strerror(err)); \
		return 1; \
	} \
	} while (0)

int main(int argc, char *argv[])
{
	snd_pcm_t *pcm;
	snd_pcm_hw_params_t *hw_params;
	snd_pcm_sw_params_t *sw_params;
	int err;
	static char silence[12000 * 2 * 2];

	if (argc < 2) return 1;
	CHECK(snd_pcm_open(&pcm, argv[1], SND_PCM_STREAM_PLAYBACK, SND_PCM_NONBLOCK));
	snd_pcm_hw_params_alloca(&hw_params);
	CHECK(snd_pcm_hw_params_any(pcm, hw_params));
	CHECK(snd_pcm_hw_params_set_access(pcm, hw_params, SND_PCM_ACCESS_RW_INTERLEAVED));
	CHECK(snd_pcm_hw_params_set_format(pcm, hw_params, SND_PCM_FORMAT_S16));
	CHECK(snd_pcm_hw_params_set_channels(pcm, hw_params, 2));
	CHECK(snd_pcm_hw_params_set_rate(pcm, hw_params, 48000, 0));
	CHECK(snd_pcm_hw_params_set_buffer_size(pcm, hw_params, 12000));
	CHECK(snd_pcm_hw_params_set_period_size(pcm, hw_params, 6000, 0));
	CHECK(snd_pcm_hw_params(pcm, hw_params));
	snd_pcm_sw_params_alloca(&sw_params);
	CHECK(snd_pcm_sw_params_current(pcm, sw_params));
	CHECK(snd_pcm_sw_params_set_start_threshold(pcm, sw_params, 12000));
	CHECK(snd_pcm_sw_params_set_avail_min(pcm, sw_params, 6000));
	CHECK(snd_pcm_sw_params(pcm, sw_params));
	for (;;) {
		CHECK(snd_pcm_wait(pcm, 2000));
		if (err == 0)
			printf("timeout!\n");
		err = snd_pcm_writei(pcm, silence, 12000);
		if (err >= 0)
			printf("%d frames written\n", err);
		else if (err == -EAGAIN)
			printf("pcm not ready!\n");
		else
			CHECK(err);
	}
}
// ---------- bite off here ----------------------------------------

With an AC'97 device:

$ ./waittest hw:0
12000 frames written
6000 frames written
6000 frames written
6000 frames written
6000 frames written
...

$ ./waittest dmix:hw:0
timeout!
12000 frames written
pcm is not ready!
6000 frames written
6000 frames written
6000 frames written
6000 frames written
...

When running with dmix, the first call to snd_pcm_wait() times out
although the pcm is ready (it seems the hardware pcm is still stopped
and doesn't generate interrupts), and the second call to
snd_pcm_wait() returns 1 although the pcm is not yet ready.


Regards,
Clemens




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
