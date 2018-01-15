From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH v3 14/17] ASoC: fsl_ssi: Clean up
	_fsl_ssi_set_dai_fmt()
Date: Mon, 15 Jan 2018 22:16:28 +0100
Message-ID: <88551d87-1b76-9a30-6781-1d0b6479b317@maciej.szmigiero.name>
References: <1515990087-11598-1-git-send-email-nicoleotsuka@gmail.com>
 <1515990087-11598-15-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E9DC266BBC
 for <alsa-devel@alsa-project.org>; Mon, 15 Jan 2018 22:16:35 +0100 (CET)
In-Reply-To: <1515990087-11598-15-git-send-email-nicoleotsuka@gmail.com>
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
Cc: alsa-devel@alsa-project.org, kernel@pengutronix.de, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, caleb@crome.org, timur@tabi.org, arnaud.mouiche@invoxia.com, lukma@denx.de, fabio.estevam@nxp.com, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On 15.01.2018 05:21, Nicolin Chen wrote:
> The _fsl_ssi_set_dai_fmt() is a helper function being called from
> fsl_ssi_set_dai_fmt() as an ASoC operation and fsl_ssi_hw_init()
> mainly for AC97 format initialization.
> 
> This patch cleans the _fsl_ssi_set_dai_fmt() in following ways:
> * Removing *dev pointer in the parameters as it's included in the
>   *ssi pointer of struct fsl_ssi.
> * Using regmap_update_bits() instead of regmap_read() with masking
>   the value manually.
> * Removing TXBIT0 configurations since this bit is set to 1 as its
>   reset value and there is no use case so far to unset it. And it
>   is safe to remove since regmap_update_bits() won't touch it.

I didn't get any response to a comment I've written about the point
above during the previous patch iteration:> The old code set this bit in any mode other than AC'97 (where the
> hardware always treats this bit as set regardless of the actual value).
> I would play safe here and not rely on this bit being set by a SSI
> reset on all SSI models.

Maciej

> * Moving baudclk check to the switch-case routine to skip the I2S
>   master check. And moving SxCCR.DC settings after baudclk check.
> * Adding format settings for SND_SOC_DAIFMT_AC97 like others.
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> Tested-by: Caleb Crome <caleb@crome.org>
> ---
> Changelog
> v3
>  * Put CBM_CFS behind the baudclk check to keep the same program
>    flow as before
> 
>  sound/soc/fsl/fsl_ssi.c | 73 ++++++++++++++++++++++---------------------------
>  1 file changed, 33 insertions(+), 40 deletions(-)
> 
