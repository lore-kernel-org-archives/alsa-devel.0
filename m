From: alsa@zevv.nl
Subject: Need a little help with underruns / fullduplex
Date: Fri, 20 Jun 2003 21:14:13 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030620191413.GE4116@pruts.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Hi all,

I'm trying to build a full-duplex app using alsa, but I'm having some
problems with getting buffsersizes and timing right. I can't get a simple 
record-and-playback app working right without underruns occuring.

I hope some experienced alsa programmers can take a quick look at my
attached piece of code and tell me what I need to do to get this working
right. (or am I just doing things *really* wrong here ?)

Hope to get some helpfull tips,

Ico




os : linx 2.4.20
alsa version: 0.9.4
soundcard: intel810

-----------------------------------------------------------------------------

#include <stdio.h>
#include <sys/time.h>
#include <time.h>
#include <sys/select.h>

#define ALSA_PCM_NEW_HW_PARAMS_API
#define ALSA_PCM_NEW_SW_PARAMS_API
#include <alsa/asoundlib.h>
#include <math.h>

#define PERIODSIZE 512
#define BUFSIZE	(PERIODSIZE*4)

char *device	= "hw:0,0";
int samplerate 	= 16000;
int channels 	= 2;
int accessmode	= SND_PCM_ACCESS_RW_INTERLEAVED;
int format	= SND_PCM_FORMAT_S16_LE;
int periods	= 4;
snd_pcm_uframes_t buffer_size = PERIODSIZE * 4;
snd_pcm_uframes_t period_size = PERIODSIZE;

snd_output_t *output = NULL;


#define checkr(r) if(r<0) { \
			fprintf(stderr, "line %d: %s\n", __LINE__, snd_strerror(r)); \
			exit(-1); \
		  }


int set_hw_params(snd_pcm_t *handle, int play)
{
	int r;
	snd_pcm_hw_params_t *hwparams;
	snd_pcm_sw_params_t *swparams;
	
	r = snd_pcm_hw_params_malloc(&hwparams); checkr(r);
	r = snd_pcm_hw_params_any(handle, hwparams); checkr(r);
	r = snd_pcm_hw_params_set_access(handle, hwparams, accessmode);	checkr(r);
	r = snd_pcm_hw_params_set_format(handle, hwparams, format); checkr(r);
	r = snd_pcm_hw_params_set_channels(handle, hwparams, channels); checkr(r);
	r = snd_pcm_hw_params_set_rate_near(handle, hwparams, &samplerate, 0); checkr(r);
	r = snd_pcm_hw_params_set_periods(handle, hwparams, periods, 0); checkr(r);
	r = snd_pcm_hw_params_set_buffer_size_near(handle, hwparams, &buffer_size); checkr(r);
	r = snd_pcm_hw_params_set_period_size_near(handle, hwparams, &period_size, 0); checkr(r);
	r = snd_pcm_hw_params(handle, hwparams); checkr(r);
	snd_pcm_hw_params_free (hwparams);

	r = snd_pcm_sw_params_malloc(&swparams); checkr(r);
	r = snd_pcm_sw_params_current(handle, swparams); checkr(r);
	r = snd_pcm_sw_params_set_avail_min(handle, swparams, period_size); checkr(r);
	r = snd_pcm_sw_params(handle, swparams); checkr(r);
	snd_pcm_sw_params_free(swparams);

	snd_pcm_prepare(handle);
	
	return(0);
}

int main(int argc, char **argv)
{
	short buf[BUFSIZE*10];
	int r;
	
	snd_pcm_t *pcmr;
	snd_pcm_t *pcmp;
	
	r = snd_pcm_open(&pcmr, device, SND_PCM_STREAM_CAPTURE, 0); checkr(r);
	set_hw_params(pcmr, 1);	

	r = snd_pcm_open(&pcmp, device, SND_PCM_STREAM_PLAYBACK, 0); checkr(r);
	set_hw_params(pcmp, 1);

	while(1) {
		
		r = snd_pcm_readi(pcmr, buf, BUFSIZE);

		if(r != BUFSIZE) printf("rec  r=%d\n", r);
		checkr(r);

		r = snd_pcm_writei(pcmp, buf, BUFSIZE);

		if(r != BUFSIZE) printf("play r=%d\n", r);
		if(r == -EPIPE) {
			snd_pcm_prepare(pcmp);
		} else {
			checkr(r);
		}

	}
		
	return(0);
}


-- 


-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
