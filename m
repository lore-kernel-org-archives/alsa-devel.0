From: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH 2/2] ASoC: fsl: fix initialization of DMA
	buffers
Date: Thu, 9 Jun 2011 12:39:07 +0000
Message-ID: <4DF0BEEA.60100@freescale.com>
References: <1307563376-13055-1-git-send-email-timur@freescale.com>
	<1307563376-13055-2-git-send-email-timur@freescale.com>
	<20110609105246.GD12865@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from TX2EHSOBE004.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) by alsa0.perex.cz (Postfix) with ESMTP id 3D3B4103B51
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Jun 2011 14:39:14 +0200 (CEST)
In-Reply-To: <20110609105246.GD12865@opensource.wolfsonmicro.com>
Content-Language: en-US
Content-ID: <2B0AEFC19275F345A615984004E0D3D7@freescale.net>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@ti.com" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
>> >  Also provide a better name for the DMA interrupt.

> ...this doesn't overlap with the bugfix at all.  Why have you sent it as
> part of the same patch?

Because I didn't want to send another tiny patch for this relatively 
insignificant change.

But I will refrain from doing this again.

-- 
Timur Tabi
Linux kernel developer at Freescale
