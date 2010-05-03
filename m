From: Timo Schneider <timo.schneider@s2004.tu-chemnitz.de>
Subject: How to play a sine wave in alsa?
Date: Tue, 04 May 2010 00:07:11 +0200
Message-ID: <1272924431.7701.1.camel@tesla.perlplexity.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from jack.hrz.tu-chemnitz.de (jack.hrz.tu-chemnitz.de
	[134.109.132.46])
	by alsa0.perex.cz (Postfix) with ESMTP id 13C882472A
	for <alsa-devel@alsa-project.org>;
	Tue,  4 May 2010 00:03:32 +0200 (CEST)
Received: from [89.246.190.161] (helo=[192.168.1.100])
	by jack.hrz.tu-chemnitz.de with esmtpsa (SSLv3:AES256-SHA:256)
	(Exim 4.69) (envelope-from <timo.schneider@s2004.tu-chemnitz.de>)
	id 1O93je-0003yB-BE
	for alsa-devel@alsa-project.org; Tue, 04 May 2010 00:03:31 +0200
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

Hello!

I am trying to use alsa to play a sine wave in async mode. Everything
seems to work fine, except what I am hearing is _not_ a sine wave. I am
checking for XRUNs, but none occur, so I guess the problem is that I am
supplying the wrong sample data to alsa.

I want the tone only on one channel, that seems to work fine the way i
do it, so i guess my assumptions on how the interleaved mode works are
not completely wrong.

Can anyone give me a hint on what I am doing wrong in the example
program below? I already checked the example in tests/pcm.c but it
didn't really help me.

Regards,
Timo

Example Program (compile with cc test.c -o test -lasound): 

#include <math.h>
#include <stdlib.h>
#include <inttypes.h>
#include <alsa/asoundlib.h>

struct sound_settings {
	
	// alsa parameters
	snd_pcm_t *pcm_handle;
	snd_pcm_hw_params_t *hw_params;
	snd_pcm_sw_params_t *sw_params;
	snd_async_handler_t *pcm_callback;
	snd_pcm_uframes_t buffer_size;
	snd_pcm_uframes_t period_size;
	unsigned int sample_rate;
	char *sample_buffer;
	size_t sample_buffer_size;

	// user settings made in gui	
	char *cardname;
	char *modename;
	int startfreq;
	int endfreq;
	int duration;
	int channels;

	// keep track of gnerated samples
	long int actsample;	
	long int lastsample;

};

struct sound_settings sdata;

void generate_samples(struct sound_settings *sdata) {
	
	int i = 0;
	
	if (sdata->channels == 1) i=0;
	if (sdata->channels == 2) i=1;
	if (sdata->channels == 3) i=0;

	if (strcmp(sdata->modename, "Sine")==0) {
		
		while (i<(sdata->sample_buffer_size / 8)) {
			int samplerate = 44100;
			int freq = sdata->startfreq;
			double sample = sin(sdata->actsample * (double) 2*M_PI / ((double)
samplerate / (double)freq));
			int16_t rsamp = sample * 65535;
			sdata->actsample++;
			*(((int16_t*) (sdata->sample_buffer))+i) = rsamp;
			i += 2;
		}

	}
}

void MyCallback(snd_async_handler_t *pcm_callback) {

	snd_pcm_t *pcm_handle = snd_async_handler_get_pcm(pcm_callback);
	snd_pcm_sframes_t avail;
	struct sound_settings *sdata = (struct sound_settings*)
snd_async_handler_get_callback_private(pcm_callback);

	avail = snd_pcm_avail_update(pcm_handle);
	if (avail == -EPIPE) {
		snd_pcm_prepare (pcm_handle);
		printf("Underrun occured\n");
	}
	while (avail >= sdata->period_size) {
		generate_samples(sdata);
		snd_pcm_writei(pcm_handle, sdata->sample_buffer, sdata->period_size);
		avail = snd_pcm_avail_update(pcm_handle);
	}

}

void init_alsa(struct sound_settings *sdata) {

	int rc;

	// set some sound_settings data (i.e., sample_rate) to sensible
defaults
	sdata->buffer_size = 1024;
	sdata->period_size = 64;
	sdata->sample_rate = 44100;

	// Open PCM device for playback
	rc = snd_pcm_open(&(sdata->pcm_handle), "default",
SND_PCM_STREAM_PLAYBACK, 0); 
	if (rc < 0) fprintf(stderr, "unable to open pcm device: %s\n",
snd_strerror(rc));

	// Allocate a hardware parameters object
	snd_pcm_hw_params_malloc (&(sdata->hw_params));
	snd_pcm_hw_params_any(sdata->pcm_handle, sdata->hw_params);
	snd_pcm_hw_params_set_access(sdata->pcm_handle, sdata->hw_params,
SND_PCM_ACCESS_RW_INTERLEAVED);
	snd_pcm_hw_params_set_format(sdata->pcm_handle, sdata->hw_params,
SND_PCM_FORMAT_S16_LE);
	snd_pcm_hw_params_set_channels(sdata->pcm_handle, sdata->hw_params, 2);
	snd_pcm_hw_params_set_rate_near(sdata->pcm_handle, sdata->hw_params,
&(sdata->sample_rate), NULL);
	snd_pcm_hw_params_set_buffer_size_near(sdata->pcm_handle,
sdata->hw_params, &(sdata->buffer_size));
	snd_pcm_hw_params_set_period_size_near (sdata->pcm_handle,
sdata->hw_params, &(sdata->period_size), NULL);
	rc = snd_pcm_hw_params(sdata->pcm_handle, sdata->hw_params);
	if (rc < 0) fprintf(stderr, "unable to set hw parameters: %s\n",
snd_strerror(rc));

	// tell alsa we want to work asynchronously
	snd_pcm_sw_params_malloc(&(sdata->sw_params));
	snd_pcm_sw_params_current(sdata->pcm_handle, sdata->sw_params);
	snd_pcm_sw_params_set_start_threshold(sdata->pcm_handle,
sdata->sw_params, sdata->buffer_size - sdata->period_size);
	snd_pcm_sw_params_set_avail_min(sdata->pcm_handle, sdata->sw_params,
sdata->period_size);
	rc = snd_pcm_sw_params(sdata->pcm_handle, sdata->sw_params);
	if (rc < 0) fprintf(stderr, "unable to set sw parameters: %s\n",
snd_strerror(rc));

	// Use a buffer large enough to hold two periods
	snd_pcm_hw_params_get_period_size(sdata->hw_params,
&(sdata->period_size), NULL);
	sdata->sample_buffer_size = sdata->period_size * 8; // 2 bytes/sample,
2 channels, two periods
	sdata->sample_buffer = (char *) malloc(sdata->sample_buffer_size);
	
	generate_samples(sdata);

	// prepare dev so that we can write
	snd_pcm_prepare(sdata->pcm_handle);
	
	/* fill buffer with some data */
	generate_samples(sdata);

	/* write first chunk of data */
	rc = snd_pcm_writei(sdata->pcm_handle, sdata->sample_buffer,
sdata->period_size);
	if (rc == -EPIPE) snd_pcm_prepare(sdata->pcm_handle);

	/* register callback */
	rc = snd_async_add_pcm_handler(&(sdata->pcm_callback),
sdata->pcm_handle, MyCallback, sdata);
	snd_pcm_start(sdata->pcm_handle);


}

int main(int argc, char **argv) {

	sdata.channels = 1;
	sdata.modename = "Sine";
	sdata.startfreq = 220;
	sdata.actsample = 0;
	init_alsa(&sdata);

	static int i=0;
	while (i<1000000) {
		i++;
		sleep(1);
	}
	
	return 0;
}
