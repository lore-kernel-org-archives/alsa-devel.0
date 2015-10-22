From: "Bommes, Michael" <Michael.Bommes@rwth-aachen.de>
Subject: I/O errors,
 snd_pcm_hw_params_get_ functions don't deliver values and system
 freezes on drop/drain/close
Date: Thu, 22 Oct 2015 13:47:40 +0000
Message-ID: <1445521660731.90972@rwth-aachen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx-out-2.rwth-aachen.de (mx-out-2.rwth-aachen.de
 [134.130.5.187])
 by alsa0.perex.cz (Postfix) with ESMTP id 935E82604AA
 for <alsa-devel@alsa-project.org>; Thu, 22 Oct 2015 15:47:41 +0200 (CEST)
Content-Language: de-DE
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello,


I am trying to develop an audio capture application for an SoC (ASC8852A with a TW2866 Audio Codec).


I have SSH access to the SoC and the operating system was set up by someone else.

Libraries and drivers were precompiled by the manufacturer, as well as a demo system for a video capturing server.

Unfortunately I'm not that familiar with operating systems, driver programming and linux in special (although I know some basics regularly used in high-level development).


I'm not sure whether I installed ALSA libraries and drivers correctly.

Currently I have:

-  loaded in kernel (output printed to terminal):

    Advanced Linux Sound Architecture Driver Version 1.0.18rc3.

    ASoC version 0.13.2

    ALSA device list:
        No soundcards found.

- loaded by /etc/modules and modprobe.conf

    TW2866_AUDIO CodecNum=2

    i2c-gpio  bus_num=2 scl0=6 sda0=7 scl1=12 sda1=13

- performed after system startup:

    snddevices script delivered in the SDK of the SoC.

    sh snddevices

    The script is placed in the same folder as the TW2866_AUDIO.ko


- alsa.conf was placed in /etc/ALSA/alsa.conf because that place is used in the reference OS and some install script, too.


After that I have performed some cat and ls commands:


/dev/snd/ is created and holds entries (in the demo system there is another timer entry which is missing in my OS):

    controlC0  pcmC0D0c   pcmC0D0p   pcmC0D1c   pcmC0D2c   pcmC0D3c   pcmC0D4c


cat /proc/asound/devices
   0: [ 0]   : control
 17: [ 0- 1]: digital audio playback
 24: [ 0- 0]: digital audio capture
 25: [ 0- 1]: digital audio capture
 33:        : timer


and

cat /proc/asound/cards
    0 [VPL_AUDIO      ]: VPL AUDIO - VPL Audio TW2866 Driver
                      VPL Audio Codec Driver, TW2866.





Now I have no idea whether the drivers and stuff were installed correctly.

I tried to program a little sample program, but once I get pcm device to state SND_PCM_STATE_RUNNING the system freezes if I try to drain, drop or close the application, including all other ssh connections to the SoC so that a hard reset is necessary.

Errors on readi occur before (10 seconds between each readi call and the error message), but none of the errors mentioned in the documentation (-EPIPE etc) but a -EIO error (Input/Output).

But I'm not 100% sure whether the number of periods and buffer sizes were chosen correctly, so it might be possible that it's another user error (wrong buffer sizes delivered to driver could lead to freezes?).


So I've reduced the code to setting hardware parameters and found out that snd_pcm_hw_params_get_ calls don't return errors but some of them always return 0 or don't change the output parameter. Here's sample source code and terminal output:




----------------------------------------------------------------------------------------------------------------

/* Use the newer ALSA API */
#define ALSA_PCM_NEW_HW_PARAMS_API

#include <alsa/asoundlib.h>


void testError(const char* task, int rc)
{
    if (rc < 0)
    {
        fprintf(stderr,"ERROR: %s: %s\n", task, snd_strerror(rc));
        exit(1);
    }
}

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
  rc = snd_pcm_open(&handle, "hw:0,0", SND_PCM_STREAM_CAPTURE, 0);
  testError("snd_pcm_open",rc);


  /* Allocate a hardware parameters object. */
//  snd_pcm_hw_params_alloca(params);
  snd_pcm_hw_params_malloc(&params);


  /* Fill it in with default values. */
  rc = snd_pcm_hw_params_any(handle, params);
  testError("snd_pcm_hw_params_any", rc);

  /* Set the desired hardware parameters. */

  /* Interleaved mode */
  rc = snd_pcm_hw_params_set_access(handle, params,SND_PCM_ACCESS_RW_INTERLEAVED);
  testError("snd_pcm_hw_params_set_access", rc);


  // test whether _set_access was applied
  snd_pcm_access_t access = SND_PCM_ACCESS_RW_NONINTERLEAVED;
  snd_pcm_hw_params_get_access (params, &access);
  if(access != SND_PCM_ACCESS_RW_INTERLEAVED) printf("ERROR! not SND_PCM_ACCESS_RW_INTERLEAVED\n");

  /* Signed 16-bit little-endian format */
  rc = snd_pcm_hw_params_set_format(handle, params,SND_PCM_FORMAT_S16_LE);
  // non-16 bit formats fail to be set
  testError("snd_pcm_hw_params_set_format", rc);

  snd_pcm_format_t gottenFormat =  SND_PCM_FORMAT_S8;
  snd_pcm_hw_params_get_format (params, &gottenFormat);
  if(gottenFormat != SND_PCM_FORMAT_S16_LE)
  {
    printf ("ERROR! not SND_PCM_FORMAT_S16_LE ... %i instead\n", gottenFormat);
    switch(gottenFormat)
    {
    case  SND_PCM_FORMAT_S16_LE: printf("SND_PCM_FORMAT_S16_LE\n"); break;
    case  SND_PCM_FORMAT_UNKNOWN: printf("SND_PCM_FORMAT_UNKNOWN\n"); break;
    default: break; //printf("%ld\n",gottenFormat);
    }
  }

  /* Two channels (stereo) */
  rc = snd_pcm_hw_params_set_channels(handle, params, 2);
  testError("snd_pcm_hw_params_set_channels", rc);

  /* 44100 bits/second sampling rate (CD quality) */
  unsigned int rate = 8000;
  //snd_pcm_hw_params_set_rate_near(handle, params,&val, &dir);
  rc = snd_pcm_hw_params_set_rate_near(handle, params,&rate, &dir);
  testError("snd_pcm_hw_params_set_rate_near", rc);
  printf("applied rate (return value): %i\n", (int)rate);

  unsigned int usedRate;
  rc = snd_pcm_hw_params_get_rate (params, &usedRate, &dir);
  testError("snd_pcm_hw_params_get_rate", rc);
  printf("used rate (getter value): %i\n", usedRate);

  unsigned int usedPeriods;
  snd_pcm_hw_params_get_periods(params, &usedPeriods, &dir);
  testError("", rc);
  printf("default periods: %i\n", usedPeriods);

  unsigned int periods = 8;
  // Set number of periods. Periods used to be called fragments.
  rc = snd_pcm_hw_params_set_periods(handle, params, periods, 0);
  testError("snd_pcm_hw_params_set_periods", rc);
  printf("Chosen number of periods (return value): %i\n", periods);

  rc = snd_pcm_hw_params_get_periods(params, &usedPeriods, &dir);
  testError("snd_pcm_hw_params_get_periods", rc);
  printf("used periods (getter value): %i\n", usedPeriods);


  /* Set period size to 32 frames. */
  frames = 32;
  //  snd_pcm_hw_params_set_period_size_near(handle,params, &frames, &dir);
  snd_pcm_hw_params_set_period_size_near(handle,params, &frames, &dir);
  testError("snd_pcm_hw_params_set_period_size_near", rc);

  printf("frames per period tried to set (return value): %ld\n", frames);

  printf("write to driver\n");
  /* Write the parameters to the driver */
  rc = snd_pcm_hw_params(handle, params);
  testError("snd_pcm_hw_params", rc);
  printf("written to driver\n");

  snd_pcm_uframes_t maxSize;
  snd_pcm_hw_params_get_period_size_max(params, &maxSize, &dir);
  printf("max period size: %i\n", (int)maxSize);

  /* Use a buffer large enough to hold one period */
  rc = snd_pcm_hw_params_get_period_size(params, &frames, &dir);
  testError("snd_pcm_hw_params_get_period_size", rc);
  size = frames * 4; /* 2 bytes/sample, 2 channels */
  buffer = (char *) malloc(size);

  /* We want to loop for 5 seconds */
  rc = snd_pcm_hw_params_get_period_time(params, &val, &dir);
  testError("snd_pcm_hw_params_get_period_time", rc);
  loops = 5000000 / val;

  printf("frames per period: %ld\n", frames);

  // ERROR: here: size will be 0, so loops will be performed but nothing is copied...

  while (loops > 0) {
    loops--;
    rc = snd_pcm_readi(handle, buffer, frames);
    if (rc == -EPIPE) {
      /* EPIPE means overrun */
      fprintf(stderr, "overrun occurred\n");
      snd_pcm_prepare(handle);
    } else if (rc < 0) {
      fprintf(stderr,
              "error from read: %s\n",
              snd_strerror(rc));
    } else if (rc != (int)frames) {
      fprintf(stderr, "short read, read %d frames\n", rc);
    }

    rc = write(1, buffer, size);
    if (rc != size)
      fprintf(stderr,
              "short write: wrote %d bytes\n", rc);
  }

  snd_pcm_drain(handle);
  snd_pcm_close(handle);
  free(buffer);

  printf("finished\n");

  return 0;
}
------------------------------------------------------------------------------------------------------------------





with output:


ERROR! not SND_PCM_FORMAT_S16_LE ... 0 instead
applied rate (return value): 8000
used rate (getter value): 8000
default periods: 0
Chosen number of periods (return value): 8 (comment: output parameter meant here)
used periods (getter value): 0
frames per period tried to set (return value): 32 (comment: output parameter meant here)
write to driver
hello, alsa~.
written to driver
max period size: 0
frames per period: 0
finished


This code doesn't freeze but

getter functions "return" (where I mean the output parameter) 0 for periods and framesPerPeriod and format-getter doesn't return the expected, while sample-rate getter works.

I'm a but confused about the "hello, alsa~."  output, is that normal behaviour for the driver or might it be some kind of debug output in library or driver?


System freeze looks like driver issue, or might this only be a wrong usage of the driver?


Is there a way to check which parts of the ALSA installation (library, driver, codecs) do or don't work? How can I be certain that snddevices script and .conf files are sufficient?



Thank you very much in advance,

Michael
