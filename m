From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [[PATCH] ALSA: In Freescale ESAI driver xDxDC bits
 in xCCR registers is 5 bits width not 4
Date: Thu, 18 Dec 2014 12:59:46 -0200
Message-ID: <CAOMZO5C_U61WsF22rA6CmkS4vfoerRkUoxpWxPZSbG7FFN6dog@mail.gmail.com>
References: <1418913081-14439-1-git-send-email-a_bouin@yahoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1418913081-14439-1-git-send-email-a_bouin@yahoo.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Aurelien BOUIN <a_bouin@yahoo.fr>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, patch@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Aurelien,

On Thu, Dec 18, 2014 at 12:31 PM, Aurelien BOUIN <a_bouin@yahoo.fr> wrote:
> Signed-off-by: Aurelien BOUIN <a_bouin@yahoo.fr>
>
> diff --git a/sound/soc/fsl/fsl_esai.h b/sound/soc/fsl/fsl_esai.h
> index 91a550f..5e793bb 100644
> --- a/sound/soc/fsl/fsl_esai.h
> +++ b/sound/soc/fsl/fsl_esai.h
> @@ -302,7 +302,7 @@
>  #define ESAI_xCCR_xFP_MASK     (((1 << ESAI_xCCR_xFP_WIDTH) - 1) << ESAI_xCCR_xFP_SHIFT)
>  #define ESAI_xCCR_xFP(v)       ((((v) - 1) << ESAI_xCCR_xFP_SHIFT) & ESAI_xCCR_xFP_MASK)
>  #define ESAI_xCCR_xDC_SHIFT     9
> -#define ESAI_xCCR_xDC_WIDTH    4
> +#define ESAI_xCCR_xDC_WIDTH    5

The content of the patch is correct, but you need to improve a few things:

- Subject should be something like: ASoC: fsl_esai: Fix
ESAI_xCCR_xDC_WIDTH definition.
In the two versions you sent you add an unneeded "["

- It is always good to add a commit log like:

"According to the mx6 reference manual the TDC and RDC field of
registers ESAI_TCCR and ESAI_RCCR have a width of 5 bits, not 4".

- You missed to Cc the esai driver maintainer Nicolin Chen.

After you fix address these comments you can send a v2 of this patch.
