Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D077FC433EF
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Apr 2022 21:34:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0FC27187B;
	Thu,  7 Apr 2022 23:33:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0FC27187B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1649367251;
	bh=8GlPAfGYieXFDHwj1kt1VOOH/7K8TRIq3Qg/GHUoxL8=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iMvAtR5zPwEsOt6GN/80P+rMoE40woLf00GdoGwffASZSuWRfWqvj6HcyZugB8/u4
	 kl+tYQTY7A996QLxw2pBwGi/P3QrbYYf+Li82DVtVbtSOHC/Yy1gpjj4FEsahvkakA
	 nWqJl9ISmTeZvtsLvMcyCvD7/Cj3ItE3hpTDxeWA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8412BF80141;
	Thu,  7 Apr 2022 23:33:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C44BEF8024C; Thu,  7 Apr 2022 23:33:18 +0200 (CEST)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7A89AF8012A
 for <alsa-devel@alsa-project.org>; Thu,  7 Apr 2022 23:33:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7A89AF8012A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.b="eXzCjkye"
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: nfraprado) with ESMTPSA id 1897E1F40E5E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1649367188;
 bh=8GlPAfGYieXFDHwj1kt1VOOH/7K8TRIq3Qg/GHUoxL8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eXzCjkyebsDGZC5jw5o2VqSrkIcfotEzXyaJCHcVoCGm6aDc0rqbcBeP4iC4zg1/m
 wbUx23L7T2YosToMSLzQgzClQ+mXQg+W+JLPDH7mPSMgN/P4qJCFIthSChXS4wnP4s
 D4+1x90dWcwtI6ORq3fxvMaM9IExI521e5gY4OKJg25pDlPVzS3kkM1J/9VC4bMaiP
 4LulHZB/vFJZgfD3l/Ec6wty6zzmWN+Tr5xPeiIBU2UeRM40DMdGtsZNnIGIczQofL
 IFI4+OKOhF6pRIn53GMM0Lulrx7nsQTJE5vTgdFizl9dubBZKWFPWqbqRN+qznSJA/
 dFD97YB0WAKHg==
Date: Thu, 7 Apr 2022 17:33:01 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Jiaxin Yu <jiaxin.yu@mediatek.com>
Subject: Re: [v9 3/4] ASoC: mediatek: mt8192: refactor for I2S8/I2S9 DAI
 links of headset
Message-ID: <20220407213301.wsm5qvtxgtkehj27@notapiano>
References: <20220406100514.11269-1-jiaxin.yu@mediatek.com>
 <20220406100514.11269-4-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220406100514.11269-4-jiaxin.yu@mediatek.com>
Cc: devicetree@vger.kernel.org, linmq006@gmail.com, alsa-devel@alsa-project.org,
 robh+dt@kernel.org, linux-kernel@vger.kernel.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com, tzungbi@google.com,
 broonie@kernel.org, linux-mediatek@lists.infradead.org, trevor.wu@mediatek.com,
 Tzung-Bi Shih <tzungbi@kernel.org>, matthias.bgg@gmail.com, aaronyu@google.com,
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

Hi Jiaxin,

On Wed, Apr 06, 2022 at 06:05:13PM +0800, Jiaxin Yu wrote:
> MT8192 platform use rt5682 codec, so through the snd_soc_of_get_dai_link_codecs()
> to complete the configuration of I2S8/I2S9 dai_link's codecs.

Likewise, suggestion for the commit message:

As part of the refactoring to allow the same machine driver to be used for the
rt1015(p) and rt5682(s) codecs on the MT8192 platform, parse the rt5682(s) codec
from the headset-codec property in the devicetree and wire it to the I2S8 and
I2S9 backends.

> 
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas
