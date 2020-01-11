Return-Path: <SRS0=uq2S=3A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F42C33CA7
	for <alsa-devel@archiver.kernel.org>; Sat, 11 Jan 2020 21:49:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81D6620866
	for <alsa-devel@archiver.kernel.org>; Sat, 11 Jan 2020 21:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="K6meq5CC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81D6620866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D3A0416A8;
	Sat, 11 Jan 2020 22:48:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D3A0416A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578779377;
	bh=mPuhvqD1etjCDyO9IujABI6Kc/teKIIfo9CGb8usyVU=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K6meq5CCf4UXHnjJiorQWd6mJaZ8NQowvJgn8eelRVid87gBmzv03DKEOXmLrlDhu
	 VrwKNdoTVRNw9M9kXI6trzjche/M8842xE0oYt2ZRfPKpQaqPMtBnzD6wPf3QIWD8z
	 /Se7MdI+ym2uOGr8lBIykiiMq1hC+8yBobrKG6Eg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9D2FDF80247;
	Sat, 11 Jan 2020 22:47:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 50BB2F801F5; Sat, 11 Jan 2020 22:47:52 +0100 (CET)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 187CCF80172
 for <alsa-devel@alsa-project.org>; Sat, 11 Jan 2020 22:47:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 187CCF80172
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Jan 2020 13:47:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,422,1571727600"; d="scan'208";a="247358431"
Received: from kfoley1-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.254.191.191])
 by fmsmga004.fm.intel.com with ESMTP; 11 Jan 2020 13:47:41 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Sat, 11 Jan 2020 15:47:35 -0600
Message-Id: <20200111214736.3002-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200111214736.3002-1-pierre-louis.bossart@linux.intel.com>
References: <20200111214736.3002-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Cc: tiwai@suse.de, broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] [PATCH 1/2] ALSA: HDA: patch_realtek: fix empty macro
	usage in if block
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

R0NDIHJlcG9ydHMgdGhlIGZvbGxvd2luZyB3YXJuaW5nIHdpdGggVz0xCgpzb3VuZC9wY2kvaGRh
L3BhdGNoX3JlYWx0ZWsuYzogSW4gZnVuY3Rpb24g4oCYYWxjMjY5X3N1c3BlbmTigJk6CnNvdW5k
L3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jOjM2MTY6Mjk6IHdhcm5pbmc6IHN1Z2dlc3QgYnJhY2Vz
IGFyb3VuZAplbXB0eSBib2R5IGluIGFuIOKAmGlm4oCZIHN0YXRlbWVudCBbLVdlbXB0eS1ib2R5
XQogMzYxNiB8ICAgYWxjNTUwNV9kc3Bfc3VzcGVuZChjb2RlYyk7CiAgICAgIHwgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIF4KCnNvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jOiBJbiBm
dW5jdGlvbiDigJhhbGMyNjlfcmVzdW1l4oCZOgpzb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsu
YzozNjUxOjI4OiB3YXJuaW5nOiBzdWdnZXN0IGJyYWNlcyBhcm91bmQgZW1wdHkgYm9keSBpbiBh
biDigJhpZuKAmSBzdGF0ZW1lbnQgWy1XZW1wdHktYm9keV0KIDM2NTEgfCAgIGFsYzU1MDVfZHNw
X3Jlc3VtZShjb2RlYyk7CiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgoKVGhp
cyBpcyBhIGNsYXNzaWMgbWFjcm8gcHJvYmxlbSBhbmQgY2FuIGluZGVlZCBsZWFkIHRvIGJhZCBw
cm9ncmFtCmZsb3dzLgoKRml4IGJ5IHVzaW5nIHRoZSB1c3VhbCAiZG8geyB9IHdoaWxlICgwKSIg
cGF0dGVybgoKU2lnbmVkLW9mZi1ieTogUGllcnJlLUxvdWlzIEJvc3NhcnQgPHBpZXJyZS1sb3Vp
cy5ib3NzYXJ0QGxpbnV4LmludGVsLmNvbT4KLS0tCiBzb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0
ZWsuYyB8IDQgKystLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9zb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYyBiL3NvdW5k
L3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jCmluZGV4IDczNDA3YjI1YTc3Ny4uZDdiOWJlZGZmMzNj
IDEwMDY0NAotLS0gYS9zb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYworKysgYi9zb3VuZC9w
Y2kvaGRhL3BhdGNoX3JlYWx0ZWsuYwpAQCAtMzYwMCw4ICszNjAwLDggQEAgc3RhdGljIHZvaWQg
YWxjNTUwNV9kc3BfaW5pdChzdHJ1Y3QgaGRhX2NvZGVjICpjb2RlYykKIH0KIAogI2lmZGVmIEhB
TFRfUkVBTFRFS19BTEM1NTA1Ci0jZGVmaW5lIGFsYzU1MDVfZHNwX3N1c3BlbmQoY29kZWMpCS8q
IE5PUCAqLwotI2RlZmluZSBhbGM1NTA1X2RzcF9yZXN1bWUoY29kZWMpCS8qIE5PUCAqLworI2Rl
ZmluZSBhbGM1NTA1X2RzcF9zdXNwZW5kKGNvZGVjKQlkbyB7IH0gd2hpbGUgKDApIC8qIE5PUCAq
LworI2RlZmluZSBhbGM1NTA1X2RzcF9yZXN1bWUoY29kZWMpCWRvIHsgfSB3aGlsZSAoMCkgLyog
Tk9QICovCiAjZWxzZQogI2RlZmluZSBhbGM1NTA1X2RzcF9zdXNwZW5kKGNvZGVjKQlhbGM1NTA1
X2RzcF9oYWx0KGNvZGVjKQogI2RlZmluZSBhbGM1NTA1X2RzcF9yZXN1bWUoY29kZWMpCWFsYzU1
MDVfZHNwX2JhY2tfZnJvbV9oYWx0KGNvZGVjKQotLSAKMi4yMC4xCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApB
bHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cHM6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
