From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] davinci: da8xx/omap-l1xx: match codec_name
 with i2c ids
Date: Tue, 25 Jan 2011 10:59:05 +0000
Message-ID: <1295953146.3322.17.camel@odin>
References: <1295619896-5498-1-git-send-email-sudhakar.raj@ti.com>
	<1295620708.3348.233.camel@odin> <8739oh6h5i.fsf@ti.com>
	<87r5c15272.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id E8CAA10388A
	for <alsa-devel@alsa-project.org>; Tue, 25 Jan 2011 11:59:13 +0100 (CET)
Received: by eyg24 with SMTP id 24so2361040eyg.38
	for <alsa-devel@alsa-project.org>; Tue, 25 Jan 2011 02:59:10 -0800 (PST)
In-Reply-To: <87r5c15272.fsf@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kevin Hilman <khilman@ti.com>
Cc: davinci-linux-open-source@linux.davincidsp.com, dansharon@nanometrics.ca, alsa-devel@alsa-project.org, "Rajashekhara,
	Sudhakar" <sudhakar.raj@ti.com>, stable@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2011-01-24 at 15:09 -0800, Kevin Hilman wrote:
> Kevin Hilman <khilman@ti.com> writes:
> 
> > Liam Girdwood <lrg@slimlogic.co.uk> writes:
> >
> >> On Fri, 2011-01-21 at 19:54 +0530, Rajashekhara, Sudhakar wrote:
> >>> The codec_name entry for da8xx evm in sound/soc/davinci/davinci-evm.c
> >>> is not matching with the i2c ids in the board file. Without this fix the
> >>> soundcard does not get detected on da850/omap-l138/am18x evm.
> >>> 
> >>> Signed-off-by: Rajashekhara, Sudhakar <sudhakar.raj@ti.com>
> >>> Tested-by: Dan Sharon <dansharon@nanometrics.ca>
> >>> ---
> >>> This patch applies to Linus's kernel tree.
> >>> 
> >>>  sound/soc/davinci/davinci-evm.c |    2 +-
> >>>  1 files changed, 1 insertions(+), 1 deletions(-)
> >>> 
> >>> diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
> >>> index 0c2d6ba..b36f0b3 100644
> >>> --- a/sound/soc/davinci/davinci-evm.c
> >>> +++ b/sound/soc/davinci/davinci-evm.c
> >>> @@ -223,7 +223,7 @@ static struct snd_soc_dai_link da8xx_evm_dai = {
> >>>  	.stream_name = "AIC3X",
> >>>  	.cpu_dai_name= "davinci-mcasp.0",
> >>>  	.codec_dai_name = "tlv320aic3x-hifi",
> >>> -	.codec_name = "tlv320aic3x-codec.0-001a",
> >>> +	.codec_name = "tlv320aic3x-codec.1-0018",
> >>>  	.platform_name = "davinci-pcm-audio",
> >>>  	.init = evm_aic3x_init,
> >>>  	.ops = &evm_ops,
> >>
> >> Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
> >
> > Liam,
> >
> > I'm assuming you'll merge this one via the ASoC tree?
> >
> 
> On second thought, these should probably merge for .38-rc3.
> 
> If you're OK with it, I can merge this and the platform fix together for
> .38-rc3.

Yes please :)

Thanks !

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
