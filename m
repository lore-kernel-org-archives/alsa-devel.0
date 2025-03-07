Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C322C35FF1
	for <alsa-devel@archiver.kernel.org>; Fri, 14 Mar 2025 15:56:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D8AB4603F8;
	Fri, 14 Mar 2025 16:56:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D8AB4603F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1741967812;
	bh=0JFI5Z8/U/mF6yj+0eCDZGsxNJSh+rt5QoGEH8wGgSs=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=RCDUiahoZwSRFcRK7O7zSAxenW44TzIkP0oHDRmajfPbftdVc4MLhSeUSga9GkBAV
	 q9PRpJua/FnJYlplyFAWiTrdIAIQrTquwSJ821lTg6eTRv2uGVPtvVNQKQTpEtXh+/
	 qi1/Z7px8nWjDF0iz5ksiyf/wW7vVrA5WFAClxeQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 418C7F805B4; Fri, 14 Mar 2025 16:56:19 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E8CF8F805B2;
	Fri, 14 Mar 2025 16:56:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2C0DFF80526; Fri,  7 Mar 2025 09:00:38 +0100 (CET)
Received: from smtp134-86.sina.com.cn (smtp134-86.sina.com.cn
 [180.149.134.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 504C3F800ED
	for <alsa-devel@alsa-project.org>; Fri,  7 Mar 2025 09:00:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 504C3F800ED
Received: from unknown (HELO
 zy-virtual-machine.localdomain)([180.159.108.137])
	by sina.net (10.185.250.30) with ESMTP
	id 67CAA797000047AE; Fri, 7 Mar 2025 16:00:24 +0800 (CST)
X-Sender: zhangyi@everest-semi.com
X-Auth-ID: zhangyi@everest-semi.com
Authentication-Results: sina.net;
	 spf=none smtp.mailfrom=zhangyi@everest-semi.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=zhangyi@everest-semi.com
X-SMAIL-MID: 6E3499F1222B4B0A95D319F782851310
X-SMAIL-UIID: 6E3499F1222B4B0A95D319F782851310-20250307-160024
From: Zhang Yi <zhangyi@everest-semi.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org,
	devicetree@vger.kernel.org
Cc: tiwai@suse.com,
	amadeuszx.slawinski@linux.intel.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Subject: RE: [PATCH v4 1/2] ASoC: codecs: add support for ES8389
Date: Fri,  7 Mar 2025 16:00:23 +0800
Message-Id: <20250307080023.63815-1-zhangyi@everest-semi.com>
X-Mailer: git-send-email 2.17.1
X-MailFrom: zhangyi@everest-semi.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: YUBF6PAYMF5HSHV2JG2PFWV4FZFLQ5PW
X-Message-ID-Hash: YUBF6PAYMF5HSHV2JG2PFWV4FZFLQ5PW
X-Mailman-Approved-At: Fri, 14 Mar 2025 15:56:14 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YUBF6PAYMF5HSHV2JG2PFWV4FZFLQ5PW/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

> > > No, the machine driver should be configuring different TDM slots for
> > > each device - that's the whole point of the API.
> 
> > We are using multiple codecs as a single device.So we can't use set_tdm_slot to configure
> > different slots for multiple codecs under one device.
> 
> What do you mean by using it "as a single device"?  Multiple CODECs on
> the same link is the main use case for set_tdm_slot().

Thanks for the advice.The method you mentioned could work.
I will modify my driver.
