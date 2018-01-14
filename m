From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH v2 04/16] ASoC: fsl_ssi: Rename
	fsl_ssi_disable_val macro
Date: Sun, 14 Jan 2018 23:34:37 +0100
Message-ID: <6dd7d3e8-4673-c56d-c0ce-80df1f537f9b@maciej.szmigiero.name>
References: <1515652995-15996-1-git-send-email-nicoleotsuka@gmail.com>
 <1515652995-15996-5-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
 by alsa0.perex.cz (Postfix) with ESMTP id 07744266CFE
 for <alsa-devel@alsa-project.org>; Sun, 14 Jan 2018 23:34:43 +0100 (CET)
In-Reply-To: <1515652995-15996-5-git-send-email-nicoleotsuka@gmail.com>
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

On 11.01.2018 07:43, Nicolin Chen wrote:
> The define of fsl_ssi_disable_val is not so clear as it mixes two
> steps of calculations together. And those parameter names are also
> a bit long to read.
> 
> Since it just tries to exclude the shared bits from the regvals of
> current stream while the opposite stream is active, it's better to
> use something like ssi_excl_shared_bits.
> 
> This patch also bisects fsl_ssi_disable_val into two macros of two
> corresponding steps and then shortens its parameter names. It also
> updates callers in the fsl_ssi_config() accordingly.
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> Tested-by: Caleb Crome <caleb@crome.org>
> ---
>  sound/soc/fsl/fsl_ssi.c | 54 ++++++++++++++++++++-----------------------------
>  1 file changed, 22 insertions(+), 32 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> index aa14a5d..f026386 100644
> --- a/sound/soc/fsl/fsl_ssi.c
> +++ b/sound/soc/fsl/fsl_ssi.c
> @@ -445,16 +445,10 @@ static void fsl_ssi_config(struct fsl_ssi *ssi, bool enable,
>  	bool dir = (&ssi->regvals[TX] == vals) ? TX : RX;
>  	struct regmap *regs = ssi->regs;
>  	struct fsl_ssi_regvals *avals;
> -	int nr_active_streams;
> -	int keep_active;
> -
> -	nr_active_streams = !!(ssi->streams & BIT(TX)) +
> -			    !!(ssi->streams & BIT(RX));
> +	bool aactive;
>  
> -	if (nr_active_streams - 1 > 0)
> -		keep_active = 1;
> -	else
> -		keep_active = 0;
> +	/* Check if the opposite stream is active */
> +	aactive = ssi->streams & BIT(!dir);
				     ^
Here an implicit assumption that either RX == 0, TX == 1 or
RX == 1, TX == 0 still remains.

Maciej
