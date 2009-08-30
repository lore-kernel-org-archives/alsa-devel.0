From: ruchi sirauthiya <ruchisirauthiya@gmail.com>
Subject: Re: Error enabling dmix with ALSA
Date: Sun, 30 Aug 2009 17:43:23 +0530
Message-ID: <3a2444df0908300513u524b0336w6b00d4c51e699036@mail.gmail.com>
References: <3a2444df0908150606p7a1cb237qad6d31dedae3ec4a@mail.gmail.com>
	<3a2444df0908160319q790d7460l171fa52be7c29aca@mail.gmail.com>
	<s5h3a7oc827.wl%tiwai@suse.de>
	<3a2444df0908200032r39c57844l4d74c5b49a08e531@mail.gmail.com>
	<s5h8whezxu7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f187.google.com (mail-iw0-f187.google.com
	[209.85.223.187])
	by alsa0.perex.cz (Postfix) with ESMTP id 2B7CF243E4
	for <alsa-devel@alsa-project.org>;
	Sun, 30 Aug 2009 14:13:44 +0200 (CEST)
Received: by iwn17 with SMTP id 17so1421210iwn.16
	for <alsa-devel@alsa-project.org>; Sun, 30 Aug 2009 05:13:43 -0700 (PDT)
In-Reply-To: <s5h8whezxu7.wl%tiwai@suse.de>
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

> That's the reason.  dmix uses the ALSA timer device to sync the

position.


> Takashi


Thanks a lot, I moved /dev/timer to /dev/snd/timer and aplay (and dmix
plugin) worked!

Ruchi

On Thu, Aug 20, 2009 at 2:06 PM, Takashi Iwai <tiwai@suse.de> wrote:

> At Thu, 20 Aug 2009 13:02:20 +0530,
> ruchi sirauthiya wrote:
> >
> > Hi,
> > No, I do not have /dev/snd/timer device entry.
>
> That's the reason.  dmix uses the ALSA timer device to sync the
> position.
>
>
> Takashi
>
> >
> > A small correction... I am using TPS65950 codec and not TWL4030.
> >
> > Ruchi Sirauthiya
> >
> >
> > On Wed, Aug 19, 2009 at 5:46 PM, Takashi Iwai <tiwai@suse.de> wrote:
> >
> > > At Sun, 16 Aug 2009 15:49:11 +0530,
> > > ruchi sirauthiya wrote:
> > > >
> > > > Hi,
> > > >
> > > > I am trying to enable a software mixer (using ALSA and dmix) on an
> OMAP3
> > > > based embedded target board using the twl4030 codec.
> > > >
> > > > When I try to play audio using the command,
> > > >
> > > > # aplay -D playback rec.wav
> > > >
> > > > I am getting the following error:
> > > >
> > > > ALSA lib pcm_direct.c:1098:(snd_pcm_direct_initialize_poll_fd) unable
> to
> > > > open timer 'hw:CLASS=3,SCLASS=0,CARD=0,DEV=0,SUBDEV=0'
> > >
> > > Do you have /dev/snd/timer device?
> > >
> > >
> > > Takashi
> > >
> > [2  <text/html; ISO-8859-1 (quoted-printable)>]
> >
>
