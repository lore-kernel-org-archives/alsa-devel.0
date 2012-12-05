From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH] ASoC: lm49453: Fix analog and digital
 volume ranges
Date: Wed, 05 Dec 2012 11:29:02 -0800
Message-ID: <1354735742.7077.89.camel@vkoul-udesk3>
References: <1354704529-12912-1-git-send-email-MR.Swami.Reddy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id F19DC261620
 for <alsa-devel@alsa-project.org>; Wed,  5 Dec 2012 20:49:05 +0100 (CET)
In-Reply-To: <1354704529-12912-1-git-send-email-MR.Swami.Reddy@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: MR.Swami.Reddy@ti.com
Cc: vishwas.a.deshpande@ti.com, broonie@opensource.wolfsonmicro.com, lrg@ti.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2012-12-05 at 16:18 +0530, MR.Swami.Reddy@ti.com wrote:

>  /* TLV Declarations */
>  static const DECLARE_TLV_DB_SCALE(digital_tlv, -7650, 150, 1);
> -static const DECLARE_TLV_DB_SCALE(port_tlv, 0, 600, 0);
> +static const DECLARE_TLV_DB_SCALE(analog_tlv, 0, 200, 1);
The spec says your analog gain are 0 to 30dB in steps of 2dB, this
doesnt sound right to me.
> +static const DECLARE_TLV_DB_SCALE(port_tlv, -1800, 600, 0);
>  
>  static const struct snd_kcontrol_new lm49453_sidetone_mixer_controls[] = {
>  /* Sidetone supports mono only */
> @@ -516,9 +517,9 @@ SOC_DAPM_SINGLE_TLV("Sidetone DMIC2R Volume", LM49453_P0_STN_VOL_DMIC2R_REG,
>  static const struct snd_kcontrol_new lm49453_snd_controls[] = {
>  	/* mic1 and mic2 supports mono only */
>  	SOC_SINGLE_TLV("Mic1 Volume", LM49453_P0_ADC_LEVELL_REG, 0, 6,
> -			0, digital_tlv),
> +			0, analog_tlv),
now i see a  problem.
You have hidden the MIC gains and exposed only ADC gains. The name is
wrong causing the confusion. Please make this ADC gain and add new
control for MIC gain!
Your ADC gain is -76 to 18db, with 0.5dB steps, how does this reflect
that?

>  	SOC_SINGLE_TLV("Mic2 Volume", LM49453_P0_ADC_LEVELR_REG, 0, 6,
> -			0, digital_tlv),
> +			0, analog_tlv),
Ditto.....
>  
>  	SOC_DOUBLE_R_TLV("DMIC1 Volume", LM49453_P0_DMIC1_LEVELL_REG,
>  			  LM49453_P0_DMIC1_LEVELR_REG, 0, 6, 0, digital_tlv),
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel


-- 
~Vinod
