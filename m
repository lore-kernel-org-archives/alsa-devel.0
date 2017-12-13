From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH v2 00/11] ASoC: fsl_ssi: Clean up - coding
	style level
Date: Wed, 13 Dec 2017 23:37:53 +0100
Message-ID: <55c0bd4e-078e-2825-9fac-f062a08e3450@maciej.szmigiero.name>
References: <1513146874-25476-1-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C7D4266D45
 for <alsa-devel@alsa-project.org>; Wed, 13 Dec 2017 23:37:59 +0100 (CET)
In-Reply-To: <1513146874-25476-1-git-send-email-nicoleotsuka@gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: alsa-devel@alsa-project.org, timur@tabi.org, kernel@pengutronix.de, linux-kernel@vger.kernel.org, caleb@crome.org, lgirdwood@gmail.com, broonie@kernel.org, arnaud.mouiche@invoxia.com, lukma@denx.de, fabio.estevam@nxp.com, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On 13.12.2017 07:34, Nicolin Chen wrote:
> ==Changelog==
> v1->v2
>  * Dropped one patch to remove "struct device"
>  * Revised PATCH-03 "Refine all comments"
>  * Revised PATCH-05 "Refine indentations and wrappings"
>  * Rebased all other patches
>  * Added PATCH-10 "Rename i2smode to i2s_net"
>  * Added PATCH-11 "Define ternary macros to simplify code"
> 
>  # Detialed changes are described in each updated patch.
> 
> ==Background==
> The fsl_ssi driver was designed for PPC originally and then it has
> been updated to support different modes for i.MX Series, including
> SDMA, I2S Master mode, AC97 and older i.MXs with FIQ, by different
> contributors for different use cases in different coding styles.
> 
> Additionally, in order to fix/work-around hardware bugs and design
> flaws, the driver made a lot of compromise so now its program flow
> looks very complicated and it's getting hard to maintain or update.
> 
> So I am going to clean up the driver on both coding style level and
> program flow level.
> 
> ==Introduction==
> This series of patches is the first set to clean up fsl_ssi driver
> in the coding style level. Any patch here is not supposed to change
> the program flow.
> 
> ==Verification==
> Theoretically, since these patches do not change program flow, they
> only need code review, build or sanity tests. I have done build and
> sanity tests on an i.MX6SoloX with WM8962 using imx_v6_v7_defconfig
> and playback/record tests in I2S Master/Slave modes.
> 
> Nicolin Chen (11):
>   ASoC: fsl_ssi: Rename fsl_ssi_private to fsl_ssi
>   ASoC: fsl_ssi: Cache pdev->dev pointer
>   ASoC: fsl_ssi: Refine all comments
>   ASoC: fsl_ssi: Rename registers and fields macros
>   ASoC: fsl_ssi: Refine indentations and wrappings
>   ASoC: fsl_ssi: Refine printk outputs
>   ASoC: fsl_ssi: Rename cpu_dai parameter to dai
>   ASoC: fsl_ssi: Rename scr_val to scr
>   ASoC: fsl_ssi: Replace fsl_ssi_rxtx_reg_val with fsl_ssi_regvals
>   ASoC: fsl_ssi: Rename i2smode to i2s_net
>   ASoC: fsl_ssi: Define ternary macros to simplify code
> 
>  sound/soc/fsl/fsl_ssi.c     | 1373 +++++++++++++++++++------------------------
>  sound/soc/fsl/fsl_ssi.h     |  427 ++++++++------
>  sound/soc/fsl/fsl_ssi_dbg.c |   59 +-
>  3 files changed, 876 insertions(+), 983 deletions(-)
> 

For the whole series:
Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Reviewed-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>

Thanks.
