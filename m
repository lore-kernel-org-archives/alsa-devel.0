From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 08/11] ASoC: Add bindings for DMIC codec
	driver
Date: Fri, 24 Mar 2017 09:46:03 -0500
Message-ID: <20170324144603.zos7n4oqelaag433@rob-hp-laptop>
References: <1489759704-30217-1-git-send-email-arnaud.pouliquen@st.com>
 <1489759704-30217-9-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f68.google.com (mail-oi0-f68.google.com
 [209.85.218.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 7DA322669DD
 for <alsa-devel@alsa-project.org>; Fri, 24 Mar 2017 15:46:05 +0100 (CET)
Received: by mail-oi0-f68.google.com with SMTP id f193so390587oib.0
 for <alsa-devel@alsa-project.org>; Fri, 24 Mar 2017 07:46:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1489759704-30217-9-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, olivier moysan <olivier.moysan@st.com>, kernel@stlinux.com, Liam Girdwood <lgirdwood@gmail.com>, linux-iio@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>, Jonathan Cameron <jic23@kernel.org>, Alexandre Torgue <alexandre.torgue@st.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 17, 2017 at 03:08:21PM +0100, Arnaud Pouliquen wrote:
> This patch adds documentation of device tree bindings for audio DMIC codec.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> ---
>  Documentation/devicetree/bindings/sound/dmic.txt | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/dmic.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/dmic.txt b/Documentation/devicetree/bindings/sound/dmic.txt
> new file mode 100644
> index 0000000..eb2a9d4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/dmic.txt
> @@ -0,0 +1,11 @@
> +Device-Tree bindings for dmic codec

Please define what is and isn't a DMIC here. What's the interface?

> +
> +Required properties:
> +	- compatible: should be "dmic-codec".

DMICs don't have part numbers?

> +
> +Example node:
> +
> +	dmic_audio: dmic_audio@0 {

Don't use '_' and there's no reg property, so there should be no unit 
address.

> +		compatible = "dmic-codec";
> +		status = "okay";

Don't show status in examples.

> +	};
> -- 
> 1.9.1
> 
