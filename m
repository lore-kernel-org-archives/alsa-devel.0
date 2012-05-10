From: Maarten de Boer <maarten@resorama.com>
Subject: Re: Play a sine wave with alsa
Date: Fri, 11 May 2012 01:07:57 +0200
Message-ID: <C399ED63-8C12-4A34-B34D-5747464AF219@resorama.com>
References: <CAAiKgks2TGSFW1Qs=KiTSd9HpXBxc68bOV3-K5-0d47GYrWFvg@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net
	[217.70.183.195])
	by alsa0.perex.cz (Postfix) with ESMTP id 7880910BAFE
	for <alsa-devel@alsa-project.org>;
	Fri, 11 May 2012 01:08:02 +0200 (CEST)
In-Reply-To: <CAAiKgks2TGSFW1Qs=KiTSd9HpXBxc68bOV3-K5-0d47GYrWFvg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Luca Longhi <lucavermei@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Luca,

There are many things wrong with this code.... To name a few: 
- you try to set the samplerate to 5000 Hz (I don't think any soundcard would support that. 44100 would be a common choice)
- you misinterpret what a period is. (see documention link below)
- you fill a buffer only for one period, which normally would be very short. Typically, you should keep filling the buffer for many periods in a row.

I think you would be better off using some library on top of alsa that may be easier to get started with, like RtAudio or PortAudio. Once you are more familiar with the concepts, you could move on to alsa.

http://www.music.mcgill.ca/~gary/rtaudio/

If you do decide to use alsa anyway, I recommend you read the alsa-lib pcm documentation:

http://www.alsa-project.org/alsa-doc/alsa-lib/pcm.html

Also, you could have a look at the examples in the alsa-lib source code. I believe there is actually an example that does exactly what you want.

Good luck.

Maarten


On May 10, 2012, at 20:05 , Luca Longhi wrote:

> I've written this code to play a sine wave but I don't think it's right.
> Could you tell me where I am wrong?
> 
> Especially I don't know what period_time and buffer_time are. What I
> have to do to extend the playback time?
> 
> 
> Code:
> #include <alsa/asoundlib.h>
> #include <math.h>
> 
> int main() {
>  int err;
>  snd_pcm_t *handle;
>  snd_pcm_hw_params_t *params;
>  unsigned int Fc, val;
>  int channels=2;
>  int size;
>  int dir=0;
>  unsigned int period_time= 400000;
>  unsigned int buffer_time= 800000;
>  snd_pcm_uframes_t frames;
>  snd_pcm_uframes_t bufferSize;
>  char *buffer;
> 
>  /* Open PCM device for playback. */
>  err = snd_pcm_open(&handle, "default",SND_PCM_STREAM_PLAYBACK, 0);
> 
>  if (err < 0) {
>    fprintf(stderr,"unable to open pcm device: %s\n",snd_strerror(err));
>    exit(1);
>  }
> 
>  snd_pcm_hw_params_alloca(&params);
>  err=snd_pcm_hw_params_any(handle, params);
>  if (err < 0) {
>  printf("Broken configuration for playback: no configurations
> available: %s\n", snd_strerror(err));
>    return err;
>  }
>  err = snd_pcm_hw_params_set_access(handle, params,
> SND_PCM_ACCESS_RW_INTERLEAVED);
> 
>  if (err < 0) {
>     printf("Access type not available for playback: %s\n",
> snd_strerror(err));
>     return err;
>  }
>  err=snd_pcm_hw_params_set_format(handle, params,
> SND_PCM_FORMAT_S16_LE);
>  if (err < 0) {
>     printf("Sample format not available for playback: %s\n",
> snd_strerror(err));
>     return err;
>  }
>  err = snd_pcm_hw_params_set_channels(handle, params, channels);
>  if (err < 0) {
>     printf("Channels count (%i) not available for playbacks: %s\n",
> channels, snd_strerror(err));
>     return err;
>  }
>  Fc = 5000;
>  dir=1;
>  err=snd_pcm_hw_params_set_rate_near(handle, params, &Fc, &dir);
>  if (err < 0) {
>     printf("Rate %iHz not available for playback: %s\n", Fc,
> snd_strerror(err));
>     return err;
>  }
>  dir=0;
> 
>  err = snd_pcm_hw_params_set_period_time_near(handle, params,
> &period_time, &dir);
>  if (err < 0) {
>                printf("Unable to set period time %i for playback:
> %s\n", period_time, snd_strerror(err));
>                 return err;
>  }
>  err = snd_pcm_hw_params_set_buffer_time_near(handle, params,
> &buffer_time, &dir);
>         if (err < 0) {
>                 printf("Unable to set buffer time %i for playback:
> %s\n", buffer_time, snd_strerror(err));
>                 return err;
>         }
> 
>  err = snd_pcm_hw_params(handle, params);
>  if (err < 0) {
>     printf("Unable to set hw params for playback: %s\n",
> snd_strerror(err));
>     return err;
>  }
> 
> 
>  /* Use a buffer large enough to hold one period */
>  snd_pcm_hw_params_get_period_size(params, &frames, 0);
> 
>  size = frames * 4;
> 
> 
>  short buf[size];
>  unsigned short ampiezza;
>  double frequenza = 500;
>  double omega; /* Pulsazione */
>  int x;
> 
>  omega = 2 * M_PI * frequenza / 180;
>  ampiezza = 20000;
> 
>   for (x = 0; x < size ; x++)
>    {
>      buf[x] = (short)(ampiezza * (sin (omega*x)));
>    }
> 
> 
> 
>    err = snd_pcm_writei(handle, buf, frames);
>    if (err == -EPIPE) {
>      fprintf(stderr, "underrun occurred\n");
>      snd_pcm_prepare(handle);
>    } else if (err < 0) {
>      fprintf(stderr,
>              "error from writei: %s\n",
>              snd_strerror(err));
>    }  else if (err != (int)frames) {
>      fprintf(stderr,
>              "short write, write %d frames\n", err);
>    }
> 
> 
>  snd_pcm_drain(handle);
>  snd_pcm_close(handle);
> 
> 
>  return 0;
> }
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
