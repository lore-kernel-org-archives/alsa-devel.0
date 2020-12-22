Return-Path: <SRS0=1LS8=F2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22924C433DB
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Dec 2020 07:01:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9F3F23127
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Dec 2020 07:01:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9F3F23127
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 407951754;
	Tue, 22 Dec 2020 08:00:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 407951754
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1608620476;
	bh=lYWlNG3hg5EQEMRIv3R8A9ky7wtOsmqZ+PHWm7X2Dq4=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Uak/YVBfgNUNag8YnTBXuLYf7fUlJ0+RZXnG9TRxaLuJeZE5fvTgA5TGYZe+FHOmb
	 4SvOYjx0ABLjUO4swFv7mkFFg0PBvuGF9VAQuYPW41VyRF2lqPXPylIUUH5KVi4jRs
	 ECbBUjEXgAmeqfIvm2wPEEhg0tgeUxehDNPM9UBQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CD6BAF8021D;
	Tue, 22 Dec 2020 08:00:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D9A42F80224; Tue, 22 Dec 2020 08:00:22 +0100 (CET)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4B318F80161
 for <alsa-devel@alsa-project.org>; Tue, 22 Dec 2020 08:00:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4B318F80161
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com
 header.b="pfp8CWZg"
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi
 [62.78.145.57])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 822B49E6;
 Tue, 22 Dec 2020 08:00:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1608620409;
 bh=lYWlNG3hg5EQEMRIv3R8A9ky7wtOsmqZ+PHWm7X2Dq4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pfp8CWZg+6dOyHxREN3KNVBN7r6rKmyStNsacuZHCJLAI5P7xcR9s5TrQHfwJ7CBL
 3KbXfs9uiI4JVcD/+sJSHpGbafw+Rc3KoOOs1B3LfpTRPxFUHIZdST11k86YeCG/MB
 2UqjimU33MsYT1PN2ZVsgIsOCsnGih/LXnPWBJt4=
Date: Tue, 22 Dec 2020 09:00:01 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: Drop redundant maxItems/items
Message-ID: <X+GZcXJoZ15vgxB2@pendragon.ideasonboard.com>
References: <20201222040645.1323611-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201222040645.1323611-1-robh@kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Jassi Brar <jaswinder.singh@linaro.org>, Vinod Koul <vkoul@kernel.org>,
 Mark Brown <broonie@kernel.org>, dmaengine@vger.kernel.org
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hi Rob,

Thank you for the patch.

On Mon, Dec 21, 2020 at 09:06:45PM -0700, Rob Herring wrote:
> 'maxItems' equal to the 'items' list length is redundant. 'maxItems' is
> preferred for a single entry while greater than 1 should have an 'items'
> list.
> 
> A meta-schema check for this is pending once these existing cases are
> fixed.
> 
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jassi Brar <jaswinder.singh@linaro.org>
> Cc: dri-devel@lists.freedesktop.org
> Cc: dmaengine@vger.kernel.org
> Cc: alsa-devel@alsa-project.org
> Cc: linux-usb@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  .../devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.yaml    | 1 -
>  Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml   | 1 -
>  Documentation/devicetree/bindings/mailbox/arm,mhu.yaml         | 1 -
>  .../devicetree/bindings/sound/nvidia,tegra30-hda.yaml          | 2 --
>  Documentation/devicetree/bindings/usb/renesas,usb-xhci.yaml    | 1 -
>  Documentation/devicetree/bindings/usb/renesas,usbhs.yaml       | 3 ---
>  6 files changed, 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.yaml b/Documentation/devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.yaml
> index 7b9d468c3e52..403d57977ee7 100644
> --- a/Documentation/devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.yaml
> +++ b/Documentation/devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.yaml
> @@ -98,7 +98,6 @@ properties:
>      maxItems: 1
>  
>    dmas:
> -    maxItems: 4
>      items:
>        - description: Video layer, plane 0 (RGB or luma)
>        - description: Video layer, plane 1 (U/V or U)
> diff --git a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml
> index b548e4723936..c07eb6f2fc8d 100644
> --- a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml
> +++ b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml
> @@ -73,7 +73,6 @@ properties:
>      maxItems: 1
>  
>    clock-names:
> -    maxItems: 1
>      items:
>        - const: fck
>  
> diff --git a/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml b/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml
> index d43791a2dde7..d07eb00b97c8 100644
> --- a/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml
> +++ b/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml
> @@ -61,7 +61,6 @@ properties:
>        - description: low-priority non-secure
>        - description: high-priority non-secure
>        - description: Secure
> -    maxItems: 3
>  
>    clocks:
>      maxItems: 1
> diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.yaml
> index e543a6123792..b55775e21de6 100644
> --- a/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.yaml
> +++ b/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.yaml
> @@ -44,7 +44,6 @@ properties:
>      maxItems: 3
>  
>    clock-names:
> -    maxItems: 3
>      items:
>        - const: hda
>        - const: hda2hdmi
> @@ -54,7 +53,6 @@ properties:
>      maxItems: 3
>  
>    reset-names:
> -    maxItems: 3
>      items:
>        - const: hda
>        - const: hda2hdmi
> diff --git a/Documentation/devicetree/bindings/usb/renesas,usb-xhci.yaml b/Documentation/devicetree/bindings/usb/renesas,usb-xhci.yaml
> index 0f078bd0a3e5..22603256ddf8 100644
> --- a/Documentation/devicetree/bindings/usb/renesas,usb-xhci.yaml
> +++ b/Documentation/devicetree/bindings/usb/renesas,usb-xhci.yaml
> @@ -51,7 +51,6 @@ properties:
>      maxItems: 1
>  
>    phy-names:
> -    maxItems: 1
>      items:
>        - const: usb
>  
> diff --git a/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml b/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml
> index 737c1f47b7de..54c361d4a7af 100644
> --- a/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml
> +++ b/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml
> @@ -74,11 +74,8 @@ properties:
>  
>    phys:
>      maxItems: 1
> -    items:
> -      - description: phandle + phy specifier pair.
>  
>    phy-names:
> -    maxItems: 1
>      items:
>        - const: usb
>  

-- 
Regards,

Laurent Pinchart
