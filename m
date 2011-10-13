From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 2/9] ASoC: da7210: Add support for line
 input and mic
Date: Thu, 13 Oct 2011 17:19:59 +0100
Message-ID: <20111013161959.GI5193@opensource.wolfsonmicro.com>
References: <1318514644.12107.472.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8044A10382A
	for <alsa-devel@alsa-project.org>;
	Thu, 13 Oct 2011 18:20:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1318514644.12107.472.camel@matrix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ashish Chavan <ashish.chavan@kpitcummins.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, alsa-devel <alsa-devel@alsa-project.org>, lrg <lrg@ti.com>, "kuninori.morimoto.gx" <kuninori.morimoto.gx@renesas.com>, David Dajun Chen <david.chen@diasemi.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 13, 2011 at 07:34:04PM +0530, Ashish Chavan wrote:
>  	} else {
> -		/* Volume 7 */
> -		snd_soc_update_bits(codec, DA7210_MIC_L, 0x7, 0x7);
> -		snd_soc_update_bits(codec, DA7210_MIC_R, 0x7, 0x7);
> -
> -		/* Enable Mic */
> -		snd_soc_update_bits(codec, DA7210_INMIX_L, 0x1F, 0x1);
> -		snd_soc_update_bits(codec, DA7210_INMIX_R, 0x1F, 0x1);
> +		/* Enable Mic,AUX1 and AUX2 */
> +		snd_soc_update_bits(codec, DA7210_INMIX_L, 0x1F, 0xD);
> +		snd_soc_update_bits(codec, DA7210_INMIX_R, 0x1F, 0xD);

So, I did mention that the DAPM patch should come first when I reviewed
your previous series...
