From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: MPC5200: replace of_device with
 platform_device
Date: Wed, 24 Aug 2011 16:44:57 +0100
Message-ID: <20110824154456.GB16653@opensource.wolfsonmicro.com>
References: <1314136106-26127-1-git-send-email-timur@freescale.com>
	<20110824091645.GD26317@sirena.org.uk> <4E551A5B.805@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 586BB103910
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Aug 2011 17:44:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E551A5B.805@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 24, 2011 at 10:35:55AM -0500, Timur Tabi wrote:
> Mark Brown wrote:

> > Which version does this build issue apply to - 3.1 or 3.2?

> Everything.  It fixes a build break.

> The defconfig for the MPC5200 does not enable audio, so by default the build
> won't break.  It's up to you if you want to push this for 3.1.

I'll apply it for 3.1, I was asking because I didn't know if the API
change happened in 3.1 or was only present 3.2.  Thanks.
