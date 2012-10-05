From: Sangbeom Kim <sbkim73@samsung.com>
Subject: Re: [PATCH] ASoC: SAMSUNG: spdif: use
	clk_prepare_enable	and clk_disable_unprepare
Date: Fri, 05 Oct 2012 13:51:04 +0900
Message-ID: <012401cda2b5$06b38120$141a8360$@com>
References: <1349221705-3030-1-git-send-email-thomas.abraham@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 by alsa0.perex.cz (Postfix) with ESMTP id 08BF826507C
 for <alsa-devel@alsa-project.org>; Fri,  5 Oct 2012 06:51:00 +0200 (CEST)
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MBE00F32LGLY800@mailout4.samsung.com> for
 alsa-devel@alsa-project.org; Fri, 05 Oct 2012 13:50:49 +0900 (KST)
Received: from DOSBKIM7302 ([10.90.35.108])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MBE0020HLGOMQ50@mmp1.samsung.com> for
 alsa-devel@alsa-project.org; Fri, 05 Oct 2012 13:50:48 +0900 (KST)
In-reply-to: <1349221705-3030-1-git-send-email-thomas.abraham@linaro.org>
Content-language: ko
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: 'Thomas Abraham' <thomas.abraham@linaro.org>, alsa-devel@alsa-project.org
Cc: linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, lrg@ti.com, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Wednesday, Oct 03, 2012 at 8:48 AM, Thomas Abraham wrote:

> Subject: [alsa-devel] [PATCH] ASoC: SAMSUNG: spdif: use clk_prepare_enable and
> clk_disable_unprepare
> 
> Convert clk_enable/clk_disable to clk_prepare_enable/clk_disable_unprepare
> calls as required by common clock framework.
> 
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>

Acked-by: Sangbeom Kim <sbkim73@samsung.com>

Thanks,
Sangbeom.
