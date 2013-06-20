From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: SPEAr: Add device tree support +
 SPEAr machine driver
Date: Thu, 20 Jun 2013 14:12:42 +0200
Message-ID: <51C2F1BA.40903@metafoo.de>
References: <1371728152-14641-1-git-send-email-rajeev-dlh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-035.synserver.de (smtp-out-035.synserver.de
 [212.40.185.35])
 by alsa0.perex.cz (Postfix) with ESMTP id 59456265299
 for <alsa-devel@alsa-project.org>; Thu, 20 Jun 2013 14:12:26 +0200 (CEST)
In-Reply-To: <1371728152-14641-1-git-send-email-rajeev-dlh.kumar@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 06/20/2013 01:35 PM, Rajeev Kumar wrote:
> The patch adds device tree support + SPEAr machine driver
> 
> Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
> ---
>  .../devicetree/bindings/sound/spear-evb.txt        |   20 +++
>  sound/soc/spear/spear_evb.c                        |  135 ++++++++++++++++++++
>  2 files changed, 155 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/spear-evb.txt
>  create mode 100644 sound/soc/spear/spear_evb.c
> 
> diff --git a/Documentation/devicetree/bindings/sound/spear-evb.txt b/Documentation/devicetree/bindings/sound/spear-evb.txt
> new file mode 100644
> index 0000000..cb011b4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/spear-evb.txt
> @@ -0,0 +1,20 @@
> +* SPEAr audio sta529 codec
> +
> +Required properties:
> +- compatible: "spear,spear-evb"
> +- audio-controllers: The phandle list of synopsys audio i2s controller
> +- audio-codec: The phandle of the sta529 audio codec
> +- codec_dai_name: DAI name for codec.
> +- stream_name: stream name.
> +
> +Example:
> +
> +sound {
> +        compatible = "spear,spear-evb";
> +        audio-controllers = <&i2s0 &i2s1>;
> +        audio-codecs = <&sta529 &sta529>;
> +        codec_dai_name = "sta529-audio", "sta529-audio";
> +        stream_name = "i2s-play", "i2s-cap";
> +        dai_name = "i2s0-pcm", "i2s1-pcm";
> +};

Kuninori Morimoto was working on generic bindings for the simple-audio
driver a while back. I'm not quite sure what the current status is on this,
but I think it is a better idea to use what he was working on instead of
adding just another set of incompatible platform specific bindings.

See
http://mailman.alsa-project.org/pipermail/alsa-devel/2013-February/059791.html

- Lars
