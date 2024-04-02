Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF795CD1284
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Apr 2024 07:15:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E7E542D4B;
	Tue,  2 Apr 2024 09:15:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E7E542D4B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1712042139;
	bh=CnqvqodaYlEijS3S66gpBo6NENtbjINPKzjAxCX8Ei4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=Bn6C1vhgAyS+BQrk4q/on4eejpxG79I5IMMNBZv8tQ9AEpQbYwb0fQeN0csklrOLM
	 r6esA0r2b4ttMk24y9kjkuYa3zJc4YbTe4BUWnNUSz6QRusosLRT2Cr9JkfseB/pOh
	 tdP2iisnmHjs6MbvdyIqU7QODPwSK4UB8m87vu/k=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B62C0F89B62; Tue,  2 Apr 2024 08:58:06 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E46D3F89C97;
	Tue,  2 Apr 2024 08:58:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BEA6BF80568; Tue,  2 Apr 2024 08:20:58 +0200 (CEST)
Received: from mail78-50.sinamail.sina.com.cn (mail78-50.sinamail.sina.com.cn
 [219.142.78.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3FE8BF80114
	for <alsa-devel@alsa-project.org>; Tue,  2 Apr 2024 08:20:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3FE8BF80114
Received: from unknown (HELO zy-virtual-machine.localdomain)([116.232.53.71])
	by sina.net (10.75.30.234) with ESMTP
	id 660BA3B800029E89; Tue, 2 Apr 2024 14:20:41 +0800 (CST)
X-Sender: zhangyi@everest-semi.com
X-Auth-ID: zhangyi@everest-semi.com
Authentication-Results: sina.net;
	 spf=none smtp.mailfrom=zhangyi@everest-semi.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=zhangyi@everest-semi.com
X-SMAIL-MID: 3628553C6A8B4395838E59847DFF327A
X-SMAIL-UIID: 3628553C6A8B4395838E59847DFF327A-20240402-142041
From: Zhang Yi <zhangyi@everest-semi.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Cc: tiwai@suse.com,
	amadeuszx.slawinski@linux.intel.com,
	yangxiaohua@everest-semi.com,
	zhuning@everest-semi.com,
	zhangyi@everest-semi.com
Subject: [PATCH 0/4] ASoC: codecs: ES8326: solve some hp issues and
Date: Tue,  2 Apr 2024 14:20:39 +0800
Message-Id: <20240402062043.20608-1-zhangyi@everest-semi.com>
X-Mailer: git-send-email 2.17.1
X-MailFrom: zhangyi@everest-semi.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: 646QAA3USQBJEGFLSIMHNUQKWACZTDSU
X-Message-ID-Hash: 646QAA3USQBJEGFLSIMHNUQKWACZTDSU
X-Mailman-Approved-At: Tue, 02 Apr 2024 06:54:58 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/646QAA3USQBJEGFLSIMHNUQKWACZTDSU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

We solved some issues related to headphone detection.And for using 
the same configuration in different power conditions,we modified the
clock table

Zhang Yi (4):
  ASoC: codecs: ES8326: Solve error interruption issue
  ASoC: codecs: ES8326: modify clock table
  ASoC: codecs: ES8326: Solve a headphone detection issue after suspend
    and resume
  ASoC: codecs: ES8326: Removing the control of ADC_SCALE

 sound/soc/codecs/es8326.c | 37 +++++++++++++++++++++----------------
 sound/soc/codecs/es8326.h |  2 +-
 2 files changed, 22 insertions(+), 17 deletions(-)

-- 
2.17.1

