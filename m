From: Thilaga <thilaga5981@gmail.com>
Subject: Application: Regd ALSA playback
Date: Thu, 19 May 2011 18:10:08 +0530
Message-ID: <BANLkTinCjJbNzT0z607DzPp_ZZd9jTPjwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id DD3EF10384B
	for <alsa-devel@alsa-project.org>;
	Thu, 19 May 2011 14:40:08 +0200 (CEST)
Received: by wwf26 with SMTP id 26so2206267wwf.20
	for <alsa-devel@alsa-project.org>; Thu, 19 May 2011 05:40:08 -0700 (PDT)
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

Hi,

I am new to ALSA and trying to play a wav file through ALSA by referring the
sample code.
It is a stereo, 44100Hz, 16 bit little endian file.

It is not properly playing the file.
I suspect that the frames parameter might be wrong.

Below is the source code.
Could any one give pointers on this.

  long loops;
  int rc;
  int size;
  snd_pcm_t *handle;
  snd_pcm_hw_params_t *params;
  unsigned int val;
  int dir;
  snd_pcm_uframes_t frames;
  char *buffer;

  /* Open PCM device for playback. */
  rc = snd_pcm_open(&handle, "default",
                    SND_PCM_STREAM_PLAYBACK, 0);
  if (rc < 0) {
    fprintf(stderr,
            "unable to open pcm device: %s\n",
            snd_strerror(rc));
    exit(1);
  }

  /* Allocate a hardware parameters object. */
  snd_pcm_hw_params_alloca(&params);

  /* Fill it in with default values. */
  snd_pcm_hw_params_any(handle, params);

  /* Set the desired hardware parameters. */

  /* Interleaved mode */
  snd_pcm_hw_params_set_access(handle, params,
                      SND_PCM_ACCESS_RW_INTERLEAVED);

  /* Signed 16-bit little-endian format */
  snd_pcm_hw_params_set_format(handle, params,
                              SND_PCM_FORMAT_S16_LE);

  /* Two channels (stereo) */
  snd_pcm_hw_params_set_channels(handle, params, 2);

  /* 44100 bits/second sampling rate (CD quality) */
  val = 44100;
  snd_pcm_hw_params_set_rate_near(handle, params,
                                  &val, &dir);

  /* Set period size to 32 frames. */
  frames = 44100;
  snd_pcm_hw_params_set_period_size_near(handle,
                              params, &frames, &dir);

  /* Write the parameters to the driver */
  rc = snd_pcm_hw_params(handle, params);
  if (rc < 0) {
    fprintf(stderr,
            "unable to set hw parameters: %s\n",
            snd_strerror(rc));
    exit(1);
  }

  /* Use a buffer large enough to hold one period */
  snd_pcm_hw_params_get_period_size(params, &frames,
                                    &dir);
  printf("get period_size: %d\n",frames);
  size = frames * 4 ; /* 2 bytes/sample, 2 channels */
  printf("Size:%d\n",size);
  buffer = (char *) malloc(size);

  /* We want to loop for 2 seconds */
  snd_pcm_hw_params_get_period_time(params,
                                    &val, &dir);
  printf("period time: %d\n",val);
  /* 2 seconds in microseconds divided by
   * period time */
  loops = 3000000 / val;
  printf("loops: %d\n",loops);

  FILE *fp;
  int file;

  fp = fopen("ring-1.wav", "rb");
  if (!fp) {
     printf("file open failure\n");
     return NULL;
  }
  printf("file open success\n");

  while (loops > 0) {
    loops--;
    //rc = read(0, buffer, size);
    rc = fread(buffer, sizeof(unsigned char), frames, fp);
      printf("bytes read: %d\n", rc);
    if (rc == 0) {
      printf("end of file on input\n");
      break;
    } else if (rc != size) {
      fprintf(stderr,
              "short read: read %d bytes\n", rc);
    }
    rc = snd_pcm_writei(handle, buffer, frames);
    if (rc == -EPIPE) {
      /* EPIPE means underrun */
      fprintf(stderr, "underrun occurred\n");
      snd_pcm_prepare(handle);
    } else if (rc < 0) {
      fprintf(stderr,
              "error from writei: %s\n",
              snd_strerror(rc));
    }  else if (rc != (int)frames) {
      fprintf(stderr,
              "short write, write %d frames\n", rc);
    }
  }

  snd_pcm_drain(handle);
  snd_pcm_close(handle);
  free(buffer);
  fclose(fp);
  return 0;
}

Thanks & Regards,
Thilaga
