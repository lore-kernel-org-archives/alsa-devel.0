Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 992B9ECAAA1
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Sep 2022 07:49:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DEA6C1638;
	Mon,  5 Sep 2022 09:49:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DEA6C1638
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1662364196;
	bh=ifeP0r3pcu7K42tQxkfGTWseJu3C0X8ZYf3G/UE662w=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Yj6wIZW/S1G+oO20b9MLCe/U0wkwxKurEUnRYp/7LspdC9XXrDHWHxFSM6Xk6ekLG
	 n7jtPLsrgJUrRb/Vmv5Ng7p/7BRioWBn5xBcu284VrRW/KyrrBRSx1k/CR06LWGdkD
	 W0KIluAbqFJbs/D2kCyyftjXErvP3j57Wiln1aLo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7DB4EF80238;
	Mon,  5 Sep 2022 09:49:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 76FA4F80238; Mon,  5 Sep 2022 09:49:02 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 23A7DF800E8;
 Mon,  5 Sep 2022 09:48:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 23A7DF800E8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.b="lO/v/0Yo"
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it
 [2.237.20.237])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 73DCC6601E74;
 Mon,  5 Sep 2022 08:48:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1662364134;
 bh=ifeP0r3pcu7K42tQxkfGTWseJu3C0X8ZYf3G/UE662w=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=lO/v/0YooHjyVD5h+o5PJdm2yp6Gza2tJURV14lNDSVKyH5yV9rlkO68HKveNAXv0
 yjk7ni1KJf3JkfvCQGe6O0m30yZca+d8Q81v6XpeJlQ0QmWeAOVloK6ZrNplz1ja6n
 T+BwDp9/Vbpst9fwYnWpbn3+51obCq/SLsZAula4IMmnlGrRAYmZKQYvQfzZhcHOZH
 SrkwF2WKu7miuFK9QnX/KFJtUxPNZR7mjgOVae9fkpZmnYaJLDzrf2Um4CfvlNvWLy
 hLQg7WuBZpo76KNB2bBMEiA/tvgTbBsrfFdK/P4mNoffi3zAl02C3UMxTECvJiHNIT
 pX22l/bHp63JA==
Message-ID: <d1815aba-e11b-9014-e1d1-59425c4358df@collabora.com>
Date: Mon, 5 Sep 2022 09:48:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] ASoC: SOF: Introduce function sof_of_machine_select
To: Chunxu Li <chunxu.li@mediatek.com>, broonie@kernel.org,
 pierre-louis.bossart@linux.intel.com, peter.ujfalusi@linux.intel.com,
 lgirdwood@gmail.com, daniel.baluta@nxp.com
References: <20220903032151.13664-1-chunxu.li@mediatek.com>
Content-Language: en-US
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220903032151.13664-1-chunxu.li@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 project_global_chrome_upstream_group@mediatek.com,
 linux-mediatek@lists.infradead.org, yc.hung@mediatek.com,
 matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
 sound-open-firmware@alsa-project.org
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

Il 03/09/22 05:21, Chunxu Li ha scritto:
>  From current design in sof_machine_check the SOF can only support
> ACPI type machine.
> 
> In sof_machine_check if there is no ACPI machine exist, the function
> will return -ENODEV directly, that's we don't expected if we do not
> base on ACPI machine.
> 
> So we add a new function named sof_of_machine_select that we can pass
> sof_machine_check and obtain info required by snd_sof_new_platform_drv.
> 
> Signed-off-by: Chunxu Li <chunxu.li@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


