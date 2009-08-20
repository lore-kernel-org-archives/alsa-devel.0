From: ruchi sirauthiya <ruchisirauthiya@gmail.com>
Subject: Re: Error enabling dmix with ALSA
Date: Thu, 20 Aug 2009 13:02:20 +0530
Message-ID: <3a2444df0908200032r39c57844l4d74c5b49a08e531@mail.gmail.com>
References: <3a2444df0908150606p7a1cb237qad6d31dedae3ec4a@mail.gmail.com>
	<3a2444df0908160319q790d7460l171fa52be7c29aca@mail.gmail.com>
	<s5h3a7oc827.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f181.google.com (mail-yw0-f181.google.com
	[209.85.211.181])
	by alsa0.perex.cz (Postfix) with ESMTP id D7E8824439
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Aug 2009 09:32:41 +0200 (CEST)
Received: by ywh11 with SMTP id 11so7774903ywh.16
	for <alsa-devel@alsa-project.org>; Thu, 20 Aug 2009 00:32:40 -0700 (PDT)
In-Reply-To: <s5h3a7oc827.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,
No, I do not have /dev/snd/timer device entry.

A small correction... I am using TPS65950 codec and not TWL4030.

Ruchi Sirauthiya


On Wed, Aug 19, 2009 at 5:46 PM, Takashi Iwai <tiwai@suse.de> wrote:

> At Sun, 16 Aug 2009 15:49:11 +0530,
> ruchi sirauthiya wrote:
> >
> > Hi,
> >
> > I am trying to enable a software mixer (using ALSA and dmix) on an OMAP3
> > based embedded target board using the twl4030 codec.
> >
> > When I try to play audio using the command,
> >
> > # aplay -D playback rec.wav
> >
> > I am getting the following error:
> >
> > ALSA lib pcm_direct.c:1098:(snd_pcm_direct_initialize_poll_fd) unable to
> > open timer 'hw:CLASS=3,SCLASS=0,CARD=0,DEV=0,SUBDEV=0'
>
> Do you have /dev/snd/timer device?
>
>
> Takashi
>
