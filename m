From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: add documents for mt6351
Date: Tue, 1 May 2018 09:42:36 -0500
Message-ID: <20180501144236.GA26497@rob-hp-laptop>
References: <20180426030732.5887-1-kaichieh.chuang@mediatek.com>
 <20180426030732.5887-2-kaichieh.chuang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f67.google.com (mail-oi0-f67.google.com
 [209.85.218.67])
 by alsa0.perex.cz (Postfix) with ESMTP id E7305266EBC
 for <alsa-devel@alsa-project.org>; Tue,  1 May 2018 16:42:38 +0200 (CEST)
Received: by mail-oi0-f67.google.com with SMTP id p62-v6so10219930oie.10
 for <alsa-devel@alsa-project.org>; Tue, 01 May 2018 07:42:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20180426030732.5887-2-kaichieh.chuang@mediatek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, ryder.lee@mediatek.com, wsd_upstream@mediatek.com, chipeng.chang@mediatek.com, garlic.tseng@mediatek.com, broonie@kernel.org, linux-mediatek@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 26, 2018 at 11:07:31AM +0800, KaiChieh Chuang wrote:
> Signed-off-by: KaiChieh Chuang <kaichieh.chuang@mediatek.com>

Needs a commit msg and 'binding' would be more informative than 
'documents' in the subject.

> ---
>  Documentation/devicetree/bindings/sound/mt6351.txt | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/mt6351.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/mt6351.txt b/Documentation/devicetree/bindings/sound/mt6351.txt
> new file mode 100644
> index 000000000000..7fb2cb99245e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/mt6351.txt
> @@ -0,0 +1,16 @@
> +Mediatek MT6351 Audio Codec
> +
> +The communication between MT6351 and SoC is through Mediatek PMIC wrapper.
> +For more detail, please visit Mediatek PMIC wrapper documentation.

Add the path to the doc file.

What's a wrapper? Is this a block within the PMIC or ?

> +
> +Must be a child node of PMIC wrapper.
> +
> +Required properties:
> +
> +- compatible : "mediatek,mt6351-sound".
> +
> +Example:
> +
> +mt6351_snd {
> +	compatible = "mediatek,mt6351-sound";
> +};
> -- 
> 2.12.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
