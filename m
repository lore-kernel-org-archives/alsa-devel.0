From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: MPC5200: replace of_device with
 platform_device
Date: Thu, 25 Aug 2011 10:34:33 +0100
Message-ID: <20110825093432.GA31154@opensource.wolfsonmicro.com>
References: <1314136106-26127-1-git-send-email-timur@freescale.com>
	<20110824091645.GD26317@sirena.org.uk> <4E551A5B.805@freescale.com>
	<20110824154456.GB16653@opensource.wolfsonmicro.com>
	<4E551DAA.2040509@freescale.com>
	<20110824155719.GC16653@opensource.wolfsonmicro.com>
	<4E555509.7080905@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 30302248D7
	for <alsa-devel@alsa-project.org>;
	Thu, 25 Aug 2011 11:34:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E555509.7080905@freescale.com>
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

On Wed, Aug 24, 2011 at 02:46:17PM -0500, Timur Tabi wrote:

> I suspect the problem is that the defconfig for the MPC5200 doesn't actually
> enable audio, so when that platform was tested, none of the ASoC code was
> actually compiled.

OK, thanks for checking and fixing.  Like I said on IRC I applied the
patch with a CC to stable.
