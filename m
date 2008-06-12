From: "Christian Morales Vega" <cmorve69@yahoo.es>
Subject: Re: snd_pcm_avail_update() needed before
	snd_pcm_delay() with hda-intel
Date: Thu, 12 Jun 2008 20:32:51 +0200
Message-ID: <8235e6f40806121132h4dd900f1u250ddeac318f659e@mail.gmail.com>
References: <8235e6f40806061254v41604524l4e43647482602098@mail.gmail.com>
	<75b66ecd0806061746r1f542ed2i6c966465c1475152@mail.gmail.com>
	<s5hprqn0xv6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.225])
	by alsa0.perex.cz (Postfix) with ESMTP id 812DC246D7
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Jun 2008 20:32:53 +0200 (CEST)
Received: by wx-out-0506.google.com with SMTP id h30so1735275wxd.23
	for <alsa-devel@alsa-project.org>; Thu, 12 Jun 2008 11:32:52 -0700 (PDT)
In-Reply-To: <s5hprqn0xv6.wl%tiwai@suse.de>
Content-Disposition: inline
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

2008/6/12 Takashi Iwai <tiwai@suse.de>:
> It's unlikely a driver issue but an incompatibility of dmix, I guess.
> But still I don't figure out why this happens.  The hwsync is done at
> each snd_pcm_dmix_delay() call (as long as slowptr is set, and it's so
> as default).  So, there shouldn't be any difference...
>
> What happens if you use "hw" or "plughw"?
With both plughw and hw works fine.

If helps, I have simplified the problematic bsnes code into this:
#include <alsa/asoundlib.h>
#include <stdint.h>

int main(){
  snd_pcm_t *handle;

  unsigned length;

  unsigned frequency;
  snd_pcm_uframes_t buffer_size;
  snd_pcm_uframes_t period_size;

  if(snd_pcm_open(&handle, "default", SND_PCM_STREAM_PLAYBACK, 0) < 0) {
    exit(1);
  }

  if(snd_pcm_set_params(handle, SND_PCM_FORMAT_S16_LE,
SND_PCM_ACCESS_RW_INTERLEAVED,
     2, 44100, 1, 100000) < 0) {
    exit(2);
  }

  if(snd_pcm_get_params(handle, &buffer_size, &period_size) < 0) {
    exit(3);
  }

  snd_output_t *setup;
  if (snd_output_stdio_attach(&setup, stdout, 0) < 0) {
    exit(4);
  }
  snd_pcm_dump_setup(handle, setup);

  uint32_t data[period_size];

  while(1){
    length = period_size;

    printf("State: %d\n", snd_pcm_state(handle));
    snd_pcm_sframes_t delay;
    //snd_pcm_avail_update(handle);
    snd_pcm_delay(handle, &delay);
    printf("Delay: %d\n", delay);
    if(delay < 0){
      snd_pcm_prepare(handle);
    }else if(delay > buffer_size - period_size) {
      printf("Delay/Goal: %d/%u\n", delay, buffer_size - period_size);
      length = 0;
      continue;
    }
    printf("Passed\n");

    uint32_t *buffer_ptr = data;
    do {
      snd_pcm_sframes_t written = snd_pcm_writei(handle, buffer_ptr, length);
      if(written < 0) {
        snd_pcm_recover(handle, written, 1);
      } else if(written < length) {
        //only some samples written
        length -= written;
        buffer_ptr += written;
      } else {
        //all samples written
        length = 0;
      }
    } while(length != 0);
  }
}


The listened effect is that when fails you listen the noise for just
buffer_time, and when works the noise never ends.
