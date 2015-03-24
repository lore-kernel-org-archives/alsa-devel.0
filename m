From: noman pouigt <variksla@gmail.com>
Subject: Re: Alsa-devel Digest, Vol 97, Issue 173
Date: Mon, 23 Mar 2015 23:53:19 -0700
Message-ID: <CAES_P+-FxQUF=uncbPpV7PkBo+8fXyoceiwyfYpMdd72_32KVw@mail.gmail.com>
References: <mailman.1524.1426908276.807.alsa-devel@alsa-project.org>
 <CAK7N6vrcY0bFZVMOUUuL92V3J3tyAfiwxSO3oO6Q_PhOmG75Uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f173.google.com (mail-ob0-f173.google.com
 [209.85.214.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B4B926059C
 for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2015 07:53:21 +0100 (CET)
Received: by obcxo2 with SMTP id xo2so140729268obc.0
 for <alsa-devel@alsa-project.org>; Mon, 23 Mar 2015 23:53:20 -0700 (PDT)
In-Reply-To: <CAK7N6vrcY0bFZVMOUUuL92V3J3tyAfiwxSO3oO6Q_PhOmG75Uw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, perex@perex.cz
Cc: alsa-user@lists.sourceforge.net, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, omer.job@gmail.com
List-Id: alsa-devel@alsa-project.org

> I would like to know which file I can use to connect/enable
> DPAM widgets permanently so a simple aplay/record can work?
>
> My environment is:
> - Yocto Linux Kernel 3.10 - (DTS based)
> - Max98090 Codec
> - imx6SL SoC
>
> I thought about doing this in alsa.conf or asound.conf but I couldn't
> find a single example with DAPM widgets .

I am also stuck with the same problem. I am sure ALSA experts
can help here.

What i want to know is how to set the dapm widgets in open
embedded? Is it alsa.conf or asound.conf ?

I need to set something like this:
amixer cset  name="LEFT MIXER DAC" 1

Using amixer i am able to playback but i don't know how can i
modify conf file to have this dapm widgets associated with
a device.

Any example would suffice.
