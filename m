From: Andrew Jackson <Andrew.Jackson@arm.com>
Subject: Re: [PATCH v3] ASoC: tda998x: add a codec to the HDMI
	transmitter
Date: Wed, 23 Jul 2014 11:22:06 +0100
Message-ID: <53CF8CCE.3030205@arm.com>
References: <20140708114057.5ef3cfd0@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com
 [217.140.96.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 8EFD4265607
 for <alsa-devel@alsa-project.org>; Wed, 23 Jul 2014 12:22:09 +0200 (CEST)
In-Reply-To: <20140708114057.5ef3cfd0@armhf>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Francois Moine <moinejf@free.fr>, Mark Brown <broonie@kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On 07/08/14 10:40, Jean-Francois Moine wrote:
> This patch adds a CODEC function to the NXP TDA998x HDMI transmitter.
> 
> The CODEC handles both I2S and S/PDIF input and does dynamic input
> switch in the TDA998x I2C driver on start/stop audio streaming.
> 
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> ---

Shouldn't the patch also capture the current audio rate in tda998x_codec.c:tda_hw_params?  Otherwise, when tda998x_drv.c:tda998x_audio_start invokes tda998x_drv.c:tda998x_configure_audio, the value of 'N' will be calculated incorrectly.

So something similar to:

diff --git a/drivers/gpu/drm/i2c/tda998x_codec.c b/drivers/gpu/drm/i2c/tda998x_codec.c
index e7f223d..b6c4fb3 100755
--- a/drivers/gpu/drm/i2c/tda998x_codec.c
+++ b/drivers/gpu/drm/i2c/tda998x_codec.c
@@ -111,6 +111,7 @@ static int tda_hw_params(struct snd_pcm_substream *substream,
 		tda998x_audio_start(priv, 0);
 		return 0;
 	}
+	priv->params.audio_sample_rate = params_rate(params);
 	priv->params.audio_format = dai->id;
 	priv->audio_sample_format = params_format(params);
 	params.audio_cfg =


   Andrew
