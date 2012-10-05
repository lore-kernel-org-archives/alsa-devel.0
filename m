From: Sangbeom Kim <sbkim73@samsung.com>
Subject: Re: [PATCH] ASoC: SAMSUNG: i2s: use clk_prepare_enable
 and	clk_disable_unprepare
Date: Fri, 05 Oct 2012 13:43:37 +0900
Message-ID: <012101cda2b3$fc2f33d0$f48d9b70$@com>
References: <1349221618-2943-1-git-send-email-thomas.abraham@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 by alsa0.perex.cz (Postfix) with ESMTP id EAA7826507B
 for <alsa-devel@alsa-project.org>; Fri,  5 Oct 2012 06:43:25 +0200 (CEST)
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MBE00LUUL1ONRI0@mailout1.samsung.com> for
 alsa-devel@alsa-project.org; Fri, 05 Oct 2012 13:43:21 +0900 (KST)
Received: from DOSBKIM7302 ([10.90.35.108])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MBE00HKPL498CI0@mmp2.samsung.com> for
 alsa-devel@alsa-project.org; Fri, 05 Oct 2012 13:43:21 +0900 (KST)
In-reply-to: <1349221618-2943-1-git-send-email-thomas.abraham@linaro.org>
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
Cc: jassisinghbrar@gmail.com, kgene.kim@samsung.com, lrg@ti.com, linux-samsung-soc@vger.kernel.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Wednesday, Oct 03, 2012 at 8:47 AM, Thomas Abraham wrote:

> Subject: [alsa-devel] [PATCH] ASoC: SAMSUNG: i2s: use clk_prepare_enable and clk_disable_unprepare
> 
> Convert clk_enable/clk_disable to clk_prepare_enable/clk_disable_unprepare
> calls as required by common clock framework.
> 
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>

Currently, Common clock framework for exynos series is being worked.
To fully support common clock framework, 
need to replace clk_enable with clk_prepare_enable.
It looks that There is no side effect for ccf unsupported device.

Acked-by: Sangbeom Kim <sbkim73@samsung.com>

Thanks,
Sangbeom.
