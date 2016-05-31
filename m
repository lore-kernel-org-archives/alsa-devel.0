From: Caleb Crome <caleb@crome.org>
Subject: Re: [PATCH v5] ASoC: cs53l30: Add support for Cirrus
 Logic CS53L30
Date: Tue, 31 May 2016 15:32:05 -0700
Message-ID: <CAG5mAdwB-YCiFV0L+KgULKcmRVEhHK68mBrf9UHe0s-1UBotJQ@mail.gmail.com>
References: <1458082066-2859-1-git-send-email-tim.howe@cirrus.com>
 <20160517234333.GB29471@Asurada-Nvidia> <20160531165358.GH29837@sirena.org.uk>
 <CAG5mAdw-gh2_ZQ17h3HS=pMZaW-bGhoKgNDz_hbwzw2rBKs8ig@mail.gmail.com>
 <20160531173505.GI29837@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f194.google.com (mail-yw0-f194.google.com
 [209.85.161.194])
 by alsa0.perex.cz (Postfix) with ESMTP id B909F26595B
 for <alsa-devel@alsa-project.org>; Wed,  1 Jun 2016 00:32:25 +0200 (CEST)
Received: by mail-yw0-f194.google.com with SMTP id y6so261974ywe.0
 for <alsa-devel@alsa-project.org>; Tue, 31 May 2016 15:32:25 -0700 (PDT)
In-Reply-To: <20160531173505.GI29837@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, paul.handrigan@cirrus.com, "Howe,
 Tim" <tim.howe@cirrus.com>
List-Id: alsa-devel@alsa-project.org

On Tue, May 31, 2016 at 10:35 AM, Mark Brown <broonie@kernel.org> wrote:

> On Tue, May 31, 2016 at 10:10:11AM -0700, Caleb Crome wrote:
> > On Tue, May 31, 2016 at 9:53 AM, Mark Brown <broonie@kernel.org> wrote:
>
> > > That's a really rare thing to have as an option, most things either do
> > > TDM or parallel data signals but not both.
>
> > Interesting comment.  While I'm sure that's true for the moment,
> > microphone arrays are changing this quickly.  I fall into the oddball
> > category that the main chips I use are the TLV320AIC34 and CS53L30,
> > and both of them can switch between TDM mode or dual I2S mode for 4
> > channel support.
>
> I'm not sure why mic arrays would drive that, it's not like they're
> particularly new or innovative technology here and multi channel output
> has been even more widely available for a long time?
>

Good point.  I guess I'm coming from the SoC/mobile world where most SoCs
support stereo only, and a couple microphones at most.  Now phones have 3-4
or more microphones.   Amazon echo has 7 mics.  We're working on arrays of
16 and beyond, and getting those channels into linux has proven to be an
enormous headache given the hardware and software status of many of the
SoCs our customers want to use.


>
> > Since I need to get many channels on board, and SoCs (except for TI)
> > rarely have enough parallel I2S ports for mic arrays, I opt for TDM
> > mode often.
>
> Modern systems all use TDM for the most part ...
>

We must be looking at different sorts of chips :-)  Even on new parts like
the Snapdragon 410, they have a super inflexible I2S only port. (up to 3
parallel I2S for up to 6 channels, but no TDM).

>From my experience, the SoC support for TDM has been essentially
nonexistent, except for TI's McBSP and McASP.  I'd sure welcome a Cortex
A53 or A57 (or even A15 for that matter!) that has good TDM support.

Here are the chips that we've come across lately from our customers:

MX6 (SSI):  hardware supports TDM, but linux didn't until recently (thanks
everybody for help with that!)
MX6 (ESAI): not available on MX6 solo, nor on any SOM modules I've ever
seen, but supported if you can get to the pins.
MX7: (SAI):  hardware supports TDM, linux BSP driver does not.
TI parts (McASP): supported in hardware & software
TI parts (McBSP): supported in hardware & software
Qualcomm Snapdragon 410c (MI2S):  TDM not possible in hardware.  Supports
multiple parallel I2S channels only.
Broadcom:  (forgot part number...)  hardware supports TDM.  software still
in the works but apparently somebody's working on it.

A quick grep for channels_max > 2 in sound/soc shows the following few
drivers that support channels > 2 (not necessarily even in TDM mode).  All
the rest are 2 channels max.

pxa/mmp-sspa: 128/2 (playback/capture).
pxa/pxa-ssp:     8/8
zx286702-i2s.c:  8/2
fsl_esai: 12/8
fsl_ssi: 32/32
blackfin 5:  8/8 channels
blackfin 6:  2/2 channels only.
mcbsp: 16/16
mcasp: 512/512

and a few other chips that I'm not familiar with.  So  there does not seem
to be overwhelming support for TDM in Alsa ASoC.  To what extent this is a
software vs. hardware issue could use a little investigation.

the bummer is that even newer chips like the snapdragon are still using
really inflexible ports.

So... if anybody knows of a Cortex A53 or A57 with good TDM support in
linux (at least 16 channels in and out), I'd love to know about it :-)

-Caleb
