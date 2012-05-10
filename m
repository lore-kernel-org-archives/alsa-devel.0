From: Luca Longhi <lucavermei@gmail.com>
Subject: Play a sine wave with alsa
Date: Thu, 10 May 2012 20:05:43 +0200
Message-ID: <CAAiKgks2TGSFW1Qs=KiTSd9HpXBxc68bOV3-K5-0d47GYrWFvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f50.google.com (mail-qa0-f50.google.com
	[209.85.216.50])
	by alsa0.perex.cz (Postfix) with ESMTP id EF8E110BAE3
	for <alsa-devel@alsa-project.org>;
	Thu, 10 May 2012 20:05:44 +0200 (CEST)
Received: by qafl39 with SMTP id l39so811269qaf.2
	for <alsa-devel@alsa-project.org>; Thu, 10 May 2012 11:05:44 -0700 (PDT)
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

I've written this code to play a sine wave but I don't think it's right.
Could you tell me where I am wrong?

Especially I don't know what period_time and buffer_time are. What I
have to do to extend the playback time?


Code:
#include <alsa/asoundlib.h>
#include <math.h>

int main() {
  int err;
  snd_pcm_t *handle;
  snd_pcm_hw_params_t *params;
  unsigned int Fc, val;
  int channels=2;
  int size;
  int dir=0;
  unsigned int period_time= 400000;
  unsigned int buffer_time= 800000;
  snd_pcm_uframes_t frames;
  snd_pcm_uframes_t bufferSize;
  char *buffer;

  /* Open PCM device for playback. */
  err = snd_pcm_open(&handle, "default",SND_PCM_STREAM_PLAYBACK, 0);

  if (err < 0) {
    fprintf(stderr,"unable to open pcm device: %s\n",snd_strerror(err));
    exit(1);
  }

  snd_pcm_hw_params_alloca(&params);
  err=snd_pcm_hw_params_any(handle, params);
  if (err < 0) {
  printf("Broken configuration for playback: no configurations
available: %s\n", snd_strerror(err));
    return err;
  }
  err = snd_pcm_hw_params_set_access(handle, params,
SND_PCM_ACCESS_RW_INTERLEAVED);

  if (err < 0) {
     printf("Access type not available for playback: %s\n",
snd_strerror(err));
     return err;
  }
  err=snd_pcm_hw_params_set_format(handle, params,
SND_PCM_FORMAT_S16_LE);
  if (err < 0) {
     printf("Sample format not available for playback: %s\n",
snd_strerror(err));
     return err;
  }
  err = snd_pcm_hw_params_set_channels(handle, params, channels);
  if (err < 0) {
     printf("Channels count (%i) not available for playbacks: %s\n",
channels, snd_strerror(err));
     return err;
  }
  Fc = 5000;
  dir=1;
  err=snd_pcm_hw_params_set_rate_near(handle, params, &Fc, &dir);
  if (err < 0) {
     printf("Rate %iHz not available for playback: %s\n", Fc,
snd_strerror(err));
     return err;
  }
  dir=0;

  err = snd_pcm_hw_params_set_period_time_near(handle, params,
&period_time, &dir);
  if (err < 0) {
                printf("Unable to set period time %i for playback:
%s\n", period_time, snd_strerror(err));
                 return err;
  }
  err = snd_pcm_hw_params_set_buffer_time_near(handle, params,
&buffer_time, &dir);
         if (err < 0) {
                 printf("Unable to set buffer time %i for playback:
%s\n", buffer_time, snd_strerror(err));
                 return err;
         }

  err = snd_pcm_hw_params(handle, params);
  if (err < 0) {
     printf("Unable to set hw params for playback: %s\n",
snd_strerror(err));
     return err;
  }


  /* Use a buffer large enough to hold one period */
  snd_pcm_hw_params_get_period_size(params, &frames, 0);

  size = frames * 4;


  short buf[size];
  unsigned short ampiezza;
  double frequenza = 500;
  double omega; /* Pulsazione */
  int x;

  omega = 2 * M_PI * frequenza / 180;
  ampiezza = 20000;

   for (x = 0; x < size ; x++)
    {
      buf[x] = (short)(ampiezza * (sin (omega*x)));
    }



    err = snd_pcm_writei(handle, buf, frames);
    if (err == -EPIPE) {
      fprintf(stderr, "underrun occurred\n");
      snd_pcm_prepare(handle);
    } else if (err < 0) {
      fprintf(stderr,
              "error from writei: %s\n",
              snd_strerror(err));
    }  else if (err != (int)frames) {
      fprintf(stderr,
              "short write, write %d frames\n", err);
    }


  snd_pcm_drain(handle);
  snd_pcm_close(handle);


  return 0;
}
