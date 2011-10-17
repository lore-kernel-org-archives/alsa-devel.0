From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v4 3/7] ASoC: da7210: Add support for mute
 and zero cross controls
Date: Mon, 17 Oct 2011 22:42:43 +0100
Message-ID: <20111017214242.GD5200@opensource.wolfsonmicro.com>
References: <1318670595.613.42.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BA98A103879
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Oct 2011 23:42:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1318670595.613.42.camel@matrix>
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

On Sat, Oct 15, 2011 at 02:53:15PM +0530, Ashish Chavan wrote:

> +	SOC_SINGLE("ADC Left Capture Switch", DA7210_ADC, 2, 1, 0),
> +	SOC_SINGLE("ADC Right Capture Switch", DA7210_ADC, 6, 1, 0),

I'd really expect this to be a single stereo control.
