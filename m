From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH v5 0/5] ALSA: jack: Refactoring for jack
	kctls
Date: Sun, 12 Apr 2015 13:50:58 +0800
Message-ID: <CAN8cciaQ0D0f4nv6XS+0+Peo4mTK_yUmvU1_wjxWi5sDUm+wrA@mail.gmail.com>
References: <1428381891-30517-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f173.google.com (mail-qk0-f173.google.com
 [209.85.220.173])
 by alsa0.perex.cz (Postfix) with ESMTP id B56FD2604D5
 for <alsa-devel@alsa-project.org>; Sun, 12 Apr 2015 07:51:00 +0200 (CEST)
Received: by qkx62 with SMTP id 62so112256554qkx.0
 for <alsa-devel@alsa-project.org>; Sat, 11 Apr 2015 22:50:59 -0700 (PDT)
In-Reply-To: <1428381891-30517-1-git-send-email-yang.jie@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jie Yang <yang.jie@intel.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

>
> Currently only hda will create kctls for hda jacks, for asoc, people
> may need create jack kctls in specific driver.
>
> Here we are introducing kctls for each jack, by creating kctls and add
> them to jack controls list (considering exist of combo jack). At the
> same time, we will report events for each control in the list.
>
> With this new implementation, both HDA and soc jack kctls works fine,
> they are compatible for old HDA jack kctls, too.
>
> For soc,
> a. snd_jack_new() with NULL jack_kctl;
> b. for each pin, call snd_jack_add_kctls() to add one kctl(it will
> call snd_ctl_add() to add kctl to card);
>
> For hda,
> a. call snd_jack_kctl_new()(in __snd_hda_jack_add_kctl()) to new a
> jack_kctl(also new kctl); and use snd_hda_ctl_add to add kctl to card;
> b. new a hda_jack_tbl, appoint jack_tbl->jack_kctl = jack_kctl;
> c. for non-phantom jack, call snd_jack_new() with this jack_kctl,
> then the jack_kctl will be added to the new created jack;

Do the user space application (e.g. pulseaudio)  expect to driver to
provide a mute switch which can mute the speaker when the driver create
headphone jack control ?

Seem some hda codecs (e.g. cs4213) only have volume control and mute
switch  at the audio output ,

do pulseaudio still need the driver to create headphone jack kctl ? or
pulseaudio is smart enough to ignore the headphone jack kctl

the driver can mute speaker by set pin ctl of speaker pin to zero but does
not create speaker playback switch or headphone playback switch when there
is no amp out mute in pin complex

Node 0x02 [Audio Output] wcaps 0xb041d: Stereo Amp-Out
   Control: name="PCM Playback Volume", index=0, device=0
     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
   Control: name="PCM Playback Switch", index=0, device=0
     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
   Device: name="CS4213 Analog", type="Audio", device=0
   Amp-Out caps: ofs=0x73, nsteps=0x7f, stepsize=0x01, mute=1
   Amp-Out vals: [0x73 0x73]
   Converter: stream=8, channel=0
   PCM:
     rates [0x560]: 44100 48000 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
   Power states: D0 D3 EPSS
   Power: setting=D0, actual=D0
   Delay: 11 samples

Node 0x04 [Pin Complex] wcaps 0x410581: Stereo
   Control: name="Headphone Jack", index=0, device=0
   Pincap 0x0000001c: OUT HP Detect
   Pin Default 0x0421101f: [Jack] HP Out at Ext Right
     Conn = 1/8, Color = Black
     DefAssociation = 0x1, Sequence = 0xf
   Pin-ctls: 0xc0: OUT HP
   Unsolicited: tag=01, enabled=1
   Power states: D0 D3 EPSS
   Power: setting=D0, actual=D0
   Delay: 1 samples
   Connection: 1
      0x02
Node 0x05 [Pin Complex] wcaps 0x420581: Stereo
   Control: name="Speaker Phantom Jack", index=0, device=0
   Pincap 0x00000050: OUT Balanced
   Pin Default 0x90170010: [Fixed] Speaker at Int N/A
     Conn = Analog, Color = Unknown
     DefAssociation = 0x1, Sequence = 0x0
   Pin-ctls: 0x00:
   Unsolicited: tag=00, enabled=0
   Power states: D0 D3 EPSS
   Power: setting=D0, actual=D0
   Delay: 2 samples
   Connection: 1
      0x02
