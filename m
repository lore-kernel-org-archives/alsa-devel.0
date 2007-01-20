From: Gregor Jasny <jasny@vidsoft.de>
Subject: ICH5 + plughw: off-by-one in maximum periods and
	period size?
Date: Sat, 20 Jan 2007 14:16:46 +0100
Message-ID: <20070120131645.GB14691@vidsoft.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="fUYQa+Pmc3FrFX/N"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I've got an interesting issue (bug?) with my Intel ICH5 soundcard.

In my application I'm using the maximum period size and number of
periods. I query them with the accordig _max funktions and set them with
the _near function. At some devices I've noticed that the used number is
exactly one unit smaller than the queried maximum.

I'va attached a testcase program. The output on my system:

Requested priod size: 5462, got 5461
Requested priods: 1, got 0

Notice the 0 periods which seems weird to the application.

The real hw params set:
access: MMAP_INTERLEAVED
format: S16_LE
subformat: STD
channels: 2
rate: 48000 (48000/1)
period_size: 32767
buffer_size: 32767
tick_time: 4000

My Hardware:
Intel Corporation 82801EB/ER (ICH5/ICH5R) AC'97 Audio Controller (rev
02)
ICH4 - Intel ICH5
Intel ICH5 with AD1985 at 0xfebff400, irq 20

Software:
Kernel: Latest 2.6.20-rc5 git snapshot
Driver: Version 1.0.14rc1
libasound: Debian Etch 1.0.13-1

Is this behaviour a bug, a rounding issue inside of the plughw stuff or
a known limitation of the plughw device?

Thanks,
Gregor

--fUYQa+Pmc3FrFX/N
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="offbyone.c"

#include <stdio.h>
#include <unistd.h>

#include <alsa/asoundlib.h>

int main (int argc, char *argv[])
{
	const char device[] = "plughw:0,3";
	int err;

	snd_pcm_t *pcm_device;
	snd_pcm_hw_params_t *hw_params;

	snd_pcm_uframes_t period_size, period_size_max;
	unsigned int periods, periods_max;

	if ((err = snd_pcm_open (&pcm_device, device, SND_PCM_STREAM_CAPTURE, 0)) < 0) {
		fprintf (stderr, "cannot open audio device %s (%s)\n",
                device,
                snd_strerror (err));
		exit (1);
	}       

	if (snd_pcm_hw_params_malloc (&hw_params) < 0) {
		fprintf (stderr, "Can't allocate memory for hw_params.\n");
		exit (1);
	}

	// init hw params
	if ((err = snd_pcm_hw_params_any (pcm_device, hw_params)) < 0) {
	  fprintf (stderr, "cannot initialize hardware parameter structure (%s)\n", snd_strerror (err));
	  return err;
	}

	// access mode
	if ((err = snd_pcm_hw_params_set_access (pcm_device, hw_params, SND_PCM_ACCESS_RW_INTERLEAVED)) < 0) {
	  fprintf (stderr, "cannot set access type (%s)\n", snd_strerror (err));
	  return err;
	}
	
	// format
	if ((err = snd_pcm_hw_params_set_format (pcm_device, hw_params, SND_PCM_FORMAT_U8)) < 0) {
	  fprintf (stderr, "cannot set sample format %s (%s)\n", snd_pcm_format_name(SND_PCM_FORMAT_U8), snd_strerror (err));
	  return err;
	}

	// rate
	if ((err = snd_pcm_hw_params_set_rate (pcm_device, hw_params, 8000, 0)) < 0) {
	  fprintf (stderr, "cannot set sample rate (%s)\n", snd_strerror (err));
	  return err;
	}
	
	// channels
	if ((err = snd_pcm_hw_params_set_channels (pcm_device, hw_params, 1)) < 0) {
	  fprintf (stderr, "cannot set channel count %u (%s)\n", 1, snd_strerror (err));
	  return err;
	}
	
	// period size
        if ((err = snd_pcm_hw_params_get_period_size_max(hw_params, &period_size_max, 0)) < 0) {
	  fprintf (stderr, "cannot get max period size (%s)\n", snd_strerror (err));
	  return err;
        }
	
	period_size = period_size_max;
	
	if ((err = snd_pcm_hw_params_set_period_size_near(pcm_device, hw_params, &period_size, 0)) < 0) {
	  fprintf (stderr, "cannot set period_size (%s)\n", snd_strerror (err));
	  return err;
	}
	
	if (period_size != period_size_max) {
	  fprintf (stderr, "Requested priod size: %lu, got %lu\n", period_size_max, period_size);
	}
	
	// periods
        if ((err = snd_pcm_hw_params_get_periods_max(hw_params, &periods_max, 0)) < 0) {
	  fprintf (stderr, "cannot get max periods (%s)\n", snd_strerror (err));
	  return err;
        }
	
	periods = periods_max;
#if 1
	if ((err = snd_pcm_hw_params_set_periods_near(pcm_device, hw_params, &periods, NULL)) < 0) {
	  fprintf (stderr, "cannot set periods_near (%s)\n", snd_strerror (err));
	  return err;
	}
#else
	if ((err = snd_pcm_hw_params_set_periods(pcm_device, hw_params, periods, 0)) < 0) {
	  fprintf (stderr, "cannot set periods (%s)\n", snd_strerror (err));
	  return err;
	}
#endif
	
	if (periods != periods_max) {
	  fprintf (stderr, "Requested priods: %u, got %u\n", periods_max, periods);
	}

	// set params
	if ((err = snd_pcm_hw_params (pcm_device, hw_params)) < 0) {
	  fprintf (stderr, "cannot set parameters (%s)\n", snd_strerror (err));
	  return err;
	}

	sleep (100);
       
	return 0;
}

--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--fUYQa+Pmc3FrFX/N--
