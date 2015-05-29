From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 2/2] ASoC: rt5645: add device tree
	support
Date: Fri, 29 May 2015 18:31:55 +0200
Message-ID: <5568947B.3040309@metafoo.de>
References: <1432894607-28489-1-git-send-email-bardliao@realtek.com>
 <1432894607-28489-2-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-030.synserver.de (smtp-out-030.synserver.de
 [212.40.185.30])
 by alsa0.perex.cz (Postfix) with ESMTP id 22C2126691F
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2015 18:31:57 +0200 (CEST)
In-Reply-To: <1432894607-28489-2-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>, broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, zhengxing@rock-chips.com, yang.a.fang@intel.com, koro.chen@mediatek.com, john.lin@realtek.com, Leilk.Liu@mediatek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

On 05/29/2015 12:16 PM, Bard Liao wrote:
[...]
> +
> +Example:
> +
> +codec: rt5650@1a {
> +	compatible = "realtek,rt5650";
> +	reg = <0x1a>;
> +	rt5645-gpios = <&gpio 19 0>;

The gpio is missing from the property documentation.

> +	interrupt-parent = <&gpio>;
> +	interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
> +	realtek,dmic-en = "true";
> +	realtek,en-jd-func = "true";
> +	realtek,jd-mode = <3>;
> +};
