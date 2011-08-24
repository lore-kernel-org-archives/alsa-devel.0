From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ASoC: MPC5200: replace of_device with
	platform_device
Date: Wed, 24 Aug 2011 10:35:55 -0500
Message-ID: <4E551A5B.805@freescale.com>
References: <1314136106-26127-1-git-send-email-timur@freescale.com>
	<20110824091645.GD26317@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from VA3EHSOBE010.bigfish.com (va3ehsobe010.messaging.microsoft.com
	[216.32.180.30])
	by alsa0.perex.cz (Postfix) with ESMTP id 63286103910
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Aug 2011 17:43:45 +0200 (CEST)
In-Reply-To: <20110824091645.GD26317@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Tue, Aug 23, 2011 at 04:48:26PM -0500, Timur Tabi wrote:
>> 'struct of_device' no longer exists, and its functionality has been merged
>> into platform_device.  Update the MPC5200 audio DMA driver (mpc5200_dma)
>> accordingly.  This fixes a build break.
> 
> Which version does this build issue apply to - 3.1 or 3.2?

Everything.  It fixes a build break.

The defconfig for the MPC5200 does not enable audio, so by default the build
won't break.  It's up to you if you want to push this for 3.1.

-- 
Timur Tabi
Linux kernel developer at Freescale
