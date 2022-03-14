Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E4BC433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Mar 2022 10:27:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 917A31893;
	Mon, 14 Mar 2022 11:26:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 917A31893
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1647253629;
	bh=yIg0sOPQ7n3pZ3uL8omVK+Yinivb2f5C8PjuJhAz0ag=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OGfYoc5vdxkHHk4FQRaAYExwoqTGGh3GvrY+ZlKGWe7f9udkA8E51cBrJtRix7Wl+
	 8D4rhwC5Jdd9rdXkFcfF9XEgIjcwNO2XPXKEdb+K0hTLHVKIxn59XNV/qMLfk1GM0S
	 F+9NE948lrREKrKfd3ZmOWONo1UbecIWHPN9asZU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 85232F80510;
	Mon, 14 Mar 2022 11:25:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0D562F80224; Mon, 14 Mar 2022 11:25:28 +0100 (CET)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0F8A2F8011C
 for <alsa-devel@alsa-project.org>; Mon, 14 Mar 2022 11:25:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0F8A2F8011C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.b="VVz+omXp"
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: kholk11) with ESMTPSA id CFA991F43502
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1647253520;
 bh=yIg0sOPQ7n3pZ3uL8omVK+Yinivb2f5C8PjuJhAz0ag=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=VVz+omXpnFBWYJtO9Kbp8aAHf1WMdAbBbYkF+/cZGalGFONJI07ZqnaFuEXHVx2L4
 k+SDs+MR6jppolMcSbNdzPzNzpVswWVBWJQZbEBjNNLsUW1Z9WD9GDK5QberBMu/y0
 +nEZF0PvEhfemowgypatod4dDtPX7YCEwjvikdWWQLnsWSUGgC78zFhgEhzggGv9bP
 sEHD2RCzY/p+ONffLaUusXH0uYc/4XaPiahdgnH6hQ7xLQy7eJ+VfC+iE7FKHF2UHS
 Tj2vkiYym73NU/+dSoA5XaFPJAJKVitmd3O3TRNmSAWjoiNb1idzv+FWI4WvK/NzK5
 zsapokAOiiIKA==
Message-ID: <eecc3d4c-c259-878c-bc0c-145ef8ab48df@collabora.com>
Date: Mon, 14 Mar 2022 11:25:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [v3 06/19] ASoC: mediatek: mt8186: support hw gain in platform
 driver
Content-Language: en-US
To: Jiaxin Yu <jiaxin.yu@mediatek.com>, broonie@kernel.org, robh+dt@kernel.org
References: <20220313151023.21229-1-jiaxin.yu@mediatek.com>
 <20220313151023.21229-7-jiaxin.yu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220313151023.21229-7-jiaxin.yu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com, tzungbi@google.com,
 linux-mediatek@lists.infradead.org, trevor.wu@mediatek.com,
 matthias.bgg@gmail.com, aaronyu@google.com, julianbraha@gmail.com,
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

Il 13/03/22 16:10, Jiaxin Yu ha scritto:
> Add mt8186 hw gain dai driver.
> 
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   .../soc/mediatek/mt8186/mt8186-dai-hw-gain.c  | 236 ++++++++++++++++++
>   1 file changed, 236 insertions(+)
>   create mode 100644 sound/soc/mediatek/mt8186/mt8186-dai-hw-gain.c
> 

