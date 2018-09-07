From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: cs4265: Add a MIC pre. switch
Date: Fri, 7 Sep 2018 09:26:26 +0100
Message-ID: <20180907082626.GF1653@imbe.wolfsonmicro.main>
References: <20180907032729.26532-1-flatmax@flatmax.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 061CC2676D6
 for <alsa-devel@alsa-project.org>; Fri,  7 Sep 2018 10:26:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20180907032729.26532-1-flatmax@flatmax.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matt Flax <flatmax@flatmax.org>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, brian.austin@cirrus.com, paul.handrigan@cirrus.com
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 07, 2018 at 01:27:29PM +1000, Matt Flax wrote:
> This patch adds a MIC preamp enable switch as a SOC_SINGLE.
> 
> Signed-off-by: Matt Flax <flatmax@flatmax.org>
> ---
>  sound/soc/codecs/cs4265.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/codecs/cs4265.c b/sound/soc/codecs/cs4265.c
> index d9eebf6a..03476f93 100644
> --- a/sound/soc/codecs/cs4265.c
> +++ b/sound/soc/codecs/cs4265.c
> @@ -161,6 +161,7 @@ static const struct snd_kcontrol_new cs4265_snd_controls[] = {
>  	SOC_SINGLE("MMTLR Data Switch", CS4265_SPDIF_CTL2, 0, 1, 0),
>  	SOC_ENUM("Mono Channel Select", spdif_mono_select_enum),
>  	SND_SOC_BYTES("C Data Buffer", CS4265_C_DATA_BUFF, 24),
> +	SOC_SINGLE("MIC Preamp", CS4265_PWRCTL, 3, 1, 1),
>  };

Is this the correct way to control this bit? There is already
a SND_SOC_DAPM_PGA widget called "Pre-amp MIC" that controls
the bit, it looks like this widget is not connected to the
rest of the DAPM graph. Should we just be hooking that widget
up instead?  The datasheet isn't abundantly clear but it looks
like the bit needs to be set whenever the mic is in use:

"The microphone preamplifier block will enter a low-power state
whenever this bit is set."

Which would really make DAPM a better fit, unless there are valid
use-cases for using the mic with the preamp powered down?

Thanks,
Charles
