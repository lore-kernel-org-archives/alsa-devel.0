From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 2/2] ASoC: Add bindings for PCM1789
Date: Sun, 18 Mar 2018 07:52:31 -0500
Message-ID: <20180318031809.doznckhzraitowcz@rob-hp-laptop>
References: <20180315161825.5524-1-mylene.josserand@bootlin.com>
 <20180315161825.5524-3-mylene.josserand@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180315161825.5524-3-mylene.josserand@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@bootlin.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, mark.rutland@arm.com, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alexandre.belloni@bootlin.com, thomas.petazzoni@bootlin.com, michael@amarulasolutions.com
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 15, 2018 at 05:18:25PM +0100, Mylène Josserand wrote:
> Add a device-tree binding for Texas Instrument's PCM1789 codec.
> For the moment, only I2C bus is supported but SPI could be added
> in future.
> 
> Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
> ---
>  .../devicetree/bindings/sound/pcm1789.txt          | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/pcm1789.txt

Reviewed-by: Rob Herring <robh@kernel.org>
