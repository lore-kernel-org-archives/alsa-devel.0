From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH 0/10] Realtek auto-parser updates
Date: Sun, 1 May 2011 08:35:17 +0800
Message-ID: <BANLkTimzjn1XyzXUVDqW_vJzubtobwtbPw@mail.gmail.com>
References: <1304097516-7258-1-git-send-email-tiwai@suse.de>
	<BANLkTikYkZ5K1-Ws8b1LvpqimUN+0oT3FA@mail.gmail.com>
	<s5hk4ecavf2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id AE62F243E0
	for <alsa-devel@alsa-project.org>;
	Sun,  1 May 2011 02:35:17 +0200 (CEST)
Received: by fxm5 with SMTP id 5so3585949fxm.38
	for <alsa-devel@alsa-project.org>; Sat, 30 Apr 2011 17:35:17 -0700 (PDT)
In-Reply-To: <s5hk4ecavf2.wl%tiwai@suse.de>
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

2011/4/30 Takashi Iwai <tiwai@suse.de>

> At Sat, 30 Apr 2011 10:44:13 +0800,
> Raymond Yau wrote:
> >
> > [1  <text/plain; ISO-8859-1 (7bit)>]
> > 2011/4/30 Takashi Iwai <tiwai@suse.de>
> >
> > > Hi, this is a series of patches I'm going to apply as 2.6.40 material.
> > > Basically this adds the missing features to BIOS auto-parser mode, the
> > > support of multi-channel setup (2/4/6-channels) and the auto-mute of
> > > line-out jacks as well as speakers.
> > >
> > > Many changes have been done but mostly in systematic manner.
> > > I've checked through hda-emu and a few machines with Realtek codecs,
> > > but of course can't cover all changes I made.
> > >
> > > If you see any issues with the updated tree, please let me know.
> > >
> > >
> > How about those 4 jacks 8 channels notebook (e.g. ms-1656)  ?
>
> Currently, the detection of LO/MIC extension depends on the location
> of the jacks.  It assumes that these jacks are located at the same
> place as the corresponding line-out jack(s).
>
> I wrote in that way to avoid mis-detection.  It'd be easy to change it
> to look through other locations.
>
>
Refer to 2-17 of the user manual

Left Side View

Those four jacks are at the left side

Headphone out/SPDIF out : Used for speakers or headphones. The SPDIF
connector is also provided for digital audio transmission to external
speakers through an optical fiber cable.

How can the auto parser know it is a combo jack ?
