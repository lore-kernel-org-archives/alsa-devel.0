From: Alastair Bridgewater <alastair.bridgewater@gmail.com>
Subject: Re: [PATCH 0/6] ALSA: hda/ca0132: Various cleanups and
	fixes
Date: Tue, 19 Jun 2018 09:18:41 -0400
Message-ID: <CAEcYz2QSL5n12zonud4oB9mAK7aL2cx7xD7hF0dYaCfL4gjzuQ@mail.gmail.com>
References: <20180616015620.26663-1-alastair.bridgewater@gmail.com>
 <s5h1sd5ubb3.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f193.google.com (mail-io0-f193.google.com
 [209.85.223.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6560E2673CB
 for <alsa-devel@alsa-project.org>; Tue, 19 Jun 2018 15:18:44 +0200 (CEST)
Received: by mail-io0-f193.google.com with SMTP id d22-v6so150372iof.13
 for <alsa-devel@alsa-project.org>; Tue, 19 Jun 2018 06:18:44 -0700 (PDT)
In-Reply-To: <s5h1sd5ubb3.wl-tiwai@suse.de>
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
Cc: Connor McAdams <conmanx360@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Jun 17, 2018 at 3:22 AM, Takashi Iwai <tiwai@suse.de> wrote:

> On Sat, 16 Jun 2018 03:56:14 +0200,
> Alastair Bridgewater wrote:
> >
> > The ca0132 codec support is fairly crufty, and the new R3Di and SBZ
> > support hasn't exactly improved that situation.  This patch series
> > tries to clean up a small amount of longstanding cruft, reverse some
> > behavioral changes to other systems made by the recent R3Di/SBZ
> > patches, and make the DMic work properly on the Alienware M17x R4.
> >
> > For two of these patches (the QUIRK_ALIENWARE patch and the DMic
> > patch), it may be that the correct behavior is the exact OPPOSITE of
> > what the patch does as far as quirk testing goes (that is, it should
> > apply globally, rather than limited to some specific quirk or set of
> > quirks), but I have no way to make such a determination at this time,
> > so erring on the side of the status quo ante seems appropriate.
> >
> > Alastair Bridgewater (6):
> >   ALSA: hda/ca0132: Delete pointless assignments to struct auto_pin_cfg
> >     fields
> >   ALSA: hda/ca0132: Delete redundant UNSOL event requests
> >   ALSA: hda/ca0132: Restore behavior of QUIRK_ALIENWARE
> >   ALSA: hda/ca0132: Don't test for QUIRK_NONE
> >   ALSA: hda/ca0132: Restore PCM Analog Mic-In2
> >   ALSA: hda/ca0132: Fix DMic data rate for Alienware M17x R4
>
> Since these look like reasonable fixes, I applied all six patches as
> is now.
>
> If any further fixes are needed, please make on top of these.
>

Wonderful!  Thank you.  About the only other patch that I can see
making at this point is to call ca0132_alt_vol_setup() on all systems,
and I could go either way on that.

With a bit of luck, I may have another patch series in a month or so.
Not suitable for 4.18, but maybe for 4.19 or so?


> thanks,
>
> Takashi
>
