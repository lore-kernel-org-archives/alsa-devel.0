Return-Path: <SRS0=BIVw=Y7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C018C5DF61
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Nov 2019 13:49:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AA7C2187F
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Nov 2019 13:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="OkdeSkWL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AA7C2187F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D91FC1677;
	Thu,  7 Nov 2019 14:48:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D91FC1677
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573134569;
	bh=IIwWvXfAYvVF6h6LiHEo+9ZGYyR8DH9MFCD63VoMLsY=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=OkdeSkWL8s01zr1wrP9IGkSyUwgZ46AFcEgKoxbCRifeofMnb459O1p9hjvt7ssJX
	 58jwKH2EAMfDcVw0B9SXctDQUWT2ZwOi+zc9gbHRBINntCfSCXf9fI8uLvt9REfOSf
	 dVkkqD7FxM7OwaF7ypAK+jZGoZd9rIGrPsYjaXZA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 62B04F80446;
	Thu,  7 Nov 2019 14:48:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 097B5F8049B; Thu,  7 Nov 2019 14:48:38 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6AB74F80291
 for <alsa-devel@alsa-project.org>; Thu,  7 Nov 2019 14:48:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6AB74F80291
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 92526ACB4;
 Thu,  7 Nov 2019 13:48:34 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Date: Thu,  7 Nov 2019 14:48:33 +0100
Message-Id: <20191107134833.1502-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Cc: alsa-devel@alsa-project.org
Subject: [alsa-devel] [PATCH] ASoC: core: Fix compile warning with
	CONFIG_DEBUG_FS=n
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

UGFwZXIgb3ZlciBhIGNvbXBpbGUgd2FybmluZzoKICBzb3VuZC9zb2Mvc29jLXBjbS5jOjExODU6
ODogd2FybmluZzogdW51c2VkIHZhcmlhYmxlIOKAmG5hbWXigJkKCkZpeGVzOiAwNjMyZmEwNDI1
NDEgKCJBU29DOiBjb3JlOiBGaXggcGNtIGNvZGUgZGVidWdmcyBlcnJvciIpClNpZ25lZC1vZmYt
Ynk6IFRha2FzaGkgSXdhaSA8dGl3YWlAc3VzZS5kZT4KLS0tCiBzb3VuZC9zb2Mvc29jLXBjbS5j
IHwgMiArKwogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3Nv
dW5kL3NvYy9zb2MtcGNtLmMgYi9zb3VuZC9zb2Mvc29jLXBjbS5jCmluZGV4IDQ5M2EyZTgwZTg5
My4uNGJmNzFlMzIxMWQ4IDEwMDY0NAotLS0gYS9zb3VuZC9zb2Mvc29jLXBjbS5jCisrKyBiL3Nv
dW5kL3NvYy9zb2MtcGNtLmMKQEAgLTExODIsNyArMTE4Miw5IEBAIHN0YXRpYyBpbnQgZHBjbV9i
ZV9jb25uZWN0KHN0cnVjdCBzbmRfc29jX3BjbV9ydW50aW1lICpmZSwKIHsKIAlzdHJ1Y3Qgc25k
X3NvY19kcGNtICpkcGNtOwogCXVuc2lnbmVkIGxvbmcgZmxhZ3M7CisjaWZkZWYgQ09ORklHX0RF
QlVHX0ZTCiAJY2hhciAqbmFtZTsKKyNlbmRpZgogCiAJLyogb25seSBhZGQgbmV3IGRwY21zICov
CiAJZm9yX2VhY2hfZHBjbV9iZShmZSwgc3RyZWFtLCBkcGNtKSB7Ci0tIAoyLjE2LjQKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFp
bGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwczovL21haWxtYW4uYWxz
YS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
