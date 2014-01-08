From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: mx6: Audio does not work on linux-next 20140107
Date: Wed, 8 Jan 2014 13:04:32 +0800
Message-ID: <20140108050431.GD6750@MrMyself>
References: <CAOMZO5C=TFczzz8CQj6N=N_Z=p26_73SJvSk5cmp9FPVxF+O=A@mail.gmail.com>
 <52CBEDFA.10603@metafoo.de>
 <CAOMZO5C18WJQKJPuK_Pwq=EW0UhFh=9wxc4M4QEGBscZCHim8g@mail.gmail.com>
 <20140107122813.GA6750@MrMyself>
 <CAOMZO5AC5n-intSnUdnBJyYVO2O2BfPYMj_SwNP6jXD5qxVp9g@mail.gmail.com>
 <CAOMZO5DD-SXe9GKdvTEPccJe5rhR4zVNQF=Of1iUsbqrBtAXPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0187.outbound.messaging.microsoft.com [213.199.154.187])
 by alsa0.perex.cz (Postfix) with ESMTP id BF8752616FF
 for <alsa-devel@alsa-project.org>; Wed,  8 Jan 2014 06:15:15 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CAOMZO5DD-SXe9GKdvTEPccJe5rhR4zVNQF=Of1iUsbqrBtAXPg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Nicolin Chen <b42378@freescale.com>, Mark Brown <broonie@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

Hi Fabio,

On Wed, Jan 08, 2014 at 01:50:45AM -0200, Fabio Estevam wrote:
> In 3.12 and 3.13-rc we are able to play audio without using any SDMA
> firmware, but it we are not longer able to do this now. Other than
> that, people will have to use the exact 2.1 firmware version, so there
> will be a regression in 3.14, right?

I think it is impossible to run SDMA without firmware, which stores all
the scripts we need, including Audio's one. Although the upstream kernel
doesn't have firmware, the reason why you were able to run audio playback
is because you have the firmware in your rootfs. So since the driver's
upgraded, it's plausible for us to upgrade the firmware as well. But I
do agree the way we handle the old version while trying to use the new
script isn't professional. Ideally we should switch the script to the
old one if we find the firmware version is 1.1. But technically it's
hard to achieve that since we assign the script in DT.

So currently if people are gonna use 3.14, they might need to upgrade
their firmware as you just tried to your rootfs.
 
> Couldn't we keep the 3.12/3.13 behaviour, ie, be able to play audio
> without loading any SDMA firmware?

There are two ways to keep it as the old one. First is patching the SDMA
firmware patch, including v2, to upstream kernel. And the second is to
revert the patch (ARM: dts: imx: use dual-fifo sdma script for ssi) so
that the SSI driver and SDMA driver would continue to use the old single
FIFO mode.

I'll align this issue with Shawn first to see if there's a better solution.

Thank you,
Nicolin Chen
