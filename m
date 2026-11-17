Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C97E606A31E
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Nov 2026 12:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=tzjLPzND;
	dkim=permerror header.d=proton.me header.i=@proton.me header.a=rsa-sha1 header.s=protonmail2 header.b=M7ZbNvBd
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 49F11601ED;
	Mon, 23 Nov 2026 13:03:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 49F11601ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1795435431;
	bh=XuCg6H/7E/nM/4xCI4Hz0OaAx5Vb5VyBxW+F1f/E3ac=;
	h=Date:To:From:Cc:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=tzjLPzNDFXLY/M2GwEhENTPuW2B9Ob5ISl/1DaC/wX25vvW1TtbtFIZtozr1j+bvo
	 eHjOJ7cxt/HbLoqiFlA4/idIiUB7wj/vvfHKZ3HmCIG4ZqgIJau72Rykq8zu1+AXXT
	 ZDjUKAMQujMovQMeFsAS6ya33ley0CxBOZW4roRg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EF838F8067B; Mon, 23 Nov 2026 13:02:33 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 650E5F80690;
	Mon, 23 Nov 2026 13:02:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C36CAF805A8; Tue, 17 Nov 2026 05:30:57 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=79.135.106.104
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1794889852;
	b=J1O6vWU24nlrFcQLKvZHndoW4yrrG6b+YfszYhzL7yoKqK57JJEMMf6JrBYvnsgYZwcB
	 PN4VZLmcnzVF6bGmegGzbpfYVWLCY6tj85Dif3uoZAgrliGg2+kcaKgF8d9aOeU9+tlWB
	 Os/THPXnxcPA7ErlzIKvsOGmzdbTVublcZWfIZt7vkTnLulqRtJcDt7iJqJ6x92XLh7l4
	 hLXh6zvIyN4xEkuMpiicKVn4cL9N6lAMt8grsMX5KuOrIyFWohwokVJhwfd0VP73/QRZk
	 4uZG04wHnvjE9bBNmKbLbaDINHEI/vN1xeDTWJoB2pYxJkp+zEqxirlVeqEtYYwU+Xg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794889852;
	h=DKIM-Signature:Date:To:From:Subject:Message-ID:MIME-Version;
	bh=NvAT971fcE1OWgVJ4S4eWXbNRGhWRexmpEQZY6ElUeU=;
	b=KevC4JewGF9WgoAH69AotOaAFplG4HuD8DwedKa5lvLzdOF8b5CMCYq7CyXQXaPwlLhU
	 0Whvx5lHa3xEGWQl64S0AMfk33uHCpfwTkllx2fa0Lee7hhcOsdoeT+G+jhoiICiY0X7E
	 33rUDmT0N0yTWdg0qDDnblGGAeYc2jSLE+kNaQ5o8dVYPAV6hR9SK0i0dKbBHsT5eSRIl
	 8AZ+OfvA07MO0nCBIXo5YsuFLb3J6skEib0V7tDlw3QtHnDh5rDrOvraL8PnUCURMK9x1
	 WGjtqcjfnBW6fOVPqQ2PPk2UKKau70UgJnOfIp1MrvrqU+ysXX074229z+rVXpIQ41g==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256
 header.s=protonmail2 header.b=M7ZbNvBd;
	arc=none smtp.remote-ip=79.135.106.104
Received: from mail-106104.protonmail.ch (mail-106104.protonmail.ch
 [79.135.106.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id AC50BF8024C
	for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2026 05:30:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AC50BF8024C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256
 header.s=protonmail2 header.b=M7ZbNvBd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1794889850; x=1795149050;
	bh=NvAT971fcE1OWgVJ4S4eWXbNRGhWRexmpEQZY6ElUeU=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=M7ZbNvBdgVejCkt5EH3CmGX/Xmg62HNRatQbqhxcCoXEwWfzmet07gscoV4960T8Q
	 D6oq3ML1zWL2SgxVceW23puCgFksC7dXPmeuLBU6seCfJdzyYPO12dKwvA9X7aQ4gq
	 yFaHkRO1jXw2U85DpJAVOQuKHtuXOaIcqWOzVVN0gYZTQXQOBkPszutf9KUWzw/YBP
	 ss5I9rn4nKhqcRDeSjxiwXHmAiu+OgvwrK77gqilikexKn6JtiOwKmpV/iH61WCcTZ
	 luvjortliKx1iPbo3j4KH46ZSYNQYMG3XMh//z2SA13b9ADqAOZetXf2O+srszf8fq
	 Z4hNmCM0Nlucw==
Date: Tue, 17 Nov 2026 04:30:44 +0000
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
From: ptrnt@proton.me
Cc: "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
 "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>
Subject: [PATCH] ALSA: hda/realtek: Add quirk for HP ProBook 455 G8 mute LED
Message-ID: 
 <7MuWwdxL8P9sa_U2G1ztBAaV6q-vlnX-VE6W_awGFtxOQWXQ12kIoRUqrnlwkQH_gE1Vy6Fg1jutNWO9MuVteVwQq6vf4DKZdVOfa3gB0TQ=@proton.me>
Feedback-ID: 234976267:user:proton
X-Pm-Message-ID: 2dec1d1ca2d7870c36ca516eafc85c81cbc2ac67
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MailFrom: ptrnt@proton.me
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: XZSCJNJXJEBMG5AW5GKRIQJF36XEPAGS
X-Message-ID-Hash: XZSCJNJXJEBMG5AW5GKRIQJF36XEPAGS
X-Mailman-Approved-At: Mon, 23 Nov 2026 12:02:14 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=utf-8
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XZSCJNJXJEBMG5AW5GKRIQJF36XEPAGS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

VGhlIEY1L0Y4IG11dGUtTEVEIGtleWNhcCBpbmRpY2F0b3JzIGRvIG5vdCBsaWdodCB1cCBvbiB0
aGlzIG1vZGVsCihTU0lEIDEwM2M6OGE5MSkgYmVjYXVzZSBpdCBpcyBtaXNzaW5nIGZyb20gdGhl
CkFMQzIzNl9GSVhVUF9IUF9NVVRFX0xFRF9NSUNNVVRFX1ZSRUYgcXVpcmsgdGFibGUsIGV2ZW4g
dGhvdWdoCnNpYmxpbmcgUHJvQm9vay9FbGl0ZUJvb2sgbW9kZWxzIChHNiB0aHJvdWdoIEcxMSkg
YWxyZWFkeSB1c2UgaXQuCgpTaWduZWQtb2ZmLWJ5OiBSb21hbiBQb3BvdiA8cHRybnRAcHJvdG9u
Lm1lPgotLS0Kc291bmQvaGRhL2NvZGVjcy9yZWFsdGVrL2FsYzI2OS5jIHwgMSArCjEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL3NvdW5kL2hkYS9jb2RlY3MvcmVh
bHRlay9hbGMyNjkuYyBiL3NvdW5kL2hkYS9jb2RlY3MvcmVhbHRlay9hbGMyNjkuYwppbmRleCBh
ZTdhNDYyMzQuLmNlY2ViZjkyZiAxMDA2NDQKLS0tIGEvc291bmQvaGRhL2NvZGVjcy9yZWFsdGVr
L2FsYzI2OS5jCisrKyBiL3NvdW5kL2hkYS9jb2RlY3MvcmVhbHRlay9hbGMyNjkuYwpAQCAtNzg5
Niw2ICs3ODk2LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBoZGFfcXVpcmsgYWxjMjY5X2ZpeHVw
X3RibFtdID0gewpTTkRfUENJX1FVSVJLKDB4MTAzYywgMHg4YTc2LCAiSFAgUHJvQm9vayA0NDAg
RzggTm90ZWJvb2sgUEMiLCBBTEMyMzZfRklYVVBfSFBfR1BJT19MRUQpLApTTkRfUENJX1FVSVJL
KDB4MTAzYywgMHg4YTc3LCAiSFAgUHJvQm9vayA0NTAgRzggTm90ZWJvb2sgUEMiLCBBTEMyMzZf
RklYVVBfSFBfR1BJT19MRUQpLApTTkRfUENJX1FVSVJLKDB4MTAzYywgMHg4YTc4LCAiSFAgRGV2
IE9uZSIsIEFMQzI4NV9GSVhVUF9IUF9MSU1JVF9JTlRfTUlDX0JPT1NUKSwKKyBTTkRfUENJX1FV
SVJLKDB4MTAzYywgMHg4YTkxLCAiSFAgUHJvQm9vayA0NTUgRzgiLCBBTEMyMzZfRklYVVBfSFBf
TVVURV9MRURfTUlDTVVURV9WUkVGKSwKU05EX1BDSV9RVUlSSygweDEwM2MsIDB4OGFhMCwgIkhQ
IFByb0Jvb2sgNDQwIEc5IChNQiA4QTlFKSIsIEFMQzIzNl9GSVhVUF9IUF9HUElPX0xFRCksClNO
RF9QQ0lfUVVJUksoMHgxMDNjLCAweDhhYTMsICJIUCBQcm9Cb29rIDQ1MCBHOSAoTUIgOEFBMSki
LCBBTEMyMzZfRklYVVBfSFBfR1BJT19MRUQpLApTTkRfUENJX1FVSVJLKDB4MTAzYywgMHg4YWE4
LCAiSFAgRWxpdGVCb29rIDY0MCBHOSAoTUIgOEFBNikiLCBBTEMyMzZfRklYVVBfSFBfR1BJT19M
RUQpLAotLSAyLjU0LjA=
