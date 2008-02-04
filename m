From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH][sound/soc/fsl/mpc8610_hpcd.c] duplicate
	strcasecmp test for "rj-master" in mpc8610_hpcd_probe()
Date: Mon, 4 Feb 2008 23:11:14 +0000
Message-ID: <20080204231114.GA7842@sirena.org.uk>
References: <47A77EB2.6070703@tiscali.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id A10FB2433D
	for <alsa-devel@alsa-project.org>; Tue,  5 Feb 2008 00:11:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <47A77EB2.6070703@tiscali.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Roel Kluin <12o3l@tiscali.nl>, Timur Tabi <timur@freescale.com>
Cc: liam.girdwood@wolfsonmicro.com, alsa-devel@alsa-project.org, lkml <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 04, 2008 at 10:08:02PM +0100, Roel Kluin wrote:
> In linus' git tree I found this problem. Is it also in the alsa tree?
> please confirm it's the right fix. The patch was not yet tested.

Timur, this looks like a good catch?

> --
> duplicate test for "rj-master"
> 
> Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
> ---
> diff --git a/sound/soc/fsl/mpc8610_hpcd.c b/sound/soc/fsl/mpc8610_hpcd.c
> index f26c4b2..a00aac7 100644
> --- a/sound/soc/fsl/mpc8610_hpcd.c
> +++ b/sound/soc/fsl/mpc8610_hpcd.c
> @@ -314,9 +314,9 @@ static int mpc8610_hpcd_probe(struct of_device *ofdev,
>  	} else if (strcasecmp(sprop, "lj-master") == 0) {
>  		machine_data->dai_format = SND_SOC_DAIFMT_LEFT_J;
>  		machine_data->codec_clk_direction = SND_SOC_CLOCK_IN;
>  		machine_data->cpu_clk_direction = SND_SOC_CLOCK_OUT;
> -	} else if (strcasecmp(sprop, "rj-master") == 0) {
> +	} else if (strcasecmp(sprop, "rj-slave") == 0) {
>  		machine_data->dai_format = SND_SOC_DAIFMT_RIGHT_J;
>  		machine_data->codec_clk_direction = SND_SOC_CLOCK_OUT;
>  		machine_data->cpu_clk_direction = SND_SOC_CLOCK_IN;
>  	} else if (strcasecmp(sprop, "rj-master") == 0) {
