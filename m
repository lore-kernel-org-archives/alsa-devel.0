From: Caleb Crome <caleb@crome.org>
Subject: Re: [PATCH v4 00/17] ASoC: fsl_ssi: Clean up - program
	flow level
Date: Tue, 16 Jan 2018 13:26:08 -0800
Message-ID: <CAG5mAdxz99cM3a5K2Jk1hce+kfUNmhwuFr7Da_zpoW7Cw8avcg@mail.gmail.com>
References: <1516058192-65519-1-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f169.google.com (mail-pf0-f169.google.com
 [209.85.192.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 5E0C5266E62
 for <alsa-devel@alsa-project.org>; Tue, 16 Jan 2018 22:26:30 +0100 (CET)
Received: by mail-pf0-f169.google.com with SMTP id y5so10375375pff.13
 for <alsa-devel@alsa-project.org>; Tue, 16 Jan 2018 13:26:30 -0800 (PST)
In-Reply-To: <1516058192-65519-1-git-send-email-nicoleotsuka@gmail.com>
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
Cc: mail@maciej.szmigiero.name, Sascha Hauer <kernel@pengutronix.de>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Arnaud Mouiche <arnaud.mouiche@invoxia.com>, lukma@denx.de, Fabio Estevam <fabio.estevam@nxp.com>, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 15, 2018 at 3:16 PM, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
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
>
> Nicolin Chen (17):
>   ASoC: fsl_ssi: Redefine RX and TX macros
>   ASoC: fsl_ssi: Keep ssi->i2s_net updated
>   ASoC: fsl_ssi: Clean up set_dai_tdm_slot()
>   ASoC: fsl_ssi: Maintain a mask of active streams
>   ASoC: fsl_ssi: Rename fsl_ssi_disable_val macro
>   ASoC: fsl_ssi: Clear FIFO directly in fsl_ssi_config()
>   ASoC: fsl_ssi: Clean up helper functions of trigger()
>   ASoC: fsl_ssi: Add DAIFMT define for AC97
>   ASoC: fsl_ssi: Clean up fsl_ssi_setup_regvals()
>   ASoC: fsl_ssi: Set xFEN0 and xFEN1 together
>   ASoC: fsl_ssi: Use snd_soc_init_dma_data instead
>   ASoC: fsl_ssi: Move one-time configurations to probe()
>   ASoC: fsl_ssi: Setup AC97 in fsl_ssi_hw_init()
>   ASoC: fsl_ssi: Clean up _fsl_ssi_set_dai_fmt()
>   ASoC: fsl_ssi: Add bool synchronous to mark synchronous mode
>   ASoC: fsl_ssi: Move DT related code to a separate probe()
>   ASoC: fsl_ssi: Use ssi->streams instead of reading register
>
>  sound/soc/fsl/fsl_ssi.c | 741 +++++++++++++++++++++++++-----------------------
>  sound/soc/fsl/fsl_ssi.h |   3 -
>  2 files changed, 379 insertions(+), 365 deletions(-)
>
> --
> 2.7.4
>

Tested v4 with 8 channel TDM at 48kHz. No problems found.

Tested-by: Caleb Crome <caleb@crome.org>
