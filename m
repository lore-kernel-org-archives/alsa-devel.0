From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: tlv320aic3x: no mono controls
	3007 model
Date: Tue, 19 Jul 2011 15:59:18 +0100
Message-ID: <20110719145918.GC9652@opensource.wolfsonmicro.com>
References: <20110715154626.GG11154@opensource.wolfsonmicro.com>
	<1310987609-23408-1-git-send-email-j.weitzel@phytec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 65A1E2453F
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Jul 2011 16:59:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1310987609-23408-1-git-send-email-j.weitzel@phytec.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jan Weitzel <j.weitzel@phytec.de>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 18, 2011 at 01:13:29PM +0200, Jan Weitzel wrote:
> if codec driver is used for AIC3X_MODEL_3007 the mono iout controls overwrite
> registers for class-d amplifier.
> classd amplifier controls are only used for AIC3X_MODEL_3007.
> 
> Removing all mono snd_kcontrol_new, snd_soc_dapm_widget, snd_soc_dapm_route
> and aic3x_init stuff from common code and call only for not AIC3X_MODEL_3007
> codecs.
> 
> Testet only with AIC3X_MODEL_3007
> 
> Signed-off-by: Jan Weitzel <j.weitzel@phytec.de>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
