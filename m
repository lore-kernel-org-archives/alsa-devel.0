Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC6ECC433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Mar 2022 04:00:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5352F166A;
	Mon, 21 Mar 2022 04:59:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5352F166A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1647835222;
	bh=Y4RPiSr+4ZFbLITcBxYisXPJwqdGgqpzoccbeNlhlz8=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ozGWGiYyuf5COe2PvW5IIJh+XrbxWuIQ8lzkdcfOwmWVViLFI/DXhaWryj9t016LB
	 GT+RH9XIq5q9Z4VfEdr6RSGZ68wx/jT/jf2DB97ubQDKe8mhYzMbaLeTB5fvHWdvpO
	 pH7GMWab64AXE1kyOX1F6iBmGgTWDSWepPQHAtfc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D9110F801D8;
	Mon, 21 Mar 2022 04:59:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 88AE6F80227; Mon, 21 Mar 2022 04:59:29 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5B113F80116
 for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2022 04:59:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5B113F80116
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="hbwrRg3d"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 9B40560B4D;
 Mon, 21 Mar 2022 03:59:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0256C340EE;
 Mon, 21 Mar 2022 03:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1647835162;
 bh=Y4RPiSr+4ZFbLITcBxYisXPJwqdGgqpzoccbeNlhlz8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hbwrRg3dYYgVo5Vm2TvAvXfrFT8frw0Wgc6mDOmq/9KM9ZfGyxLu1VI5czKGhU6JO
 2+Y2MGwgodRQ30iyM+I4c+s/g5MnUGA6MHN8PLuL6q3voUYcZ8o6UIkSglFBBn1Tnh
 faphTUcxF9tZ3m2pXj3IIFyt81s07xTtLwQgUGuMpaHDvdUmvvS8OmXes7vyaV/if6
 fK4noFy9Xqf7p/3jA5XXnP4c02IcfYODnzIHDP6V/G6qwxRKp1QUlFPrcby8NuTUXW
 Z5GTM+y05VGUrlxfNDooAnuf1v3Ui7TuoUszGLiIU298vFP69UBE/H5jSW+BoIbW1N
 6xM9z2M47Z8CQ==
Date: Mon, 21 Mar 2022 11:59:17 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Jiaxin Yu <jiaxin.yu@mediatek.com>
Subject: Re: [v5 2/4] ASoC: mediatek: mt8192: refactor for I2S3 DAI link of
 speaker
Message-ID: <Yjf4FXEirDkxPUd1@google.com>
References: <20220319114111.11496-1-jiaxin.yu@mediatek.com>
 <20220319114111.11496-3-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220319114111.11496-3-jiaxin.yu@mediatek.com>
Cc: devicetree@vger.kernel.org, linmq006@gmail.com, alsa-devel@alsa-project.org,
 robh+dt@kernel.org, linux-kernel@vger.kernel.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com, broonie@kernel.org,
 linux-mediatek@lists.infradead.org, trevor.wu@mediatek.com,
 matthias.bgg@gmail.com, aaronyu@google.com,
 linux-arm-kernel@lists.infradead.org, angelogioacchino.delregno@collabora.com
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

On Sat, Mar 19, 2022 at 07:41:09PM +0800, Jiaxin Yu wrote:
>  static int mt8192_mt6359_dev_probe(struct platform_device *pdev)
[...]
> +	hdmi_codec = of_parse_phandle(pdev->dev.of_node, "mediatek,hdmi-codec", 0);
> +	if (!hdmi_codec) {
>  		ret = -EINVAL;
> -		goto put_platform_node;
> +		dev_err_probe(&pdev->dev, ret, "Property 'hdmi-codec' missing or invalid\n");
> +		goto err_hdmi_codec;
>  	}
> -	card->dev = &pdev->dev;
>  
> -	hdmi_codec = of_parse_phandle(pdev->dev.of_node,
> -				      "mediatek,hdmi-codec", 0);
> +	speaker_codec = of_get_child_by_name(pdev->dev.of_node, "mediatek,speaker-codec");
> +	if (!speaker_codec) {
> +		ret = -EINVAL;
> +		dev_err_probe(&pdev->dev, ret, "Property 'speaker_codec' missing or invalid\n");
> +		goto err_speaker_codec;
> +	}

(to be neat) Does it have any reason to prevent from using of_parse_phandle()
but of_get_child_by_name()?
