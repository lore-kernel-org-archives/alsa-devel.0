From: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH 2/2] ASoC: fsl/powerpc: don't rely on the
 cell-index property
Date: Fri, 2 Dec 2011 12:14:44 +0000
Message-ID: <4ED8C133.2080908@freescale.com>
References: <1322790767-25846-1-git-send-email-timur@freescale.com>
	<1322790767-25846-2-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from AM1EHSOBE001.bigfish.com (am1ehsobe001.messaging.microsoft.com
	[213.199.154.204])
	by alsa0.perex.cz (Postfix) with ESMTP id 4A7692437F
	for <alsa-devel@alsa-project.org>; Fri,  2 Dec 2011 13:16:48 +0100 (CET)
In-Reply-To: <1322790767-25846-2-git-send-email-timur@freescale.com>
Content-Language: en-US
Content-ID: <8E830B83D3C4C645B1D18D4DEBC4A536@freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@ti.com" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Timur Tabi wrote:
> Instead of using the 'cell-index' property in the I2C adapter node to
> determine the adapter number, just query the i2c_adapter object directly.
>
> Previously, the I2C nodes always appeared in cell-index order, so the
> dynamic numbering coincided with the cell-index property.  With commit
> ab827d97 ("powerpc/85xx: Rework P1022DS device tree"), the I2C nodes are
> unintentionally reversed in the device tree, and so the machine driver
> guesses the wrong I2C adapter number.
>
> Signed-off-by: Timur Tabi<timur@freescale.com>

Mark,

Can you hold off on applying patch #2 for the moment?  I just thought of 
something that I want to try first.

Patch #1 is good to go, though.


-- 
Timur Tabi
Linux kernel developer at Freescale
