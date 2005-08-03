From: victor_lee@accton.com.tw
Subject: 8000 Hz PCM capture error
Date: Wed, 3 Aug 2005 20:05:03 +0800
Message-ID: <OFD043A611.D5AE961F-ON48257052.00408AD8-48257052.00426182@accton.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi there,

I just started to use ALSA two days ago. I plan to use ALSA to process
voice data
sent and received in RTP packets for a VoIP project.
I found two sample programs from:
http://www.linuxjournal.com/node/6735/print .
The two programs can record voice data and play it back nicely. I modified
the
rate setting in the "simple_record.c" program from 44100 to 8000. Then it
core
dumped when I ran it and gave the following error message:

simple_record: pcm_params.c:146: snd_pcm_hw_param_get_min: Assertion
`!snd_interval_empty(i)' failed.

I also modified the rate setting in the "simple_play.c" program that plays
back
the recorded voice data. And it runs ok. I looked through the document and
found
little clue.

May I ask for your help to tell me how to capture a single channel voice
data
into 8000 Hz PCM.

Thanks a lot..

Victor

/*
  This example reads from the default PCM device
  and writes to standard output for 5 seconds of data.
*/
/* Use the newer ALSA API */
#define ALSA_PCM_NEW_HW_PARAMS_API
#include <alsa/asoundlib.h>
int main() {
      long loops;
      int rc;
      int size;
      snd_pcm_t *handle;
      snd_pcm_hw_params_t *params;
      unsigned int val;
      int dir;
      snd_pcm_uframes_t frames;
      char *buffer;

      /* Open PCM device for recording (capture). */
      rc = snd_pcm_open(&handle, "default", SND_PCM_STREAM_CAPTURE, 0);
      if (rc < 0) {
            fprintf(stderr, "unable to open pcm device: %s\n",
snd_strerror(rc));
            exit(1);
      }

      snd_pcm_hw_params_alloca(&params);
      snd_pcm_hw_params_any(handle, params);

      snd_pcm_hw_params_set_access(handle, params,
SND_PCM_ACCESS_RW_INTERLEAVED);
      snd_pcm_hw_params_set_format(handle, params, SND_PCM_FORMAT_S16_LE);
      snd_pcm_hw_params_set_channels(handle, params, 1);

      val = 8000;
      snd_pcm_hw_params_set_rate_near(handle, params, &val, &dir);

      /* Set period size to 32 frames. */
      frames = 32;
      snd_pcm_hw_params_set_period_size_near(handle, params, &frames,
&dir);

      rc = snd_pcm_hw_params(handle, params);
      if (rc < 0) {
            fprintf(stderr,"unable to set hw parameters:
%s\n",snd_strerror(rc));
            exit(1);
      }

      snd_pcm_hw_params_get_period_size(params, &frames, &dir);
      size = frames * 2; /* 2 bytes/sample, 1 channel */
      buffer = (char *) malloc(size);

      /* We want to loop for 5 seconds */
      snd_pcm_hw_params_get_period_time(params, &val, &dir);
      loops = 5000000 / val;
      while (loops > 0) {
            loops--;
            rc = snd_pcm_readi(handle, buffer, frames);
            if (rc == -EPIPE) {
                  /* EPIPE means overrun */
                  fprintf(stderr, "overrun occurred\n");
                  snd_pcm_prepare(handle);
            } else if (rc < 0) {
                  fprintf(stderr, "error from read: %s\n",
snd_strerror(rc));
            } else if (rc != (int)frames) {
                  fprintf(stderr, "short read, read %d frames\n", rc);
            }
            rc = write(1, buffer, size);
            if (rc != size)
                  fprintf(stderr, "short write: wrote %d bytes\n", rc);
      }
      snd_pcm_drain(handle);
      snd_pcm_close(handle);
      free(buffer);
      return 0;
}




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
