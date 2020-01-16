Return-Path: <SRS0=iD9L=3F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A05C33CAF
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jan 2020 17:36:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB8B8246CA
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jan 2020 17:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="tJELIWOd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2uJWTau"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB8B8246CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 084F017FE;
	Thu, 16 Jan 2020 18:36:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 084F017FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579196210;
	bh=G+wa/pAjbn6WgqVwlsWjAQE3wfuzMEsc+N89rAKAL3s=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tJELIWOdqIpgptZcBjhw2jI/MVmpJnxQNGdEbmTVPEivaM4Hdj9ZFd0tgcVz0WD5t
	 bpbf1CG1D8vZrVwqGiSJzhsv/NVN4QguTqXtCHq/cZKHMY4P410gd7LchdwzP+s7yQ
	 FtxVHkH8BV4lXlMsqhYkl+SBfYHjgUt5ol8c7UAw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5C5E1F801F2;
	Thu, 16 Jan 2020 18:35:02 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5DE0AF800B9; Thu, 16 Jan 2020 18:34:58 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BD330F800B9
 for <alsa-devel@alsa-project.org>; Thu, 16 Jan 2020 18:34:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BD330F800B9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="S2uJWTau"
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9C3E3246A1;
 Thu, 16 Jan 2020 17:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1579196089;
 bh=Vs31waamsWD7SzIS5H+rhqQTbCNe4meiHZm1NTT59go=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=S2uJWTaurT3WeFUk1cXpm8Fwk4rkNyTHsaf2rYvKk83XOaBkCmNdT2doIh5DSn53n
 OAzFLwv1GDDxDoWZGkSpStmUkvnuyX5sPKFdppE3VQ7BUc4qJjrVEGocrEWYcTpTJg
 uEESO6eSE/0F0CZJreap8Ua136z24jSaf5RvOkNU=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Date: Thu, 16 Jan 2020 12:30:37 -0500
Message-Id: <20200116173445.21385-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116173445.21385-1-sashal@kernel.org>
References: <20200116173445.21385-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
 alsa-devel@alsa-project.org, Anders Roxell <anders.roxell@linaro.org>
Subject: [alsa-devel] [PATCH AUTOSEL 4.9 003/251] ALSA: hda: fix unused
	variable warning
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

RnJvbTogQW5kZXJzIFJveGVsbCA8YW5kZXJzLnJveGVsbEBsaW5hcm8ub3JnPgoKWyBVcHN0cmVh
bSBjb21taXQgNWIwMzAwNmQ1YzU4ZGRkMzFjYWY1NDJlZWY0ZDAyNjliY2YyNjViMyBdCgpXaGVu
IENPTkZJR19YODY9biBmdW5jdGlvbiBhenhfc25vb3AgZG9lc24ndCB1c2UgdGhlIHZhcmlhYmxl
IGNoaXAgaXQKb25seSByZXR1cm5zIHRydWUuCgpzb3VuZC9wY2kvaGRhL2hkYV9pbnRlbC5jOiBJ
biBmdW5jdGlvbiDigJhkbWFfYWxsb2NfcGFnZXPigJk6CnNvdW5kL3BjaS9oZGEvaGRhX2ludGVs
LmM6MjAwMjoxNDogd2FybmluZzogdW51c2VkIHZhcmlhYmxlIOKAmGNoaXDigJkgWy1XdW51c2Vk
LXZhcmlhYmxlXQogIHN0cnVjdCBhenggKmNoaXAgPSBidXNfdG9fYXp4KGJ1cyk7CiAgICAgICAg
ICAgICAgXn5+fgoKQ3JlYXRlIGEgaW5saW5lIGZ1bmN0aW9uIG9mIGF6eF9zbm9vcC4KCkZpeGVz
OiBhNDFkMTIyNDQ5YmUgKCJBTFNBOiBoZGEgLSBFbWJlZCBidXMgaW50byBjb250cm9sbGVyIG9i
amVjdCIpClNpZ25lZC1vZmYtYnk6IEFuZGVycyBSb3hlbGwgPGFuZGVycy5yb3hlbGxAbGluYXJv
Lm9yZz4KU2lnbmVkLW9mZi1ieTogVGFrYXNoaSBJd2FpIDx0aXdhaUBzdXNlLmRlPgpTaWduZWQt
b2ZmLWJ5OiBTYXNoYSBMZXZpbiA8c2FzaGFsQGtlcm5lbC5vcmc+Ci0tLQogc291bmQvcGNpL2hk
YS9oZGFfY29udHJvbGxlci5oIHwgOSArKysrLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2Vy
dGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc291bmQvcGNpL2hkYS9oZGFf
Y29udHJvbGxlci5oIGIvc291bmQvcGNpL2hkYS9oZGFfY29udHJvbGxlci5oCmluZGV4IGI4M2Zl
ZWNmMWU0MC4uOGY5Mzg2OTk4MjcwIDEwMDY0NAotLS0gYS9zb3VuZC9wY2kvaGRhL2hkYV9jb250
cm9sbGVyLmgKKysrIGIvc291bmQvcGNpL2hkYS9oZGFfY29udHJvbGxlci5oCkBAIC0xNzEsMTEg
KzE3MSwxMCBAQCBzdHJ1Y3QgYXp4IHsKICNkZWZpbmUgYXp4X2J1cyhjaGlwKQkoJihjaGlwKS0+
YnVzLmNvcmUpCiAjZGVmaW5lIGJ1c190b19hengoX2J1cykJY29udGFpbmVyX29mKF9idXMsIHN0
cnVjdCBhengsIGJ1cy5jb3JlKQogCi0jaWZkZWYgQ09ORklHX1g4NgotI2RlZmluZSBhenhfc25v
b3AoY2hpcCkJCSgoY2hpcCktPnNub29wKQotI2Vsc2UKLSNkZWZpbmUgYXp4X3Nub29wKGNoaXAp
CQl0cnVlCi0jZW5kaWYKK3N0YXRpYyBpbmxpbmUgYm9vbCBhenhfc25vb3Aoc3RydWN0IGF6eCAq
Y2hpcCkKK3sKKwlyZXR1cm4gIUlTX0VOQUJMRUQoQ09ORklHX1g4NikgfHwgY2hpcC0+c25vb3A7
Cit9CiAKIC8qCiAgKiBtYWNyb3MgZm9yIGVhc3kgdXNlCi0tIAoyLjIwLjEKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBs
aXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwczovL21haWxtYW4uYWxzYS1wcm9q
ZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
