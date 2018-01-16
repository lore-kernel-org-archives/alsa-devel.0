From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH v4 00/17] ASoC: fsl_ssi: Clean up - program
	flow level
Date: Wed, 17 Jan 2018 00:38:09 +0100
Message-ID: <56fb5b43-383f-c0f2-360c-eef0e4d0844f@maciej.szmigiero.name>
References: <1516058192-65519-1-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
 by alsa0.perex.cz (Postfix) with ESMTP id AD5D8266F5F
 for <alsa-devel@alsa-project.org>; Wed, 17 Jan 2018 00:38:16 +0100 (CET)
In-Reply-To: <1516058192-65519-1-git-send-email-nicoleotsuka@gmail.com>
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
Cc: alsa-devel@alsa-project.org, kernel@pengutronix.de, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, caleb@crome.org, timur@tabi.org, broonie@kernel.org, arnaud.mouiche@invoxia.com, lukma@denx.de, fabio.estevam@nxp.com, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On 16.01.2018 00:16, Nicolin Chen wrote:
> ==Change log==
> v4
>  * Reworked the series by taking suggestions from Maciej
>   + Added TXBIT0 bit back to play safe in PATCH-14
>   + Made bool synchronous exclusive with AC97 mode in PATCH-16
> v3
>  * Reworked the series by taking suggestions from Maciej
>   + Added PATCH-01 to make RX and TX more clearly defined
>   + Replaced "bool dir" with "int dir" in PATCH-04
>   + Replaced "!dir" with "int adir" in PATCH-05
>   + Put CBM_CFS behind the baudclk check to keep the same
>     program flow in PATCH-14
>   + Removed all cpu_dai_drv changes in PATCH-15
> v2
>  * Reworked the series by taking suggestions from Maciej
>   + Added PATCH-01 to keep all ssi->i2s_net updated
>   + Replaced bool tx with bool dir in PATCH-03 and PATCH-06
>   + Moved all initial register configurations from dai probe() to
>     platform probe() so as to let AC97 CODEC successfully probe.
>  * Added Tested-by from Caleb for TDM test cases.
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
> This series of patches is the second set to clean up fsl_ssi driver
> in the program flow level. Any patch here may impact a fundamental
> test case like playback or record.
> 
> ==Verification==
> This series of patches require fully tested. I have done such tests
> on i.MX6SoloX with WM8962 using imx_v6_v7_defconfig as:
>  - Playback via I2S Master and Slave mode
>  - Record via I2S Master and Slave mode
>  - Simultaneous playback and record via I2S Master and Slave mode
>  - Background playback with foreground record (starting at different
>    time) via I2S Master and Slave mode
>  - Background record with foreground playback (starting at different
>    time) via I2S Master and Slave mode
>  * All tests above by hacking offline_config to true in imx51.
> 
> Caleb has tested v1 with TDM lookback tests on i.MX6.
> 
> Example of uncovered tests: AC97, PowerPC and FIQ.

I've tested the whole series in the AC'97 mode on an i.MX6 UDOO board
and everything seems to work fine as long as few small changes are made
to patches 13 and 16.

Maciej
