From: Theo Veenker <Theo.Veenker@let.uu.nl>
Subject: assertion failure in snd_pcm_plugin_mmap_commit
Date: Wed, 24 Sep 2003 17:59:13 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F71BF51.80209@let.uu.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060908040409090405030904"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------060908040409090405030904
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

I'm trying to play sampled data on my RME Digi96/8 PAD card using
the plughw:0,0 plugin. It works (of course it does) but not with
a sampling rate that is not supported by the hardware. My test
program (see attachment) bombs out due to an assertion failure:
pcm_plugin.c:525: snd_pcm_plugin_mmap_commit: Assertion `size == 0' failed.

This is the snd_pcm_plugin_mmap_commit() routine in alsa-lib
pcm_plugin.c:

snd_pcm_sframes_t snd_pcm_plugin_mmap_commit(pcm, offset, size)
{
	.
	.
	slave_size = snd_pcm_avail_update(slave);
	while (size > 0 && slave_size > 0) {
		.
		.
		.
		size -= frames;
		slave_size -= frames;
	}
	assert(size == 0);
}

After studying this routine I decided to uncomment the assert()
because to it seems to me the assertion will always fail if
size and slave_size are not the same before entering the while
loop.

After commenting out the assert() the test program runs fine, as
far as I can tell. I presume however there is a reason for this
assertion and probably it shouldn't be removed. But in that case
I would like to know what else could be wrong.

Regards,
Theo

--------------060908040409090405030904
Content-Type: text/plain;
 name="prob.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="prob.c"

/*
    prob.c

    This test program bombs out with assertion failure
      pcm_plugin.c:525: snd_pcm_plugin_mmap_commit: Assertion `size == 0' failed.
    when sample rate is set to a value not supported by the card (32000,
    48000 OK, 16000, 11025 etc not OK).

    Sound card RME Digi96/8 PAD
    ALSA 0.9.6
    plugin plughw:0,0
    
    gcc -o prob prob.c -lasound
*/

#include <stdio.h>
#include <math.h>
#define ALSA_PCM_NEW_HW_PARAMS_API
#define ALSA_PCM_NEW_SW_PARAMS_API
#include <alsa/asoundlib.h>

#define BUFFER_TIME 		500	// [ms]

snd_pcm_t* handle;
unsigned int nchannels;
unsigned int samplerate;
unsigned int periodsize;
unsigned int buffersize;
unsigned int nperiods;

int setHWParams(snd_pcm_hw_params_t* hwparams, unsigned int nch, unsigned int rate)
{
    int err;
    snd_pcm_uframes_t val;

    // Choose all hardware parameters.
    err = snd_pcm_hw_params_any(handle, hwparams);
    if (err < 0) {
    	fprintf(stderr, "No playback configurations available: %s\n", snd_strerror(err));
	return -1;
    }

    // Set access type: interleaved
    err = snd_pcm_hw_params_set_access(handle, hwparams, SND_PCM_ACCESS_RW_INTERLEAVED);
    if (err < 0) {
    	fprintf(stderr, "Interleaved access not available: %s\n", snd_strerror(err));
	return -1;
    }

    // Set sample format: float
    err = snd_pcm_hw_params_set_format(handle, hwparams, SND_PCM_FORMAT_FLOAT);
    if (err < 0) {
	fprintf(stderr, "Float sample format not available: %s\n", snd_strerror(err));
	return -1;
    }

    // Set number of channels: nch
    nchannels = nch;
    err = snd_pcm_hw_params_set_channels(handle, hwparams, nch);
    if (err < 0) {
	fprintf(stderr, "Unsupported number of channels (%u): %s\n", nch, snd_strerror(err));
	return -1;
    }

    // Set sampling rate: rate
    samplerate = rate;
    err = snd_pcm_hw_params_set_rate_near(handle, hwparams, &rate, 0);
    if (err < 0) {
    	fprintf(stderr, "Unsupported sampling rate (%u Hz): %s\n", rate, snd_strerror(err));
	return -1;
    }
    if (rate != samplerate) {
	fprintf(stderr, "Requested sampling rate %u Hz, got %u Hz.\n", samplerate, rate);
    }
    samplerate = rate;

    // Set period size: lowest supported value
    snd_pcm_hw_params_get_period_size_min(hwparams, &val, 0);
    err = snd_pcm_hw_params_set_period_size_near(handle, hwparams, &val, 0);
    if (err < 0) {
	fprintf(stderr, "Unable to set period size to %u: %s\n", (int)val, snd_strerror(err));
	return -1;
    }
    err = snd_pcm_hw_params_get_period_size(hwparams, &val, 0);
    if (err > 0) {
	fprintf(stderr, "Unable to get period size: %s\n", snd_strerror(err));
	return -1;
    }
    periodsize = val;

    // Set number of periods: about BUFFER_TIME / periodtime
    nperiods = (BUFFER_TIME * samplerate / 1000) / periodsize;
    err = snd_pcm_hw_params_set_periods_near(handle, hwparams, &nperiods, 0);
    if (err < 0) {
	fprintf(stderr, "Unable to set number of periods to %u: %s\n", nperiods, snd_strerror(err));
	return -1;
    }
    err = snd_pcm_hw_params_get_periods(hwparams, &nperiods, 0);
    if (err > 0) {
	fprintf(stderr, "Unable to get number of periods: %s\n", snd_strerror(err));
	return -1;
    }

    // Get buffer size.
    err = snd_pcm_hw_params_get_buffer_size(hwparams, &val);
    if (err < 0) {
	fprintf(stderr, "Unable to get buffer size: %s\n", snd_strerror(err));
	return -1;
    }
    buffersize = val;

    // Write hardware parameters to device.
    err = snd_pcm_hw_params(handle, hwparams);
    if (err < 0) {
	fprintf(stderr, "Unable to set hardware parameters: %s\n", snd_strerror(err));
	return -1;
    }

    printf("num channels: %u\n", nchannels);
    printf("sample rate:  %u\n", samplerate);
    printf("buffer size:  %u\n", buffersize);
    printf("period size:  %u\n", periodsize);
    printf("num periods:  %u\n", nperiods);

    return 0;
}

int setSWParams(snd_pcm_sw_params_t* swparams)
{
    int err;

    // Get current software parameters.
    err = snd_pcm_sw_params_current(handle, swparams);
    if (err < 0) {
	fprintf(stderr, "Unable to determine current software parameters: %s\n", snd_strerror(err));
	return -1;
    }

    // Start transfer when one complete period is available.
    err = snd_pcm_sw_params_set_start_threshold(handle, swparams, periodsize);
    if (err < 0) {
	fprintf(stderr, "Unable to set start threshold: %s\n", snd_strerror(err));
	return -1;
    }

    // Allow transfer when at least one period is available.
    err = snd_pcm_sw_params_set_avail_min(handle, swparams, periodsize);
    if (err < 0) {
	fprintf(stderr, "Unable to set min avail: %s\n", snd_strerror(err));
	return -1;
    }

    // Align all transfers to 1 sample.
    err = snd_pcm_sw_params_set_xfer_align(handle, swparams, 1);
    if (err < 0) {
    	fprintf(stderr, "Unable to set transfer align: %s\n", snd_strerror(err));
	return -1;
    }

    // Write software parameters to device.
    err = snd_pcm_sw_params(handle, swparams);
    if (err < 0) {
	fprintf(stderr, "Unable to set software parameters: %s\n", snd_strerror(err));
	return -1;
    }

    return 0;
}

int openPCM(unsigned int nch, unsigned int rate)
{
    int err;
    snd_pcm_hw_params_t* hwparams;
    snd_pcm_sw_params_t* swparams;

    if ((err = snd_pcm_open(&handle, "plughw:0,0", SND_PCM_STREAM_PLAYBACK, 0)) < 0) {
	fprintf(stderr, "Playback open error: %s\n", snd_strerror(err));
	return err;
    }

    snd_pcm_hw_params_malloc(&hwparams);
    err = setHWParams(hwparams, nch, rate);
    snd_pcm_hw_params_free(hwparams);
    if (err) {
    	snd_pcm_close(handle);
	return err;
    }

    snd_pcm_sw_params_malloc(&swparams);
    err = setSWParams(swparams);
    snd_pcm_sw_params_free(swparams);
    if (err) {
    	snd_pcm_close(handle);
	return err;
    }

    return 0;
}

void play(const float* data, unsigned int nframes)
{
    int xrun = 0;
    while (nframes > 0) {
    	int cnt = snd_pcm_writei(handle, data, nframes);
//	printf("cnt = %d\n", cnt);
    	if (cnt < 0) {
	    if (cnt == -EAGAIN) continue;
	    if (cnt == -EPIPE) {
	    	snd_pcm_prepare(handle);
		if (++xrun <= 1) continue;
	    }
	    fprintf(stderr, "Error playing sampled data: %s.\n", snd_strerror(cnt));
	    break;
    	}
	data += cnt * nchannels;
	nframes -= cnt;
    }
}

int main(void)
{
    double Fs, Ts, t = 0.0, amp = 0.9;
    int NS, n;
    float* s;

    if (openPCM(1, 16000) != 0) return -1;

    Fs = samplerate;
    Ts = 1.0 / Fs;
    NS = (int)(1.0 * Fs + 0.5);
    s = (float*)malloc(NS * sizeof(float));

    for (n = 0; n < NS; n++) {
        s[n] = amp * sin(2.0 * M_PI * 1000.0 * t);
	t = t + Ts;
    }

    play(s, NS);

    snd_pcm_drain(handle);
    snd_pcm_close(handle);

    return 0;
}

--------------060908040409090405030904--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
