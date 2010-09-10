From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCHv2 1/2] ASoC: S3C: Fix PCM RX FIFO settings
Date: Fri, 10 Sep 2010 12:13:39 +0100
Message-ID: <1284117219.3088.226.camel@odin>
References: <AANLkTimWZ-eSr4boXbyxbunDcm3Da1vEAZvP65Up63uE@mail.gmail.com>
	<1284106800-13520-1-git-send-email-sw.youn@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id E706F10397C
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Sep 2010 13:13:44 +0200 (CEST)
Received: by wyb32 with SMTP id 32so2570803wyb.38
	for <alsa-devel@alsa-project.org>; Fri, 10 Sep 2010 04:13:43 -0700 (PDT)
In-Reply-To: <1284106800-13520-1-git-send-email-sw.youn@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Seungwhan Youn <sw.youn@samsung.com>
Cc: alsa-devel@alsa-project.org, Jassi Brar <jassisinghbrar@gmail.com>, Seungwhan Youn <claude.youn@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-09-10 at 17:20 +0900, Seungwhan Youn wrote:
> When PCM capture, sound recorded abnormally because of RX FIFO
> threshold settings are missing. So, This patch modify PCM RX FIFO
> setting codes same as TX.
> And for DMA, if PCM RXFIFO_DIPSTICK is not '0', it doesn't effect
> to DMA request, because DMA refer RX_FIFO_EMPTY flag as the DMA
> request.
> 
> Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>

Both

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
