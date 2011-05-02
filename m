From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH 02/10] ALSA: hda - Add channel-mode support
 to Realtek auto-parser
Date: Mon, 2 May 2011 14:57:51 +0800
Message-ID: <BANLkTi=xXFOgoovsDT4v6oXeAxaJ8AKKUw@mail.gmail.com>
References: <1304097516-7258-1-git-send-email-tiwai@suse.de>
	<1304097516-7258-3-git-send-email-tiwai@suse.de>
	<BANLkTim4sF9_66O-cb7+THZBC-fbxWbe6Q@mail.gmail.com>
	<s5h4o5dmxao.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 31BF31037E3
	for <alsa-devel@alsa-project.org>;
	Mon,  2 May 2011 08:57:53 +0200 (CEST)
Received: by fxm5 with SMTP id 5so4051330fxm.38
	for <alsa-devel@alsa-project.org>; Sun, 01 May 2011 23:57:51 -0700 (PDT)
In-Reply-To: <s5h4o5dmxao.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/5/2 Takashi Iwai <tiwai@suse.de>

> At Mon, 2 May 2011 10:06:15 +0800,
> Raymond Yau wrote:
> >
> > 2011/4/30 Takashi Iwai <tiwai@suse.de>
> >
> > > This patch adds the support of "Channel Mode" enum control to Realtek
> > > auto-parser.  When line-in or mic-in jacks are capable to output and
> > > free DACs are available, the driver allows to switch to multi-channel
> > > mode via "Channel Mode" enum switch, as already implemented in some
> > > preset cases.
> > >
> > > Not implemented in all Realtek codecs.  Currently, ALC880, 882, 861,
> > > 662 and the compatible codecs are supported.
> > >
> > > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > > ---
> > >
> >
> > Why the line out become "speaker" for G41M-ES2L with 3 audio jacks at
> rear
> > panel ?
> > The driver won't  create "Channel Mode" control and it cannot support
> > surround51
>
> It's just because of pin fixup that I'm going to revert.
>
> Even revert  the pin config, and distable auto mute,
the channel mode still allow 2, 4 or 6 channels

IT seem that there is no way to use "HP" as "Side" to support surround 7.1
as mentioned in the user manual (Chapter 5 Appendix)

5-1-1 Configuring 2/4/5.1/7.1-Channel Audio
