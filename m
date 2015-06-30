From: "E.Richiardone" <emmanuel.richiardone@gmail.com>
Subject: Help on snd_pcm_hw_params() for ulaw on plugin
Date: Tue, 30 Jun 2015 14:38:22 +0200
Message-ID: <CAK3jutYZBr1fzrbtZf=V9O2VisQprjCDpENSxeZdo4_EasK68g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f175.google.com (mail-qk0-f175.google.com
 [209.85.220.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 9E7FB260417
 for <alsa-devel@alsa-project.org>; Tue, 30 Jun 2015 14:38:27 +0200 (CEST)
Received: by qkhu186 with SMTP id u186so4886401qkh.0
 for <alsa-devel@alsa-project.org>; Tue, 30 Jun 2015 05:38:23 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Sorry for void subject of before

Hi all,

I am building a solution on a Debian platform that should playback an
audio recorded in G711 ulaw format. I am using Alsa to interfacing
with the audio device, it's a snd_cs5535audio. Below there is a
fragment of the code I am using.
I don't have any problems accessing the device using the "plughw:0,0"
device, where I can correctly set directly the ulaw 8000Hz format.

Now I was needing an multiband equalizer, and found that Alsa supports
some ladspa plugins, I choosed mbeq.
But if I use a device name different from "plughw:0,0", as for example
the "default" device or "plug", the final function snd_pcm_hw_params()
returns an error:
 "cannot set hw params (Invalid argument)"

I was thinking that maybe my problem is that only the "plughw" device
accept directly the G711 ulaw format.
Anyone can confirm my thought?
There is a way to access a device directly in G711 ulaw format that
can be equalized with a plugin?


My initialisation source code:

----------8<----------
// #define AUDIODEV "plughw:0,0"
#define AUDIODEV "default"

[...]

  pcm_name = strdup(AUDIODEV);

  if((err = snd_pcm_open(&playback_handle, pcm_name, stream, 0)) < 0){
    printf(" E> cannot open audio device %s (%s)\n", pcm_name,
snd_strerror(err));
    closeall(1);
  }
  if((err = snd_pcm_hw_params_any(playback_handle, hw_params)) < 0){
    printf(" E> cannot initialize hardware parameter structure
(%s)\n", snd_strerror(err));
    closeall(1);
  }
  if((err = snd_pcm_hw_params_set_access(playback_handle, hw_params,
SND_PCM_ACCESS_RW_INTERLEAVED)) < 0){
    printf(" E> cannot set access type (%s)\n", snd_strerror(err));
    closeall(1);
  }
  err = snd_pcm_hw_params_set_format(playback_handle, hw_params,
SND_PCM_FORMAT_MU_LAW);
  if(err < 0){
    printf(" E> cannot set ulaw format (%s)\n", snd_strerror(err));
    closeall(1);
  }
  val = 8000;
  if((err = snd_pcm_hw_params_set_rate_near(playback_handle,
hw_params, &val, 0)) < 0){
    printf(" E> cannot set rate (%s)\n", snd_strerror(err));
    closeall(1);
  }

[...]

  if((err = snd_pcm_hw_params(playback_handle, hw_params)) < 0){
    printf(" E> cannot set hw params (%s)\n", snd_strerror(err));
    closeall(1);
  }
---------->8----------

My /etc/asound.conf :

----------8<----------
defaults.ctl.card 0
defaults.ctl.device 0
defaults.pcm.card 0
defaults.pcm.device 0

ctl.equal {
   type equal;
   library "/usr/lib/ladspa/mbeq_1197.so";
   module "mbeq";
   controls "/usr/local/webif/.alsaequal.bin";
}

pcm.plugequal {
   type equal;
   slave.pcm "plughw:0,0";
   library "/usr/lib/ladspa/mbeq_1197.so";
   module "mbeq";
   controls "/usr/local/webif/.alsaequal.bin";
}

pcm.!default {
   type plug;
   slave.pcm plugequal;
   hint {
      show on
      description "Default equalized"
   }
}

pcm.dsp0 {
    type plug
    slave.pcm plugequal;
}
---------->8----------

Many thanks
Best Regards
--
E.Richiardone
