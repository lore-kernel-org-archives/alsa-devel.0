From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Strange sound of IDT 82hd206xx6 at font port in
	AC97 mode
Date: Tue, 4 Feb 2014 17:04:21 +0800
Message-ID: <CAN8ccia9pfXS0d35wXHBaeXXduV_7a107yuQ-y+O0jaEt0cUDg@mail.gmail.com>
References: <BLU0-SMTP22F128862C405DED98AB89ADAB0@phx.gbl>
 <CAN8cciZ+QwNpSnBmXuvKV9Hkqhfbo6CvY0bmx7rMQic9+tgb8A@mail.gmail.com>
 <BLU0-SMTP168158F76E25FBB1A51D33EADAA0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f41.google.com (mail-qa0-f41.google.com
 [209.85.216.41])
 by alsa0.perex.cz (Postfix) with ESMTP id A3EED26171E
 for <alsa-devel@alsa-project.org>; Tue,  4 Feb 2014 10:04:22 +0100 (CET)
Received: by mail-qa0-f41.google.com with SMTP id w8so11829170qac.14
 for <alsa-devel@alsa-project.org>; Tue, 04 Feb 2014 01:04:21 -0800 (PST)
In-Reply-To: <BLU0-SMTP168158F76E25FBB1A51D33EADAA0@phx.gbl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Randy Li <lxr1234@hotmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>>
> >> Hello My mainboard is ECS A780GM-A, the sound chip in it is IDT
> >> 82HD206XX6,
> >
> > Is this 92HD206X ?
> >
> Maybe it is, but it is 82HD206XX6 in the top side of the chip.
>
> > Seem this codec support impedance sense
> >
> > Post the output of alsa-info.sh
> >
> http://www.alsa-project.org/db/?f=ce795f0f8e31b9eb5e35cc2fed572290d14b1cda
>


Simple mixer control 'Swap Center/LFE',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]


Do this switch work as expected when you run

speaker-test -c 6 -t wav -Dhw:0,0
