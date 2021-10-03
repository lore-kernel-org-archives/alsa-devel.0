Return-Path: <SRS0=D1rU=OX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DF8C433EF
	for <alsa-devel@archiver.kernel.org>; Sun,  3 Oct 2021 13:14:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2278461B00
	for <alsa-devel@archiver.kernel.org>; Sun,  3 Oct 2021 13:14:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2278461B00
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C0FF5166E;
	Sun,  3 Oct 2021 15:13:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C0FF5166E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633266843;
	bh=62mViZYIQYHctnR83GwNDfIat6/vCYbiyOjaODVzWsw=;
	h=To:From:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kuBJkwzN61CFnIzR54xPQQFbJQV1zRHNFe6hXG4AlnsxY3T6shmKZUTqiZQsgyTP8
	 nVOZx45K0Wkb7oSE30B+gGVHPlfxXQ93kfOThoMCYE/It4mEhDL2pc0HSPTJ0ywDym
	 9nhF9A2yEfoPow2vq34JpHmpAM3wp9/1dgJ9OwMM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1307EF80259;
	Sun,  3 Oct 2021 15:13:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0DE28F8027D; Sun,  3 Oct 2021 15:13:11 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CB077F800ED
 for <alsa-devel@alsa-project.org>; Sun,  3 Oct 2021 15:13:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CB077F800ED
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="K9Hjthkj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633266781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6TVy9yZEGRvLXxDJHxXj1qPpqwRB13EKs8e3L5Wk0No=;
 b=K9HjthkjijAxOzuQCaD9YXkZrI2qvX9nfWu4fIityM6kC/0siPoPBeUoCW3YBAjNJh9hx4
 EYBENkqSvyJ1F/KPzb5yY8ejy7Uvi09C/+bCHG1I/+zBGattGvlV0MQnS047AaEliOO5c3
 3J++JiP0xVCx5cO5OidOCvEgr9tUe7w=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-P2FdbPffMBi41yKiJnj3oA-1; Sun, 03 Oct 2021 09:13:00 -0400
X-MC-Unique: P2FdbPffMBi41yKiJnj3oA-1
Received: by mail-ed1-f69.google.com with SMTP id
 c7-20020a05640227c700b003d27f41f1d4so14497985ede.16
 for <alsa-devel@alsa-project.org>; Sun, 03 Oct 2021 06:12:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:to:from:subject:message-id:date:user-agent
 :mime-version:content-language:content-transfer-encoding;
 bh=6TVy9yZEGRvLXxDJHxXj1qPpqwRB13EKs8e3L5Wk0No=;
 b=CCYuCSgaIKznRHwzwXpCcvbeDIRvCXwwiVUa1iH5jdUQ7Ttn5/0SVtk8Wvb7ilyQUZ
 Gz3E6L0pMb4JQLSVbJrDlwAYaRbW8uKwcswm5gQupEs9VQvxqJ9Hc99suuTvZdYQUw1P
 CTmf6C8+tVZMB7hnKiYWwnUJlMx/6LxfMkedwOjhcO3VkKEim2Y+d6SC/nWYUmVsLANu
 mzlCd+QmT1mv/p8w1tEbmZUsnxsyHKY7n2PdR0rjLIRFnxapV2pubXzXsn77iMzatq2C
 BSAve+P6n9Q6zglBBfbC7zmN+udEQiaGPGjPG1hUlVP1xlpDZ4RZ+hYMBoxol8DzWDLS
 zAFg==
X-Gm-Message-State: AOAM53333/m/h8V5nyXf5Sm49zYYx4Sv2ywb0uUM1R2oKYqjK3whWb4U
 kn9DJistnEKtG/OIOemsanuNNGjrluClDrHEVDHj8sM6Pa+dJ/GXPGxC81MOrowP+lByxqkMKAY
 0oAqFhR/lL3pfc6jqPCPeHAwJq/mya7n2Xdc1Q0z3quBVoFPpzTkcTnRxUSB13CBeh8F7uvETaY
 E=
X-Received: by 2002:a17:906:254b:: with SMTP id
 j11mr128577ejb.513.1633266778594; 
 Sun, 03 Oct 2021 06:12:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/0yKLFvT2KvBuG982TiHGHE/QRrORwXnOMl69K20fCJ+6CE2tJY59AjgWY7qLuFpmaPW9XA==
X-Received: by 2002:a17:906:254b:: with SMTP id
 j11mr128552ejb.513.1633266778347; 
 Sun, 03 Oct 2021 06:12:58 -0700 (PDT)
Received: from x1.localdomain
 (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
 by smtp.gmail.com with ESMTPSA id k7sm5781249eds.96.2021.10.03.06.12.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Oct 2021 06:12:57 -0700 (PDT)
To: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
 Mark Brown <broonie@kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
From: Hans de Goede <hdegoede@redhat.com>
Subject: DAPM PIN switches do not update in alsamixer when changed through UCM
 profile
Message-ID: <b8cf9bb0-bad1-26a0-0806-0a7c66b228d0@redhat.com>
Date: Sun, 3 Oct 2021 15:12:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hdegoede@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

Hi All,

I notice that DAPM PIN switches, such as e.g. the "Headphone"
SOC_DAPM_PIN_SWITCH defined in:
sound/soc/intel/boards/cht_bsw_nau8824.c:

static const struct snd_kcontrol_new cht_mc_controls[] = {
        SOC_DAPM_PIN_SWITCH("Headphone"),
        SOC_DAPM_PIN_SWITCH("Headset Mic"),
        SOC_DAPM_PIN_SWITCH("Int Mic"),
        SOC_DAPM_PIN_SWITCH("Ext Spk"),
};

Do not get updated to reflect state-changes when the output
is switched between e.g. Headphone / "Ext Spk" by
pulseaudio/pipewire through the UCM profile mechanism.

If I exit alsa-mixer after changing the output and
start it again then the control does show the expect
value. So it seems that we are failing to send a change
event about this somewhere?

Regards,

Hans

