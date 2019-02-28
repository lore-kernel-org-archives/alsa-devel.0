From: Manuel Reinhardt <manuel.rhdt@gmail.com>
Subject: Re: [PATCH] ALSA: usb-audio: Add quirk for MOTU
 MicroBook	II
Date: Thu, 28 Feb 2019 20:34:23 +0100
Message-ID: <549a5ba4dbb973d891cc5b08bf0281ff1e171f94.camel@gmail.com>
References: <d4a6b20f1a4cdb62c90e6802875814233b9c2337.camel@gmail.com>
 <s5hr2btgnm9.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8F7B4F896CE
 for <alsa-devel@alsa-project.org>; Thu, 28 Feb 2019 20:34:25 +0100 (CET)
Received: by mail-wm1-x344.google.com with SMTP id x10so9996816wmg.2
 for <alsa-devel@alsa-project.org>; Thu, 28 Feb 2019 11:34:25 -0800 (PST)
In-Reply-To: <s5hr2btgnm9.wl-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Thank you for your time and comments.

Am Mittwoch, den 27.02.2019, 18:14 +0100 schrieb Takashi Iwai:
> On Wed, 27 Feb 2019 15:26:01 +0100,
> Manuel Reinhardt wrote:
> > Add an entry to the quirks-table to for usb-audio to recognize the
> > Microbook II (although it only exposes vendor interfaces). A simple
> > boot
> > quirk is also implemented to set up the sample rate and  make sure
> > that
> > no audio urbs are sent before the device is ready.
> > 
> > This patch only provides audio playback and capture at 96kHz sample
> > rate. Notice the following shortcomings:
> > 
> > - The sample rate is currently hardcoded to 96k although the device
> > also
> >   supports 48k and 44.1k.
> > 
> > - The various mixer controls of the MicroBook are not made
> > available.
> > 
> > - The keep-iface control should be on by default because the device
> >   shuts down whenever the altsetting is reset which is usually
> > unwanted.
> >   (I don't know the best way to do this)
> 
> Can be set either in the quirk callback you write.
> Or it'd be not bad to create a white list, too.

I will try to address that in a future patch.

I have fixed the patch to address your remaining concerns.
