From: Joshua Haberman <joshua@haberman.com>
Subject: snd_pcm_start fails
Date: Thu, 4 Jul 2002 15:06:31 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020704220631.GA23530@reverberate.org>
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
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I am stumped.  This short and simple program fails for me:

---

#include <alsa/asoundlib.h>

#include <assert.h>

#define NOFAIL == 0 || (assert(0), 1)

int main() {
    snd_pcm_t *playback_handle;
    snd_pcm_hw_params_t *hw_params;
    snd_output_t *debug;

    snd_output_stdio_attach(&debug, stdout, 0) NOFAIL;

    /* I have tried both hw:0 and plughw:0 */
    snd_pcm_open( &playback_handle, "hw:0", SND_PCM_STREAM_PLAYBACK, 0) NOFAIL;

    snd_pcm_hw_params_malloc( &hw_params ) NOFAIL;

    snd_pcm_hw_params_any( playback_handle, hw_params ) NOFAIL;
    snd_pcm_hw_params_set_access( playback_handle, hw_params, SND_PCM_ACCESS_MMAP_INTERLEAVED ) NOFAIL;
    snd_pcm_hw_params_set_format( playback_handle, hw_params,SND_PCM_FORMAT_S16 ) NOFAIL;
    snd_pcm_hw_params_set_rate( playback_handle, hw_params, 44100, 0 ) NOFAIL;
    snd_pcm_hw_params_set_channels( playback_handle, hw_params, 2 ) NOFAIL;
    snd_pcm_hw_params_set_period_size( playback_handle, hw_params, 2048, 0 ) NOFAIL;
    snd_pcm_hw_params( playback_handle, hw_params ) NOFAIL;

    snd_pcm_prepare( playback_handle ) NOFAIL;
    snd_pcm_dump( playback_handle, debug );
    snd_pcm_start( playback_handle ) NOFAIL;
}

---

Everything seems to be in good shape up until the call to snd_pcm_start,
but then the snd_pcm_start fails.  Here is the output:

---

Hardware PCM card 0 'Sound Blaster Live!' device 0 subdevice -1

Its setup is:
stream       : PLAYBACK
access       : MMAP_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 2
rate         : 44100
exact rate   : 44100 (44100/1)
msbits       : 16
buffer_size  : 16384
period_size  : 2048
period_time  : 46439
tick_time    : 10000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 2048
xfer_align   : 2048
start_threshold  : 1
stop_threshold   : 16384
silence_threshold: 0
silence_size : 0
boundary     : 1073741824
ALSA lib pcm_hw.c:384:(snd_pcm_hw_start) SNDRV_PCM_IOCTL_START failed: Broken pipe
display: display.c:29: main: Assertion `0' failed.
Aborted

---

Any ideas??  This is ALSA 0.9.0rc1, kernel 2.4.17, emu10k1 as you can
see.  Other ALSA apps such as alsaplayer and JACK work fine.

Josh


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Caffeinated soap. No kidding.
http://thinkgeek.com/sf
