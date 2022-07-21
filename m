Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E42E7C433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Jul 2022 15:51:32 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EC50E181F;
	Thu, 21 Jul 2022 17:50:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EC50E181F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1658418691;
	bh=njE1BYwtOvOFHJuZqFEVUyHuHifn3FPMZhTGH551ncs=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FFE5NB0SwFEv+H24Q6DinOPgKhLIiGk9GD8uv2S30oh6cgNhniaFgfj64awnnqT1L
	 YeAHYoLKdMlS2rC/DB9s698ctKpPjFTHWgLplfQdb2KVIeR0tbXzlOatUQV1R6n132
	 DnALFPegU/bVrAsXUJQxYiS6c7MAbx8lk3c4uIF0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 877E4F8047C;
	Thu, 21 Jul 2022 17:50:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B2BFDF804D6; Thu, 21 Jul 2022 17:50:38 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C7AC2F8016D
 for <alsa-devel@alsa-project.org>; Thu, 21 Jul 2022 17:50:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C7AC2F8016D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="MOPgq9sy"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26L5LeXL020687;
 Thu, 21 Jul 2022 10:50:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=Apq/AgQpV/gyFR7POoYO5N2hlaO5daOXlN1AT17e/Gs=;
 b=MOPgq9syNYnW11k80AdW5iNehLZHwGamk+2+VHavYLMbHeaf9zUa3kM+8kpJNXsa9LDp
 XFS8wDzxNNVq6l2aEg3YP0kxYR6+ODVDqucCGuMSf9Gyv9zrdZ4cb4OseWV8QCn6WRdE
 ZtHNe5oZ5Hkl0H64/ul1tbQHXZ2nOXAFgnVoX0YohiA0qmGsaTmaU/Es0rzlg3urAGy7
 Fo2K39X2GBZtN9cYixyKPEZy7TQoCF7SZYMaVgW1cKW7qaaM9V/z87NxBi/Y141CLr21
 bJQfnLH4dPEJ9CdCQ2MUUyZWcPVwZYmcqLC9igcQYT5kIMdKcS8+n80yiqNtZm4eJ1Bh hw== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
 by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3hdxffarqd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 Jul 2022 10:50:31 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Thu, 21 Jul
 2022 10:50:29 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1118.9 via Frontend Transport; Thu, 21 Jul 2022 10:50:29 -0500
Received: from [198.90.202.131] (unknown [198.90.202.131])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 081E946B;
 Thu, 21 Jul 2022 15:50:29 +0000 (UTC)
Message-ID: <f7dde431-7a97-b5bb-a47e-8953030ade87@opensource.cirrus.com>
Date: Thu, 21 Jul 2022 16:50:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] ALSA: hda/realtek: Enable speaker and mute LEDs for HP
 laptops
Content-Language: en-US
To: Kai-Heng Feng <kai.heng.feng@canonical.com>, <tiwai@suse.com>
References: <20220719142015.244426-1-kai.heng.feng@canonical.com>
From: Lucas Tanure <tanureal@opensource.cirrus.com>
In-Reply-To: <20220719142015.244426-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: WNlq5lSN-9U0aC-DxBmpXoFUpqeh__MR
X-Proofpoint-GUID: WNlq5lSN-9U0aC-DxBmpXoFUpqeh__MR
X-Proofpoint-Spam-Reason: safe
Cc: Stefan Binding <sbinding@opensource.cirrus.com>,
 Kailang Yang <kailang@realtek.com>, alsa-devel@alsa-project.org,
 Meng Tang <tangmeng@uniontech.com>, linux-kernel@vger.kernel.org,
 Werner Sembach <wse@tuxedocomputers.com>,
 Tim Crawford <tcrawford@system76.com>, Andy Chi <andy.chi@canonical.com>,
 patches@opensource.cirrus.com, Cameron Berkenpas <cam@neo-zeon.de>,
 Yong Wu <yong.wu@mediatek.com>
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


On 7/19/22 15:20, Kai-Heng Feng wrote:
> Two more HP laptops that use cs35l41 AMP for speaker and GPIO for mute
> LEDs.
>
> So use the existing quirk to enable them accordingly.
>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Reviewed-by: Lucas Tanure <tanureal@opensource.cirrus.com>
> ---
>   sound/pci/hda/patch_realtek.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index 2f55bc43bfa9c..cdbee71e83216 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -9109,6 +9109,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
>   	SND_PCI_QUIRK(0x103c, 0x89c3, "Zbook Studio G9", ALC245_FIXUP_CS35L41_SPI_4_HP_GPIO_LED),
>   	SND_PCI_QUIRK(0x103c, 0x89c6, "Zbook Fury 17 G9", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
>   	SND_PCI_QUIRK(0x103c, 0x89ca, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
> +	SND_PCI_QUIRK(0x103c, 0x8ad1, "HP EliteBook 840 14 inch G9 Notebook PC", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
> +	SND_PCI_QUIRK(0x103c, 0x8ad2, "HP EliteBook 860 16 inch G9 Notebook PC", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
>   	SND_PCI_QUIRK(0x103c, 0x8a78, "HP Dev One", ALC285_FIXUP_HP_LIMIT_INT_MIC_BOOST),
>   	SND_PCI_QUIRK(0x103c, 0x8aa0, "HP ProBook 440 G9 (MB 8A9E)", ALC236_FIXUP_HP_GPIO_LED),
>   	SND_PCI_QUIRK(0x103c, 0x8aa3, "HP ProBook 450 G9 (MB 8AA1)", ALC236_FIXUP_HP_GPIO_LED),
