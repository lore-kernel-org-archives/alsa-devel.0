From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] S3C64XX I2S: Added machine driver
	for	WM8580
Date: Thu, 17 Sep 2009 13:03:53 +0100
Message-ID: <20090917120353.GF20676@sirena.org.uk>
References: <1253163253-10372-1-git-send-email-jassisinghbrar@gmail.com>
	<20090917110241.GC30736@rakim.wolfsonmicro.main>
	<1b68c6790909170435x2e4cd93an77fdb0bfef7feb18@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 237261037EA
	for <alsa-devel@alsa-project.org>;
	Thu, 17 Sep 2009 14:03:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1b68c6790909170435x2e4cd93an77fdb0bfef7feb18@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jassi brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, ben@trinity.fluff.org, Jassi <jassi.brar@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 17, 2009 at 08:35:56PM +0900, jassi brar wrote:

> This note means stands for the forthcoming cases. The explanation is already
> given above the switch.

> /* Currently, WM8580 driver doesn't support PLL-out rates
>  * other than those mentioned in Table-52 Page-58 of WM8580A
>  * manual. Some of these unavailable rates include
>  * {8000x256, 64000x256, 11025x256}Hz.

Which version of the datasheet are you looking at?  Table 52 in the
current version 4.7 is (as it says) a list of example configurations,
not an exhaustive list of supported configurations.  Anything within the
operating characteristics of the PLL is supported, set_pll() should
enforce this where required.

> > All my previous comments about these and the way they're being
> > configured still apply.

> Once 6channel support is up, i will submit a patch to implement audio
> routing options
> using snd_soc_add_controls. Whereby user can set audio route on the device.
> For now, as we have only 2channels enabled, i decided to enable only Front-L/R
> and keep others disabled. Of the Mic and LineIn, we enable LineIn by
> default. How is that?

Please just remove this for now or at most enable everything by default,
like I say it's not buying anything except confusion as it stands.

If it's not present then the machine driver will immediately work when
six channel support is added.
