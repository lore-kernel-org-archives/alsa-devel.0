From: Taylor Hutt <thutt@google.com>
Subject: Re: [PATCH] ASoC: codecs: Max98095: Fix logging of
	hardware revision.
Date: Mon, 20 Jun 2011 20:22:32 -0700
Message-ID: <BANLkTikH6XpGNamh8z4zspxteH3K4mNmew@mail.gmail.com>
References: <1308596072-17158-1-git-send-email-thutt@chromium.org>
	<20110621002322.GE1905@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out.google.com (smtp-out.google.com [216.239.44.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 7C5E3103892
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Jun 2011 05:22:38 +0200 (CEST)
Received: from wpaz21.hot.corp.google.com (wpaz21.hot.corp.google.com
	[172.24.198.85]) by smtp-out.google.com with ESMTP id p5L3MYON002429
	for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2011 20:22:35 -0700
Received: from pzd13 (pzd13.prod.google.com [10.243.17.205])
	by wpaz21.hot.corp.google.com with ESMTP id p5L3M2nE026916
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2011 20:22:33 -0700
Received: by pzd13 with SMTP id 13so6083367pzd.39
	for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2011 20:22:33 -0700 (PDT)
In-Reply-To: <20110621002322.GE1905@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Peter Hsiang <Peter.Hsiang@maxim-ic.com>, Olof Johansson <olofj@chromium.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 20, 2011 at 5:23 PM, Mark Brown <
broonie@opensource.wolfsonmicro.com> wrote:

> On Mon, Jun 20, 2011 at 11:54:32AM -0700, Taylor Hutt wrote:
> > The base hardware revision of the Maxim 98095 part is 0x40; the code
> > which outputs the revision of the hardware has been updated to
> > properly use uppercase alphabetic values for the revision numbers.
>
> Are you sure that this is true for all devices that might be supported
> by the driver (I'm guessing there may be other variants)?  There's often
> a drift between silicon and package revisions which gets papered over by
> datasheets and ignored by drivers.
>
>
Got this information from Peter, as he notes below.  I'm just the messenger
on this particular change; I'm merely trying to upstream
the information he provided me.  Whatever you folks want, I'll be happy to
do.



> > Also, the use of a constant for the length 'max98095_dai' has been
> > replaced with ARRAY_SIZE().
>
> Don't include a series of random unrelated changes in a single patch,
> split them up into separate patches.  This makes review much easier if
> nothing else.  There's no overlap at all between this change and the one
> above.  The change is sensible.
>

Ok, fine.  Seemed trivial enough and didn't seem like the code churn for
another patch was warranted.
But, ok.

>
> >       ret = snd_soc_read(codec, M98095_0FF_REV_ID);
> >       if (ret < 0) {
> > -             dev_err(codec->dev, "Failed to read device revision: %d\n",
> > +             dev_err(codec->dev, "Failure reading hardware revision:
> %d\n",
> >                       ret);
>
> You've also got this again unrelated change which isn't mentioned in the
> changelog at all.
>

This is part of the change for the hardware revision, and it seems pretty
clear that they're related to me.  The text of the two output messages are
now more aligned, and they are both related to reporting the hardware
revision.

-- 
There is no better hors d'oeuvres than bacon wrapped dates.
