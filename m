From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/9] ASoC: da7210: Add support for mute and
 zero cross controls
Date: Wed, 12 Oct 2011 15:56:32 +0100
Message-ID: <20111012145631.GQ3647@opensource.wolfsonmicro.com>
References: <1318431695.12107.411.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6A10A103971
	for <alsa-devel@alsa-project.org>;
	Wed, 12 Oct 2011 16:56:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1318431695.12107.411.camel@matrix>
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
Cc: linux-kernel <linux-kernel@vger.kernel.org>, alsa-devel <alsa-devel@alsa-project.org>, lrg@ti.com, kuninori.morimoto.gx@renesas.com, David Dajun Chen <david.chen@diasemi.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 12, 2011 at 08:31:35PM +0530, Ashish Chavan wrote:

> +	/* Mute controls */
> +	SOC_SINGLE("Mic Left Mute Switch", DA7210_MIC_L, 3, 1, 0),
> +	SOC_SINGLE("Mic Right Mute Switch", DA7210_MIC_R, 3, 1, 0),

Should be a double control.

> +	SOC_SINGLE("DAC Soft Mute Rate", DA7210_SOFTMUTE, 0, 0X7, 0),

0x7.
