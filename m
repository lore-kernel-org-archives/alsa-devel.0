From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH v2 2/3] ASoC: spdif_transmitter: Add DT support.
Date: Fri, 26 Apr 2013 21:24:26 +0200
Message-ID: <517AD46A.2020402@gmail.com>
References: <1366895594-19596-1-git-send-email-marek.belisko@streamunlimited.com> <1366895594-19596-3-git-send-email-marek.belisko@streamunlimited.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1366895594-19596-3-git-send-email-marek.belisko@streamunlimited.com>
Sender: linux-doc-owner@vger.kernel.org
To: Marek Belisko <marek.belisko@gmail.com>
Cc: grant.likely@secretlab.ca, rob.herring@calxeda.com, rob@landley.net, alsa-devel@alsa-project.org, Michal Bachraty <michal.bachraty@streamunlimited.com>, linux-doc@vger.kernel.org, tiwai@suse.de, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, broonie@kernel.org, Marek Belisko <marek.belisko@streamunlimited.com>, perex@perex.cz
List-Id: alsa-devel@alsa-project.org

On 04/25/2013 03:13 PM, Marek Belisko wrote:
> Add devicetree support for this dummy audio soc driver.
>
> Signed-off-by: Michal Bachraty<michal.bachraty@streamunlimited.com>
> Signed-off-by: Marek Belisko<marek.belisko@streamunlimited.com>
> ---
>   .../bindings/sound/spdif-transmitter.txt           |   10 ++++++++++
>   sound/soc/codecs/spdif_transmitter.c               |   10 ++++++++++
>   2 files changed, 20 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/sound/spdif-transmitter.txt
>
> diff --git a/Documentation/devicetree/bindings/sound/spdif-transmitter.txt b/Documentation/devicetree/bindings/sound/spdif-transmitter.txt
> new file mode 100644
> index 0000000..55a8584
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/spdif-transmitter.txt
> @@ -0,0 +1,10 @@
> +Device-Tree bindings for dummy spdif transmitter
> +
> +Required properties:
> +	- compatible: should be "linux,spdif-dit".

Marek,

I remember Daniel commenting on the name already, but
what about "spdif-transmitter" and "spdif-receiver" respectively?
That is very generic and should allow to remove "linux," prefix.
And there is a lot of drivers using more informative compatible
strings compared to the driver name.

Sebastian
