Return-Path: <SRS0=uq2S=3A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87920C282DD
	for <alsa-devel@archiver.kernel.org>; Sat, 11 Jan 2020 20:34:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FDC12084D
	for <alsa-devel@archiver.kernel.org>; Sat, 11 Jan 2020 20:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Ho3A5C66"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FDC12084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 46A8316A0;
	Sat, 11 Jan 2020 21:33:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 46A8316A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578774876;
	bh=s6jsoOHkJ3uxLLFGJcwzh0D8Uo2bKl+a5Ke8UN6TGnI=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Ho3A5C664E6fO/59UO93TSnw3RGUUtGtQ7OHtCBx+JIXug3An3x6iviSvpkXN2xqG
	 YPJzdIqfX2BHXmDCviJtZZJaCkkxfeIP99YVa7bvCCLh4szBHvDxWj9KkCR6+0SBqo
	 icuwL78i/e7u81A4S2VPs9OFJwiYxLPWJwbobCtI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8373EF80172;
	Sat, 11 Jan 2020 21:33:45 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0B1A2F801F4; Sat, 11 Jan 2020 21:33:44 +0100 (CET)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0D83FF800B9
 for <alsa-devel@alsa-project.org>; Sat, 11 Jan 2020 21:33:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0D83FF800B9
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Jan 2020 12:33:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,422,1571727600"; d="scan'208";a="212592262"
Received: from jwoodman-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.254.178.150])
 by orsmga007.jf.intel.com with ESMTP; 11 Jan 2020 12:33:33 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Sat, 11 Jan 2020 14:33:25 -0600
Message-Id: <20200111203325.20498-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: tiwai@suse.de, broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Arnd Bergmann <arnd@arndb.de>, Baolin Wang <baolin.wang@linaro.org>
Subject: [alsa-devel] [PATCH] ALSA: timer: fix nsec/sec initialization
	confusion
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

R0NDIHJlcG9ydHMgYSB3YXJuaW5nIHdpdGggVz0xOgoKc291bmQvY29yZS90aW1lci5jOiBJbiBm
dW5jdGlvbiDigJhzbmRfdGltZXJfdXNlcl9yZWFk4oCZOgpzb3VuZC9jb3JlL3RpbWVyLmM6MjIx
OToxOTogd2FybmluZzogaW5pdGlhbGl6ZWQgZmllbGQgb3ZlcndyaXR0ZW4KWy1Xb3ZlcnJpZGUt
aW5pdF0KIDIyMTkgfCAgICAgLnRzdGFtcF9zZWMgPSB0cmVhZC0+dHN0YW1wX25zZWMsCiAgICAg
IHwgICAgICAgICAgICAgICAgICAgXn5+fn4Kc291bmQvY29yZS90aW1lci5jOjIyMTk6MTk6IG5v
dGU6IChuZWFyIGluaXRpYWxpemF0aW9uIGZvcgrigJgoYW5vbnltb3VzKS50c3RhbXBfc2Vj4oCZ
KQoKQXNzaWduaW5nIG5zZWMgdmFsdWVzIHRvIHNlYyBmaWVsZHMgaXMgcHJvYmxlbWF0aWMgaW4g
Z2VuZXJhbCwgZXZlbgptb3JlIHNvIHdoZW4gdGhlIGluaXRpYWwgZ29hbCB3YXMgdG8gc3Vydml2
ZSB0aGUgMjAzMCB0aW1lcgphcm1hZ2VkZG9uLgoKRml4IGJ5IHVzaW5nIHRoZSBwcm9wZXIgZmll
bGQgaW4gdGhlIGluaXRpYWxpemF0aW9uCgpDYzogQmFvbGluIFdhbmcgPGJhb2xpbi53YW5nQGxp
bmFyby5vcmc+CkNjOiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPgpGaXhlczogMDcwOTRh
ZTZmOTUyNyAoIkFMU0E6IEF2b2lkIHVzaW5nIHRpbWVzcGVjIGZvciBzdHJ1Y3Qgc25kX3RpbWVy
X3RyZWFkIikKU2lnbmVkLW9mZi1ieTogUGllcnJlLUxvdWlzIEJvc3NhcnQgPHBpZXJyZS1sb3Vp
cy5ib3NzYXJ0QGxpbnV4LmludGVsLmNvbT4KLS0tCiBzb3VuZC9jb3JlL3RpbWVyLmMgfCAyICst
CiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1n
aXQgYS9zb3VuZC9jb3JlL3RpbWVyLmMgYi9zb3VuZC9jb3JlL3RpbWVyLmMKaW5kZXggODgzNWZm
OTFhODkzLi5kOWY4NWYyZDY2YTMgMTAwNjQ0Ci0tLSBhL3NvdW5kL2NvcmUvdGltZXIuYworKysg
Yi9zb3VuZC9jb3JlL3RpbWVyLmMKQEAgLTIyMTYsNyArMjIxNiw3IEBAIHN0YXRpYyBzc2l6ZV90
IHNuZF90aW1lcl91c2VyX3JlYWQoc3RydWN0IGZpbGUgKmZpbGUsIGNoYXIgX191c2VyICpidWZm
ZXIsCiAJCQl0cmVhZDMyID0gKHN0cnVjdCBzbmRfdGltZXJfdHJlYWQzMikgewogCQkJCS5ldmVu
dCA9IHRyZWFkLT5ldmVudCwKIAkJCQkudHN0YW1wX3NlYyA9IHRyZWFkLT50c3RhbXBfc2VjLAot
CQkJCS50c3RhbXBfc2VjID0gdHJlYWQtPnRzdGFtcF9uc2VjLAorCQkJCS50c3RhbXBfbnNlYyA9
IHRyZWFkLT50c3RhbXBfbnNlYywKIAkJCQkudmFsID0gdHJlYWQtPnZhbCwKIAkJCX07CiAKLS0g
CjIuMjAuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
QWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHBz
Oi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
