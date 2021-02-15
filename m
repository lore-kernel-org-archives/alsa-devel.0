Return-Path: <SRS0=nH8J=HR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C014BC433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Feb 2021 18:10:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4358764DA5
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Feb 2021 18:10:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4358764DA5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E1AA61687;
	Mon, 15 Feb 2021 19:09:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E1AA61687
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1613412617;
	bh=OxmIBynjTsv+RMxYWEmX3m4XOEettTlPVpwB2SeqFXc=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U6f4hMT0oSLktqUiCXtopwMQvKA2tgGZRO+uswQvj0o0FRC/ehD14zug+vNS1c6JG
	 zYLpleipA5wXllwYPPFt4EQEjofNWS/Y8jXd/8naheL1E0Am8B1mtT3l60rXZ2qUn5
	 zIQnFmHPc/FfY2VUmkcAlLgUMBBBMbAkdHj+7BPA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6A0FDF8020B;
	Mon, 15 Feb 2021 19:09:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 72B6BF80258; Mon, 15 Feb 2021 19:09:24 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4D9ACF80089
 for <alsa-devel@alsa-project.org>; Mon, 15 Feb 2021 19:09:16 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id EFD30A003F;
 Mon, 15 Feb 2021 19:09:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz EFD30A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1613412556; bh=wDPcEQuDQNPC/0k+3Sj/lBIRA51gHlOJ9MQY2mlhyqo=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=emmNiJiobnfzaT28sxz/ZUbM0/bKp2zW+AkSWbpBybhaOdhm7zkdjlWuV58FScsFi
 pvu4aQC41UUCbw8mYdXnRy9yNLoDUgs2LAgLiSprQ4RWTWExvPTZ/aRGFFNMIL/d9q
 LKZOzwsN3in7HfH6eLXM7eSOAcb5gmENYtEjEUAY=
Received: from p1gen2.localdomain (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Mon, 15 Feb 2021 19:09:08 +0100 (CET)
Subject: Re: [PATCH 2/4] ASoC: rt5670: Remove 'HP Playback Switch' control
To: Hans de Goede <hdegoede@redhat.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Oder Chiou <oder_chiou@realtek.com>
References: <20210215142118.308516-1-hdegoede@redhat.com>
 <20210215142118.308516-3-hdegoede@redhat.com>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <d3eb3192-851b-3d18-269a-725d74256010@perex.cz>
Date: Mon, 15 Feb 2021 19:09:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210215142118.308516-3-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
 Bard Liao <bard.liao@intel.com>
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

Dne 15. 02. 21 v 15:21 Hans de Goede napsal(a):
> The RT5670_L_MUTE_SFT and RT5670_R_MUTE_SFT bits (bits 15 and 7) of the
> RT5670_HP_VOL register are set / unset by the headphones deplop code
> run by rt5670_hp_event() on SND_SOC_DAPM_POST_PMU / SND_SOC_DAPM_PRE_PMD.
> 
> So we should not also export a control to userspace which toggles these
> same bits.

I think that it may be worth to preserve the full-mute functionality.
According the datasheet, the register 0x02 has volume range -46.5dB..12dB.
Even the lowest volume may produce an audible output.

I would cache the mute switch value in rt5670_priv and update the
POST_PMU/PRE_PMD code to use this settings.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
