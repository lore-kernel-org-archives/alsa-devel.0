From: Maxime Coquelin <maxime.coquelin@st.com>
Subject: Re: [STLinux Kernel] [PATCH v3 1/9] ASoC: sti: add
 binding for ASoC driver
Date: Mon, 22 Jun 2015 17:04:42 +0200
Message-ID: <5588240A.9090300@st.com>
References: <1434983473-25092-1-git-send-email-arnaud.pouliquen@st.com>
 <1434983473-25092-2-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id D1D1826513F
 for <alsa-devel@alsa-project.org>; Mon, 22 Jun 2015 17:04:46 +0200 (CEST)
In-Reply-To: <1434983473-25092-2-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>, alsa-devel@alsa-project.org
Cc: broonie@kernel.org, lgirdwood@gmail.com, kernel@stlinux.com
List-Id: alsa-devel@alsa-project.org

Hi Arnaud,

On 06/22/2015 04:31 PM, Arnaud Pouliquen wrote:
> Add ASoC driver bindings documentation.
> Describe the required properties for each of the hardware IPs drivers.
>
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> ---
>   .../devicetree/bindings/sound/st,sti-asoc-card.txt | 155 +++++++++++++++++++++
>   1 file changed, 155 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt
>
> diff --git a/Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt b/Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt
> new file mode 100644
> index 0000000..028fa1c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt
> @@ -0,0 +1,155 @@
> +STMicroelectronics sti ASoC cards
> +
> +The sti ASoC Sound Card can be used, for all sti SoCs using internal sti-sas
> +codec or external codecs.
> +
> +sti sound drivers allows to expose sti SoC audio interface through the
> +generic ASoC simple card. For details about sound card declaration please refer to
> +Documentation/devicetree/bindings/sound/simple-card.txt.
> +
> +1) sti-uniperiph-dai: audio dai device.
> +---------------------------------------
> +
> +Required properties:
> +  - compatible: "st,sti-uni-player" or "st,sti-uni-reader"
<snip>
> +
> +  - version: IP version integrated in SOC.
Souldn't this be managed with the compatible string?
> +
> +  - dai-name: DAI name that describes the IP.
Is it ST specifics? If so, I think it should be "st,dai-name".
> +
> +Required properties ("st,sti-uni-player" compatibility only):
> +  - clocks: CPU_DAI IP clock source, listed in the same order than the
> +	    CPU_DAI properties.
> +
> +  - uniperiph-id: internal SOC IP instance ID.
"st,uniperiph-id" ?
> +
> +  - IP mode: IP working mode depending on associated codec.
> +	"HDMI" connected to HDMI codec IP and IEC HDMI formats.
> +	"SPDIF"connected to SPDIF codec and support SPDIF formats.
> +	"PCM"  PCM standard mode for I2S or TDM bus.
Shouldn't you use an shared define instead of a string?

Regards,
Maxime
