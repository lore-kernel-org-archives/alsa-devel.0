From: Grant Grundler <grundler@chromium.org>
Subject: Re: [PATCH V2] ASoC: max98373: Added max98373_reset for stable amp reset
Date: Wed, 28 Nov 2018 17:55:48 -0800
Message-ID: <CANEJEGse1DGQE6K=sn=bfJuQW=-gM6zps+kvKd8y=yzXjrsTZQ@mail.gmail.com>
References: <20181128031926.7157-1-ryans.lee@maximintegrated.com>
 <20181128094955.GG6828@sirena.org.uk> <DM6PR11MB3131E267C1EDF9254BC7D313E7D10@DM6PR11MB3131.namprd11.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <DM6PR11MB3131E267C1EDF9254BC7D313E7D10@DM6PR11MB3131.namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: RyanS.Lee@maximintegrated.com
Cc: broonie@kernel.org, Liam Girdwood <lgirdwood@gmail.com>, perex@perex.cz, tiwai@suse.com, Grant Grundler <grundler@chromium.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Benson Leung <bleung@chromium.org>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>, ryan.lee.maxim@gmail.com
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 28, 2018 at 9:07 AM Ryan Lee <RyanS.Lee@maximintegrated.com> wrote:
>
> >-----Original Message-----
> >From: Mark Brown <broonie@kernel.org>
> >Sent: Wednesday, November 28, 2018 1:50 AM
> >To: Ryan Lee <RyanS.Lee@maximintegrated.com>
> >Cc: Liam Girdwood <lgirdwood@gmail.com>; Jaroslav Kysela
> ><perex@perex.cz>; Takashi Iwai <tiwai@suse.com>; Grant Grundler
> ><grundler@chromium.org>; Kuninori Morimoto
> ><kuninori.morimoto.gx@renesas.com>; Benson Leung
> ><bleung@chromium.org>; alsa-devel@alsa-project.org; linux-
> >kernel@vger.kernel.org; ryan.lee.maxim@gmail.com
> >Subject: Re: [PATCH V2] ASoC: max98373: Added max98373_reset for stable
> >amp reset
> >
> >On Wed, Nov 28, 2018 at 03:20:16AM +0000, Ryan Lee wrote:
> >> Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
> >> ---
> >
> >Not seeing a changelog here like I asked for :(
>
> Actually I added changelog as below. Do you mean this is not sufficient?

The text is probably sufficient but not in a format that Mark can
directly apply.
Please take a quick look at Documentation/process/submitting-patches.rst.

Mark wants the "commit message" to be before the '---' line. So move
the "Changes:" text up to become the commit message and drop the
"Changes" line. That should explain why this commit is needed and
include the S-o-B line.

cheers,
grant

>
> Changes since v1 : Removed unusual repeat for amp software reset and verification.
>                    Amp software reset will be performed once and it repeats verification maximum 3 times if it is failed.
>                    Wait 10ms before every verification trial. Maximum 30ms delay will be applied to wait AMP idle state.
>
> >
> >> Changes : Created max98373_reset function to minimize code duplication.
> >>           Changed regmap_write to regmap_update_bits. Other bits except LSB
> >need to be masked.
> >>           Added reset verification step to make sure software reset is completed
> >well. Software reset is done in 10ms in normal case.
> >>           Revision ID is available when the amp is in the idle state which means
> >software reset is completed.
> >>           Software reset will be performed maximum 3 times to avoid amp reset
> >failure. Generally it is done in the first trial.
> >>           sleep time after software reset is increased + 30ms for every retrial.
> >Maximum possible msleep time is 100 ms (initial 10 ms + 30 ms * 3 times).
> >
> >This looks like it's supposed to be a changelog but it isn't one?
