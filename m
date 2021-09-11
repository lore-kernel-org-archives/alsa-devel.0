Return-Path: <SRS0=zpQA=OB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C640DC433EF
	for <alsa-devel@archiver.kernel.org>; Sat, 11 Sep 2021 06:16:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D49F611C0
	for <alsa-devel@archiver.kernel.org>; Sat, 11 Sep 2021 06:16:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1D49F611C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E5C8E166F;
	Sat, 11 Sep 2021 08:15:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E5C8E166F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631340974;
	bh=9eV0VWDOWBsCRSXRwR4s2eMb7cKz7NfX60KFiuIw6K8=;
	h=Date:To:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=Xeg6h2IEVCg2HU9+XxFMvzMogMqdlT6pKXxvFO/oUNH8Ca/m948ExXoM3gzh6GVdH
	 85WgNFldaPzdqRzolF0b+CwIrQ989H8g9fO9n476gLNMSdq5GLMZkn3w0xBOsOei6+
	 JCxL2ChRjmGO0XIqfLTr5nyBoWTT8MDUFDZjjbOs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 64F5AF80217;
	Sat, 11 Sep 2021 08:15:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 82FA4F80224; Sat, 11 Sep 2021 08:15:21 +0200 (CEST)
Received: from mail-40130.protonmail.ch (mail-40130.protonmail.ch
 [185.70.40.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B0962F801DB
 for <alsa-devel@alsa-project.org>; Sat, 11 Sep 2021 08:15:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B0962F801DB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com
 header.b="elVZpR59"
Date: Sat, 11 Sep 2021 06:15:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail; t=1631340915;
 bh=IxAUvyJJEkssGZzCJF39Kvw9q2KP4bohcGDcKrPNa70=;
 h=Date:To:From:Reply-To:Subject:From;
 b=elVZpR59aGl8ff7++sx3iR0fG1VLrHpNHz13Niv/CMft3Goxhm9vS86iP5/XhVE5W
 0oMmKhQDhRWaEEm5Qnx+bpdKGqnXugiClkl8s8ZqRIB/iouqhu7UBrsXM464jhYTp8
 GXzNxhFYfGmdckPoaPaGI0pYMc3mTGN9snComM1g=
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
From: Ryan McClue <re.mcclue@protonmail.com>
Subject: Raw ALSA PCM
Message-ID: <oNrRx9vj6M8ySDzjDxx5t0g_fQsBSGDZVqvfMqCyX8cbpwuwpggO6nTsbq260yw7aThOYAYLocvfDsSaaX57ejIQObcv6Wj91RB3aZbQpJY=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
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
Reply-To: Ryan McClue <re.mcclue@protonmail.com>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

SGVsbG8sCkknbSB0cnlpbmcgdG8gcGxheSBhIHNpbXBsZSBQQ00gYnVmZmVyIHdpdGggQUxTQSB3
aXRob3V0IGFzb3VuZGxpYi4KVGhpcyBoYXMgcHJvdmVuIHZlcnkgZGlmZmljdWx0IGFzIHRoZXJl
IGFyZSB2ZXJ5IGZldyByZXNvdXJjZXMgdGhhdCBzaG93IHVzYWdlIHdpdGhvdXQgYXNvdW5kbGli
LgpUaHJvdWdoIG15IGludmVzdGlnYXRpb25zIEkgd2FzIGZvcnR1bmF0ZSBlbm91Z2ggdG8gb2J0
YWluIGEgZ2lzdCB0aGF0IGF0dGVtcHRzIHRvIGRvIHRoaXM6IGh0dHBzOi8vZ2lzdC5naXRodWIu
Y29tL3Rha2Fzd2llL2Q4YTk1NTNjMjMwOTcxZDk3NGEzZGZjNzU5YjJmZjY3ClVuZm9ydHVuYXRl
bHkgdGhpcyBhcHBsaWNhdGlvbiBkb2VzIG5vdCB3b3JrLiBJIHRlc3RlZCB0aGUgYXBwbGljYXRp
b24gdXNpbmcgdGhlIHZpcnR1YWwgc25kLWR1bW15IGRyaXZlciBhbmQgdGhlIGFwcGxpY2F0aW9u
IHByb2R1Y2VkIHRoZSBzYW1lIGVycm9yLiBTbywgaXQgaXMgbW9zdCBsaWtlbHkgYW4gYXBwbGlj
YXRpb24gZXJyb3IsIHJhdGhlciB0aGFuIGFuIEludGVsIEhEQSBlcnJvci4KSSdtIGVtYWlsaW5n
IHRvIGFzayBmb3IgaGVscCBpbiBnZXR0aW5nIHRoZSBwcm9ncmFtIHRvIHdvcmsuIEknbSByZWFs
bHkgbG9zdCBhcyB0byB3aGF0IHNob3VsZCBiZSBjaGFuZ2VkIGluIHRoZSBjb2RlLiBJJ20gc3Vy
ZSB0aGF0IGEgd29ya2luZyBleGFtcGxlIG9mIHRoaXMgd2lsbCBiZSB1c2VmdWwgZm9yIG1hbnkg
cHJvZ3JhbW1lcnMuClRoYW5rIHlvdQ==
