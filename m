From: Santo Chow <santo_chow@yahoo.com>
Subject: Need help on getting raw audio stream from a dummy
	sound card
Date: Thu, 5 Mar 2009 08:34:03 -0800 (PST)
Message-ID: <528253.23902.qm@web110802.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web110802.mail.gq1.yahoo.com (web110802.mail.gq1.yahoo.com
	[67.195.13.225]) by alsa0.perex.cz (Postfix) with SMTP id E564210381F
	for <alsa-devel@alsa-project.org>; Thu,  5 Mar 2009 17:34:04 +0100 (CET)
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

Hi everyone :)

I'm currently assigned to a task that requires me to capture raw audio stream from a dummy sound card. Is this even possible?

Previously, I have been able to capture raw audio stream from my default sound card, by using the following example I got from http://www.linuxjournal.com/article/6735

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
  rc = snd_pcm_open(&handle, "default",
                    SND_PCM_STREAM_CAPTURE, 0);
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
  frames = 32;
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
  snd_pcm_hw_params_get_period_size(params,
                                      &frames, &dir);
  size = frames * 4; /* 2 bytes/sample, 2 channels */
  buffer = (char *) malloc(size);

  /* We want to loop for 5 seconds */
  snd_pcm_hw_params_get_period_time(params,
                                         &val, &dir);
  loops = 5000000 / val;

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

  return 0;
}

The above example allows me to capture 5 seconds of raw audio. I can use aplay to play the recorded sound and it plays nicely. But right now, I'm working on a project that involves the usage of a small development board. Basically, this board does not have a sound card or an actual speaker. So I thought, I can use the dummy soundcard provided by the linux kernel by calling out modprobe snd-dummy. Right now, I'm still testing it in my PC so to simulate the board's environment. I have configured the .asoundrc file and create a new dummy pcm by putting the lines below onto my .asoundrc file.

pcm.dummy{
    type hw
    card Dummy
}

So, I change the above ecample code, so it listens to this new dummy pcm rather than the 'default'. Like this :

rc = snd_pcm_open(&handle, "dummy",
                    SND_PCM_STREAM_CAPTURE, 0);
Supposedly, the above modification would allow me to record from this dummy pcm, no? I do this by playing a song, using aplay -f cd -D dummy song.wav and at the same time, execute the above example. As expected, no sound was coming out from my speaker. When the program finished recording for 5 seconds, I play back the result, but all i heard was just noise.

Of curiousity, I try using file plugins. I modify my .asoundrc file like this:

pcm.dummy{
    type plug
    slave{
        pcm file
        format S16_LE
        channels 2
        rate 44100
    }
}

pcm.file{
    type file
    slave{
        pcm d
    }
    file /home/mydir/out.raw
}

pcm.d{
    type hw
    card Dummy
}

Then i called aplay -f cd -D dummy song.wav again, well.. still no sound coming out from the speaker, but it does output the raw audio file into my /home/mydir/out.raw file. I play the out.raw using aplay -f cd /home/mydir/out.raw it's flawless.

But I can't use this for my implementation. What I need is actually a way to read raw audio data (or stream) from the dummy sound card, to a buffer inside my program. I need this because I'm going to stream the buffer to my server, so I can listen the sound from my server. I can't afford to use the file plugin approach, basically because later on, in my development board, i won't have that much space.

So, the question is: capturing raw audio data from a dummy soundcard, is this possible? I'm pretty sure that if the file plugin works, means that the raw audio data is there. It's just that i'm probably doing a wrong approach to read it. Hence, needs explanation and help..

Please help me.. :(


Thank you so much for reading my long request.
