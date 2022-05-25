Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13834C433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 25 May 2022 10:40:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 760B0166D;
	Wed, 25 May 2022 12:39:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 760B0166D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1653475239;
	bh=JtMKudCPbVBC4fPSg8WPLsPO72lG8JrBwViYM6bNNoI=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=szidYgivZ9EyOyxlgsIbYoY79QyigGq+vqBFvJteKiWB73ZY+nDrfTWymFOjx5DXP
	 ey2d+bU3oTEy4dqn3xrQB3UKLaZYgGFKHG8+uQ6cRINp/4/jV/g8LxmbsUcWv/JYJn
	 VF2v+KenERsGsR+I5jQYhqLswSaDyXwNiOg3Dgno=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D3019F80224;
	Wed, 25 May 2022 12:39:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1097AF8016D; Wed, 25 May 2022 12:39:46 +0200 (CEST)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3ED9AF80100;
 Wed, 25 May 2022 12:39:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3ED9AF80100
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.b="ei1cJvaB"
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: kholk11) with ESMTPSA id 5C5B31F448AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1653475175;
 bh=JtMKudCPbVBC4fPSg8WPLsPO72lG8JrBwViYM6bNNoI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ei1cJvaBsJOHecaFd4fbRaXHd2+DhGLrvQgIZDAknuw5CZDoea0DCSET+jljl/Odc
 I7defVnJskBOCTvNng734y1gn7qK9bQ+krN+2eGUQ44PbKqZhufzA65SgLvGbANq6o
 c1vBwwjfAWIE88mkjwfvoSmw9b50vTyiXGb6mx7Aa1XVhXzNLfcZNYlgJN4+6KxFfN
 n1fS6unEx/OgVs+kS/DWLlnj2gXcm//B4/ZSW1Nc+JsugNc2a2Z+jqS+pu/ZA3GQuH
 UMU+IKDdmvEMx3F/ULu59eHH8po7X6n1OBmguD10pVD2UVqPdljaPqjFqRq6lrqWya
 AxT5gFkChux2Q==
Message-ID: <54d6c0ff-d93c-0506-4db9-3852c69211ab@collabora.com>
Date: Wed, 25 May 2022 12:39:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v7 1/1] firmware: mediatek: add adsp ipc protocol interface
Content-Language: en-US
To: Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Mark Brown <broonie@kernel.org>
References: <20220407130338.28939-1-allen-kh.cheng@mediatek.com>
 <20220407130338.28939-2-allen-kh.cheng@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220407130338.28939-2-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 Linux-ALSA <alsa-devel@alsa-project.org>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, cujomalainey@google.com,
 Kevin Hilman <khilman@baylibre.com>, Takashi Iwai <tiwai@suse.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Project_Global_Chrome_Upstream_Group@mediatek.com, tzungbi@google.com,
 linux-mediatek@lists.infradead.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Chen-Yu Tsai <wenst@chromium.org>, Daniel Baluta <daniel.baluta@nxp.com>,
 linux-kernel@vger.kernel.org, sound-open-firmware@alsa-project.org
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

Il 07/04/22 15:03, Allen-KH Cheng ha scritto:
> From: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
> 
> Some of mediatek processors contain
> the Tensilica HiFix DSP for audio processing.
> 
> The communication between Host CPU and DSP firmware is
> taking place using a shared memory area for message passing.
> 
> ADSP IPC protocol offers (send/recv) interfaces using
> mediatek-mailbox APIs.
> 
> We use two mbox channels to implement a request-reply protocol.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Curtis Malainey <cujomalainey@chromium.org>
> Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
> Reviewed-by: YC Hung <yc.hung@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   drivers/firmware/Kconfig                      |   1 +
>   drivers/firmware/Makefile                     |   1 +
>   drivers/firmware/mediatek/Kconfig             |   9 +
>   drivers/firmware/mediatek/Makefile            |   2 +
>   drivers/firmware/mediatek/mtk-adsp-ipc.c      | 161 ++++++++++++++++++
>   .../linux/firmware/mediatek/mtk-adsp-ipc.h    |  65 +++++++
>   6 files changed, 239 insertions(+)
>   create mode 100644 drivers/firmware/mediatek/Kconfig
>   create mode 100644 drivers/firmware/mediatek/Makefile
>   create mode 100644 drivers/firmware/mediatek/mtk-adsp-ipc.c
>   create mode 100644 include/linux/firmware/mediatek/mtk-adsp-ipc.h
> 

Gentle ping for this one, as it's getting stale... and it's ready.

To add context, this driver is *really* necessary, as support for it
is added in the MT8195 ASoC SOF driver as a platform device [1], and the
necessary memory regions are coming from the mediatek,mt8195-dsp [2] driver.

[1]: 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/sound/soc/sof/mediatek/mt8195/mt8195.c?h=next-20220525#n389

[2]: 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/dsp/mediatek,mt8195-dsp.yaml?h=next-20220525#n61

Cheers,
Angelo
