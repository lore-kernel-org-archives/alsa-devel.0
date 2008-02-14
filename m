From: Grzegorz Chwesewicz <grzegorz.chwesewicz@chilan.com>
Subject: Re: snd-hda-intel AD1981 - the microphone doesn't work
Date: Thu, 14 Feb 2008 13:27:13 +0100
Message-ID: <200802141327.13586.grzegorz.chwesewicz@chilan.com>
References: <47B1D340.4070907@gmail.com> <47B364D2.3020400@gmail.com>
	<s5hlk5nybtx.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.chilan.com (mail.chilan.com [82.160.213.101])
	by alsa0.perex.cz (Postfix) with ESMTP id 73F8624593
	for <alsa-devel@alsa-project.org>; Thu, 14 Feb 2008 13:27:29 +0100 (CET)
In-Reply-To: <s5hlk5nybtx.wl%tiwai@suse.de>
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
Cc: Takashi Iwai <tiwai@suse.de>, chilek@chilan.com, Robert Gonciarz <ruppertus@gmail.com>
List-Id: alsa-devel@alsa-project.org

Thursday 14 of February 2008 13:14:18 Takashi Iwai napisa=B3(a):
> At Wed, 13 Feb 2008 22:44:50 +0100,
>
> Robert Gonciarz wrote:
> > I've tried to compile 1.0.16 version.
> > That's the result of the script:
> > http://pastebin.ca/902946
>
> Thanks.
>
> And, does a similar problem like Grzegorz's case occur on your laptop?
> Some HP laptops (so far, AMD SB450-based) occasionally cause a hang-up
> during recording from the mic when HD is accessed.  This is far more
> nasty problem, and it's interesting to know whether this happens on
> other chipset.

Don't forget to mention that hang only occurs when MSI is enabled (deleted =

SB480 from blacklist, and enable_msi=3D1 when loading hda_intel), without M=
SI I =

don't experience hangs even when to mic stops working.

To be clear, in my case:
RS480 is Host Bridge,
RS480 is PCI Bridge,
SB450 is HDA Audio.

-- =

Greetings
Grzegorz Chwesewicz, Chilan =

mailto:grzegorz.chwesewicz@chilan.com
