Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BED2BC433F5
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Mar 2022 16:12:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 73EC717E5;
	Thu, 24 Mar 2022 17:11:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 73EC717E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1648138357;
	bh=326GQpe6Pue2Q7/zbKDs+rrjArsHHkgS+jpDRGw9S48=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S8GVsOnoafY0lkSSbEJdqF9D0SHzuVC5s1Ld/szgxIAKFqskxrx+sF4T/oT5EwcF0
	 zOc37z/p/6OLh2WbD3R+18jVck/Ek0WzkoPAI8kfgv2DQP5Dt7Vj0d85B1mvvBqmBb
	 I2Dkf05as3Z53RARdh7ZBdjvDMYYsOrnJauaPsAE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 03728F80224;
	Thu, 24 Mar 2022 17:11:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4C723F800AA; Thu, 24 Mar 2022 17:11:44 +0100 (CET)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 00ABFF800AA
 for <alsa-devel@alsa-project.org>; Thu, 24 Mar 2022 17:11:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 00ABFF800AA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.b="lb96OBHH"
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: kholk11) with ESMTPSA id D00651F45890
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1648138297;
 bh=326GQpe6Pue2Q7/zbKDs+rrjArsHHkgS+jpDRGw9S48=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=lb96OBHHXuEZ2m2LlS0Xe5dnXMhqIrEt2g29/hMrrNVrjy4bYGfpukL51o3kSnelb
 ekjjR6a7w6e5HWn1N+EQq9teLNxhViG5o1IjRLB5956SAWA754snvzls6ImNZd6G0n
 m9ePqveP4Io14TttTGuUhOdcfO2cZqme+pZKj+tXI+3XD9J/U34SfZrW2ZuOYBdWfh
 Q+h26phTI+sLUGNMsIHQHb+5lPuZTMd/6xTxnhdByEoeyZ7kMIBrhFhee5dFW4uGZF
 BrAf2nsnyeA7kgW87stdvRXK7LUmK71fyNP03mCmLqibp2ioVTluDl0ktb2kltW+Rf
 DvOWCzMcu5N+A==
Message-ID: <c026dd04-3cc1-4408-e6e4-8ab8a8dbcb70@collabora.com>
Date: Thu, 24 Mar 2022 17:11:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v4 4/6] ASoC: mediatek: mt8195: rename card controls
Content-Language: en-US
To: Trevor Wu <trevor.wu@mediatek.com>, broonie@kernel.org, tiwai@suse.com,
 robh+dt@kernel.org, matthias.bgg@gmail.com
References: <20220324053851.27350-1-trevor.wu@mediatek.com>
 <20220324053851.27350-5-trevor.wu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220324053851.27350-5-trevor.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, tzungbi@google.com, miles.chen@mediatek.com,
 linux-mediatek@lists.infradead.org, yc.hung@mediatek.com, aaronyu@google.com,
 linux-arm-kernel@lists.infradead.org
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

Il 24/03/22 06:38, Trevor Wu ha scritto:
> In order to be able to reuse the same configurations in user space,
> rename the controls to generic names.
> 
> "Headphone Jack" -> "Headphone"
> "Speakers" -> "Ext Spk"
> "Left Speaker" -> "Left Spk"
> "Right Speaker" -> "Right SPk"
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
> Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

