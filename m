From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v2] ASoC: fsl_ssi: Fix channel swap on
	playback start
Date: Mon, 3 Apr 2017 15:36:15 -0700
Message-ID: <20170403223614.GC21156@Asurada-Nvidia>
References: <1491058131-31366-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f65.google.com (mail-pg0-f65.google.com [74.125.83.65])
 by alsa0.perex.cz (Postfix) with ESMTP id A5587266972
 for <alsa-devel@alsa-project.org>; Tue,  4 Apr 2017 00:36:11 +0200 (CEST)
Received: by mail-pg0-f65.google.com with SMTP id 81so32711504pgh.3
 for <alsa-devel@alsa-project.org>; Mon, 03 Apr 2017 15:36:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1491058131-31366-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: alsa-devel@alsa-project.org, arnaud.mouiche@invoxia.com, timur@tabi.org, caleb@crome.org, broonie@kernel.org, max.krummenacher@toradex.com, Fabio Estevam <fabio.estevam@nxp.com>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

Hi Fabio,

On Sat, Apr 01, 2017 at 11:48:51AM -0300, Fabio Estevam wrote:

> ENGcm06222: SSI:Transmission does not take place in bit length early
> frame sync configuration
[...]
> @@ -575,7 +575,9 @@ static void fsl_ssi_config(struct fsl_ssi_private *ssi_private, bool enable,
>  					"Timeout waiting TX FIFO filling\n");
>  			}
>  		}
> -		regmap_update_bits(regs, CCSR_SSI_SCR, vals->scr, vals->scr);
> +		regmap_update_bits(regs, CCSR_SSI_SCR,
> +			CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_TE | CCSR_SSI_SCR_RE,
> +			CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_TE | CCSR_SSI_SCR_RE);

My extra concern for this change is that ENGcm06222 suggests to
set TE and SSIEN together. However, we are still not setting the
SSIEN and TE together -- SSIEN is set already before this line
in the "ssi_private->use_dma && (vals->scr & CCSR_SSI_SCR_TE)".

On the other hand, ENGcm06222 doesn't mention anything related
to the RE bit. Although ENGcm06474 suggests to set TE and RE
together, yet it's for another bug (when TE is set after RE, the
TX channels might be swapped.)

Then, the test case: aplay swap_test.wav& sleep 1; killall aplay

It doesn't involve RE at all. So I don't get why setting RE and
TE together after setting SSIEN (three bits are not set together
here.) could solve the channel swapping problem for a test case
which has never involved RE at all. Am I missing something?
