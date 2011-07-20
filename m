From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [REPOST][PATCH v4 3/4] ASoC: SAMSUNG: Modify I2S
 driver to support idma
Date: Wed, 20 Jul 2011 20:59:11 +0100
Message-ID: <20110720195911.GF26043@opensource.wolfsonmicro.com>
References: <1311149233-24343-1-git-send-email-sbkim73@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4C2081038FA
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Jul 2011 21:59:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1311149233-24343-1-git-send-email-sbkim73@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sangbeom Kim <sbkim73@samsung.com>
Cc: alsa-devel@alsa-project.org, jassisinghbrar@gmail.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 20, 2011 at 05:07:12PM +0900, Sangbeom Kim wrote:
> Previously, I2S driver only can support system dma.
> In this patch, i2s driver can support internal dma too.
> IDMA h/w configuration is initialized on idma.c

I've applied this and patch 4 as they seem to make sense by themselves
but I can't see patch 1 or patch 2?
