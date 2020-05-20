Return-Path: <SRS0=qDfi=7C=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF239C433DF
	for <alsa-devel@archiver.kernel.org>; Wed, 20 May 2020 06:50:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7805120748
	for <alsa-devel@archiver.kernel.org>; Wed, 20 May 2020 06:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="MZHmKLWO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="j55eY0K7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vxFpneb4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7805120748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BC97D17BA;
	Wed, 20 May 2020 08:49:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BC97D17BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589957422;
	bh=5coqwOsDxULEMdFITHu3RFBEhRHDdPHqy6uiYOYsrmA=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MZHmKLWOpOn20B3xNEsWMW+rRUSWcMg6RBRHz12g+C0+V1/fumKH3iw8x3pRKSvry
	 fbEiYMQZeSTOJEdSXqzDh1gDk/dGcbCdHUUNwam3Zt0wkgWnBnxrK1fSidvtE4ZHMm
	 B1tUJYt0QqMiBgSo3MNvPTS8BoenI44NtgGeJ0pY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4009CF80274;
	Wed, 20 May 2020 08:47:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BC0DCF801F9; Wed, 20 May 2020 08:47:50 +0200 (CEST)
Received: from wnew4-smtp.messagingengine.com (wnew4-smtp.messagingengine.com
 [64.147.123.18])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9040BF801DA
 for <alsa-devel@alsa-project.org>; Wed, 20 May 2020 08:47:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9040BF801DA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="j55eY0K7"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="vxFpneb4"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
 by mailnew.west.internal (Postfix) with ESMTP id D773AD20;
 Wed, 20 May 2020 02:47:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Wed, 20 May 2020 02:47:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm1; bh=Xbd4QyjDbF3SZl1k6t/MWDx0nV
 5JpEWjamT7q5zFZII=; b=j55eY0K7CWhdP023ay70cQNnhbIJQCyegwrSOP42Rh
 IziFFYQ7A2/evQftoSjXUaP0ux+p1kS88a0iCwanIeqOG87NlR5K+9VD2Z4AMWkq
 kLFg8AooNZtpsGk94Hcqww80vT5Ud2iJMfJEfwC+f56EgJgg5yy5yebIhZti1fVr
 jQ/FlFcnwGWWaw+zht282gLV0edgnsocrD7PS0OaKLRCJzy7b4Js2io8zEK4l+m8
 uZ6sJ9XmEq6qRKHaFWGpyjWR+uytq7Eu73WMZHmzA9+J9W/MiMgSRyjDw3nLIDZ0
 ryJh/QxzaSa8Kfn2GiGIiIlpH7+AOK8Jz/D4hT1KcltA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=Xbd4QyjDbF3SZl1k6
 t/MWDx0nV5JpEWjamT7q5zFZII=; b=vxFpneb4AQRP42YQrOxd5MguOzBczVacw
 L2pSmH8J3dRi5QeW9wvFVoKgDDqSYK8Q14MpsX24Gx05G5XTfblfFaR3C8/q6rI/
 2XmShjE0TxY+6ZgpbXSbQYGb6UaLomWD1j3um+rf1OMqHNQwmsYJGorwSHH7vdDw
 Lw4XMi4o276un4C75CVK0HypgXzVZcgy8COHE8Kg/d/Ir0cpFE5vuwJlt11S8HfN
 vKGPGMbfHiCqOyl7koaGofle8w/NiWAi43VArjxIJCyK6puzm+Aeqda+dw/Iev+s
 PD8EIuSzoBIxcxM725omJOEelnOzUSbbunT5XtqzBd9Dcajed6OqQ==
X-ME-Sender: <xms:g9LEXsWJFdSbW1r7_l23A3C_F-_WS-AuHv9nCRowBAjn_96g79INLA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddtkedguddtkecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertd
 ertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
 hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeetieeuhfejke
 ekfeehteeikedvgeefhffggfdvieehhefhheeivdfhgfejjeduudenucffohhmrghinhep
 khgvrhhnvghlrdhorhhgnecukfhppedukedtrddvfeehrdefrdehgeenucevlhhushhtvg
 hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehs
 rghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:g9LEXgnDhMYZZj0Yeaf3VvhSVXXDmPMghHVRbuzkitF-M0CgOic-fQ>
 <xmx:g9LEXgZ5bV8guLeV3VsTRyZ4PUNYaYcFQO1yxR_hp4macoEiLvJs2Q>
 <xmx:g9LEXrVXwwZBlGf71tDBDnm2mSc1fMLAUpJp1Mv6ODzntLMoJ_f6Hw>
 <xmx:iNLEXrjPYfmQ0mMgmisOjMSJN3ivHeiCyDlICOFv1t8CNADHradYNPY8IiE>
Received: from workstation.flets-east.jp (ad003054.dynamic.ppp.asahi-net.or.jp
 [180.235.3.54])
 by mail.messagingengine.com (Postfix) with ESMTPA id 4A7E03280060;
 Wed, 20 May 2020 02:47:29 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: oscar.carter@gmx.com, keescook@chromium.org, mchehab@kernel.org,
 clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Subject: [PATCH 0/2] firewire: obsolete cast of function callback toward CFI
Date: Wed, 20 May 2020 15:47:24 +0900
Message-Id: <20200520064726.31838-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, kernel-hardening@lists.openwall.com,
 linux-kernel@vger.kernel.org, stefanr@s5r6.in-berlin.de, levonshe@gmail.com,
 linux1394-devel@lists.sourceforge.net, linux-media@vger.kernel.org
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

Hi,

Oscar Carter works for Control Flow Integrity build. Any cast
of function callback is inconvenient for the work. Unfortunately,
current code of firewire-core driver includes the cast[1] and Oscar
posted some patches to remove it[2]. The patch is itself good. However,
it includes changes existent kernel API and all of drivers as user
of the API get affects from the change.

This patchset is an alternative idea to add a new kernel API specific
for multichannel isoc context. The existent kernel API and drivers is
left as is.

Practically, no in-kernel drivers use the additional API. Although the
API is exported in the patchset, it's better to discuss about unexporting
the API.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/firewire/core-cdev.c#n985
[2] https://lore.kernel.org/lkml/20200519173425.4724-1-oscar.carter@gmx.com/

Regards

Takashi Sakamoto (2):
  firewire-core: add kernel API to construct multichannel isoc context
  firewire-core: obsolete cast of function callback

 drivers/firewire/core-cdev.c | 44 +++++++++++++++++++-----------------
 drivers/firewire/core-iso.c  | 17 ++++++++++++++
 include/linux/firewire.h     |  3 +++
 3 files changed, 43 insertions(+), 21 deletions(-)

-- 
2.25.1

