Return-Path: <SRS0=vsGj=3L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8D2C2D0DB
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jan 2020 17:08:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3976F2465A
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jan 2020 17:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="mJavBdmF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3976F2465A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=friiks.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9CE6216C0;
	Wed, 22 Jan 2020 18:07:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9CE6216C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579712878;
	bh=ssaSitb/vewMFE9bZZWTbmgLSdeJrtbar+jIzw8ZkY0=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=mJavBdmFpdW/bo307q4A6wVJVHOG7tsPzf7LEDveB+4BWTCecYj3sTwbV+theY7S7
	 DxQd8/Nf/ndgl+D/FgbQHw5opY5uybkR/syBFX2R+Ofq6bXGNetmbQC6YIQ8ldlwHA
	 OMg9obwAeitvXAeLGPHfnHAOB9Lo11JfVFayhMiE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 178CFF80278;
	Wed, 22 Jan 2020 18:04:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0960FF8020C; Wed, 22 Jan 2020 17:55:46 +0100 (CET)
Received: from james.theweblords.de (james.theweblords.de [217.11.55.87])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A5C7CF800BA
 for <alsa-devel@alsa-project.org>; Wed, 22 Jan 2020 17:55:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A5C7CF800BA
Received: (qmail 20135 invoked by uid 210); 22 Jan 2020 16:55:41 -0000
X-Qmail-Scanner-Diagnostics: from wl-r7-73.rz.tu-ilmenau.de
 (petronios@theweblords.de@wl-r7-73.rz.tu-ilmenau.de) by james (envelope-from
 <pegro@friiks.de>, uid 201) with qmail-scanner-2.10st 
 (mhr: 1.0. spamassassin: 3.4.2. perlscan: 2.10st.  
 Clear:RC:1(141.24.110.73):. 
 Processed in 0.049813 secs); 22 Jan 2020 16:55:41 -0000
Received: from wl-r7-73.rz.tu-ilmenau.de (HELO its-dev2.tu-ilmenau.de)
 (petronios@theweblords.de@141.24.110.73)
 by james.theweblords.de with ESMTPA; 22 Jan 2020 16:55:40 -0000
From: =?UTF-8?q?Peter=20Gro=C3=9Fe?= <pegro@friiks.de>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Date: Wed, 22 Jan 2020 19:01:06 +0100
Message-Id: <20200122180106.9351-1-pegro@friiks.de>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 22 Jan 2020 18:04:36 +0100
Cc: alsa-devel@alsa-project.org, pegro@friiks.de
Subject: [alsa-devel] [PATCH] ALSA: hda - Add docking station support for
	Lenovo Thinkpad T420s
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

TGVub3ZvIFRoaW5rcGFkIFQ0MjBzIHVzZXMgdGhlIHNhbWUgY29kZWMgYXMgVDQyMCwgc28gYXBw
bHkgdGhlCnNhbWUgcXVpcmsgdG8gZW5hYmxlIGF1ZGlvIG91dHB1dCBvbiBhIGRvY2tpbmcgc3Rh
dGlvbi4KClNpZ25lZC1vZmYtYnk6IFBldGVyIEdyb8OfZSA8cGVncm9AZnJpaWtzLmRlPgotLS0K
IHNvdW5kL3BjaS9oZGEvcGF0Y2hfY29uZXhhbnQuYyB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEvc291bmQvcGNpL2hkYS9wYXRjaF9jb25leGFudC5j
IGIvc291bmQvcGNpL2hkYS9wYXRjaF9jb25leGFudC5jCmluZGV4IDkwYWEwZjQwMGE1Ny4uMWUy
MGU4NWU5YjQ2IDEwMDY0NAotLS0gYS9zb3VuZC9wY2kvaGRhL3BhdGNoX2NvbmV4YW50LmMKKysr
IGIvc291bmQvcGNpL2hkYS9wYXRjaF9jb25leGFudC5jCkBAIC05MjIsNiArOTIyLDcgQEAgc3Rh
dGljIGNvbnN0IHN0cnVjdCBzbmRfcGNpX3F1aXJrIGN4dDUwNjZfZml4dXBzW10gPSB7CiAJU05E
X1BDSV9RVUlSSygweDE3YWEsIDB4MjE1ZiwgIkxlbm92byBUNTEwIiwgQ1hUX1BJTkNGR19MRU5P
Vk9fVFA0MTApLAogCVNORF9QQ0lfUVVJUksoMHgxN2FhLCAweDIxY2UsICJMZW5vdm8gVDQyMCIs
IENYVF9QSU5DRkdfTEVOT1ZPX1RQNDEwKSwKIAlTTkRfUENJX1FVSVJLKDB4MTdhYSwgMHgyMWNm
LCAiTGVub3ZvIFQ1MjAiLCBDWFRfUElOQ0ZHX0xFTk9WT19UUDQxMCksCisJU05EX1BDSV9RVUlS
SygweDE3YWEsIDB4MjFkMiwgIkxlbm92byBUNDIwcyIsIENYVF9QSU5DRkdfTEVOT1ZPX1RQNDEw
KSwKIAlTTkRfUENJX1FVSVJLKDB4MTdhYSwgMHgyMWRhLCAiTGVub3ZvIFgyMjAiLCBDWFRfUElO
Q0ZHX0xFTk9WT19UUDQxMCksCiAJU05EX1BDSV9RVUlSSygweDE3YWEsIDB4MjFkYiwgIkxlbm92
byBYMjIwLXRhYmxldCIsIENYVF9QSU5DRkdfTEVOT1ZPX1RQNDEwKSwKIAlTTkRfUENJX1FVSVJL
KDB4MTdhYSwgMHgzOGFmLCAiTGVub3ZvIElkZWFQYWQgWjU2MCIsIENYVF9GSVhVUF9NVVRFX0xF
RF9FQVBEKSwKLS0gCjIuMjQuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2pl
Y3Qub3JnCmh0dHBzOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8v
YWxzYS1kZXZlbAo=
