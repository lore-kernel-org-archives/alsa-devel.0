From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH] ASoC: tda998x: add a codec to the HDMI transmitter
Date: Wed, 2 Jul 2014 18:56:28 +0200
Message-ID: <20140702165628.GO20799@lunn.ch>
References: <20140702183841.7c964832@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140702183841.7c964832@armhf>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: Mark Brown <broonie@kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>, Dave Airlie <airlied@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 02, 2014 at 06:38:41PM +0200, Jean-Francois Moine wrote:
> This patch adds a CODEC function to the NXP TDA998x HDMI transmitter.
> 
> The CODEC handles both I2S and S/PDIF inputs and does dynamic input
> switch in the TDA998x I2C driver on start/stop audio streaming.

Hi Jean-Francois

How well will this work with Russell concept of a front end and two
backends? Can you uses your CODEC twice, once with the I2S backend and
a second time with the S/PDIF backend?

	Andrew
