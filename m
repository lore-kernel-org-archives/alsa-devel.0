From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH 2/2] ALSA: hda - Remove NO_PRESENCE bit
 override for Dell 1420n Laptop
Date: Wed, 24 Jul 2013 20:17:16 +0800
Message-ID: <CAN8cciYJe-G73M5jafDp61XR63DSGKEnjYpB+_M12oyfo4-xmQ@mail.gmail.com>
References: <1374246542-14244-1-git-send-email-tiwai@suse.de>
 <1374246542-14244-2-git-send-email-tiwai@suse.de>
 <CAN8cciZZQCLiGj4TTd8Vmfo9hYEL62dKqHGCRRE13o6FXn+0Ug@mail.gmail.com>
 <s5htxjli3gi.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f175.google.com (mail-ob0-f175.google.com
 [209.85.214.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 980002652C6
 for <alsa-devel@alsa-project.org>; Wed, 24 Jul 2013 14:17:18 +0200 (CEST)
Received: by mail-ob0-f175.google.com with SMTP id xn12so1699232obc.34
 for <alsa-devel@alsa-project.org>; Wed, 24 Jul 2013 05:17:17 -0700 (PDT)
In-Reply-To: <s5htxjli3gi.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: lucent@gmail.com, jmsanders84@gmail.com, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> >
> > > The quirk for Dell laptops with STAC9228 overrides the pin default
> > > config of NID 0x0f to the value with AC_DEFCFG_MISC_NO_PRESENCE bit
> > > on.  I'm not quite sure why this was done so, but can guess that this
> > > was introduced for avoiding this to be muted by another headphone
> > > plug.  Now, after transition to the generic parser, this workaround
> > > rather causes a problem (notably as unexpected speaker mutes) because
> > > the pin is seen as if it's always plugged in.
> > >
> >
> >
> > Is there any side effect when the driver perform pin fixup on line out
pin
> > complex which pincap does not support HP to headphone phone complex
> >
> > Refer to STAC9228 datasheet , port F does not support headphone out
>
> Yes, but we checked that Windows show in the same way (the secondary
> headphone), so we just take it as is.

Is this a regression since it surround 5.1 was supported ?

http://git.kernel.org/cgit/linux/kernel/git/tiwai/hda-emu.git/plain/codecs/stac9228-dell-inspiron-1420-laptop

Simple mixer control 'Headphone as Line Out',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]

Simple mixer control 'Mic as Output',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]

Simple mixer control 'Swap Center/LFE',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
