From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] S3C64XX I2S: Added machine driver for
 WM8580
Date: Thu, 17 Sep 2009 15:12:28 +0100
Message-ID: <20090917141228.GA24563@rakim.wolfsonmicro.main>
References: <1253163253-10372-1-git-send-email-jassisinghbrar@gmail.com>
	<20090917110241.GC30736@rakim.wolfsonmicro.main>
	<1b68c6790909170435x2e4cd93an77fdb0bfef7feb18@mail.gmail.com>
	<20090917120353.GF20676@sirena.org.uk>
	<1b68c6790909170526s4bf9e0e0m726dfe771ca71015@mail.gmail.com>
	<20090917131102.GA16720@rakim.wolfsonmicro.main>
	<1b68c6790909170636w6a5dc85cq8cae33daf64ca814@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4B4501037F2
	for <alsa-devel@alsa-project.org>;
	Thu, 17 Sep 2009 16:12:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1b68c6790909170636w6a5dc85cq8cae33daf64ca814@mail.gmail.com>
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

On Thu, Sep 17, 2009 at 10:36:10PM +0900, jassi brar wrote:
> On Thu, Sep 17, 2009 at 10:11 PM, Mark Brown

> > Your comment says that only the output frequencies in table 52 are
> > supported. =A0Could you please provide more specific references to where
> > this is done in the driver? =A0I think you're confusing the fact that t=
he
> > example table lists most of the common audio frequencies with what the
> > driver supports here.

> Let me be precise.
> With this machine driver and the WM8580 CODEC driver from origin/for-2.6.=
32
> if we do any of the following:-
>    snd_soc_dai_set_pll(codec_dai, WM8580_PLLA, 12000000, 8000*256);
>    snd_soc_dai_set_pll(codec_dai, WM8580_PLLA, 12000000, 11025*256);
>    snd_soc_dai_set_pll(codec_dai, WM8580_PLLA, 12000000, 64000*256);
> we get the error: "wm8580: Unable to scale output frequency"

Right, this is nothing to do with the list of example configurations and
everything to do with the fact that those options are just not supported
by the hardware.  For example, 256fs for 8kHz is only 2.048MHz and even
the largest postscale divider of 24 can't get anywhere near that from
90MHz which is the minimum Fvco for the PLL.

> I apologize if my inappropriate selection of expression bothered you.
> In future, please feel free to suggest modification of any comment in the
> code. Regards.

Part of the issue here is that my review is in part based on the
comments.  If the code (including comments) seems obviously incorrect
from reading then that's an issue in itself.
