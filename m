Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5D8606A88D
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Nov 2026 14:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=J6pYBAoi
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E4F08601FF;
	Wed, 11 Nov 2026 15:32:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E4F08601FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794407577;
	bh=PZJNEk7IavCVaVNp5f89Yc3dcCBfLfgmr7eMexZTJo0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=J6pYBAoirxjctD4Kh7mWZaal1iw1xX9z9/YOI9Ng3h/qDDoD0agw5VyjWqv2JVERk
	 cE6NPXBOjIhU88o5ZjSV82ZZMI5WE/ddf/CQ7RjJdx1UEBmH5RmCLnCygAYTxw7EXL
	 +Qiuc/+P6i3O7WqT4vNk+pSkqiACXbV/BKLpzFmk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C08EAF805F9; Wed, 11 Nov 2026 15:32:23 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2A2F3F805FF;
	Wed, 11 Nov 2026 15:32:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3294EF80537; Wed, 11 Nov 2026 15:32:16 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1794407534;
	b=g/xIbE45ESgfqCoCktj9l5Y49Dh/uRe/DPdHFC/CUm0YVxYbtqU90Ekdozya1/56b++Y
	 hNDXVKF0CpLPaEg7hZof4qTpBw1r6194Pk48Pa77UJugdO3u9FreEE9fNRRPDzBUs1tJe
	 gzfH4nxlaHZ8ThcjDzZ1OfyE3fdIXpTVLjfUevI3Su5ZX3OhDXKDvvxTREwk0V7SkLQyf
	 QXimpkcM9caATTVUw3SxL6KxQQR7fGQTyYE5T09iHOOSlcdIXz7Dv4K7LMmlSjZCeEMZT
	 EfD87DPh5vPabXTYXVvGTQ2EZuetXL1HceAgLhAuclsiF3wmsScGhR3dSdN6WWNnyTA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794407534;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=PZJNEk7IavCVaVNp5f89Yc3dcCBfLfgmr7eMexZTJo0=;
	b=YHN7cMRN0PB+ObLTfj3EgLgdpL0AuZjzgT5ozz0YN1x8CiRecud1Ks1Mc/ELg1we3pmb
	 Gi1GVjMlAxoBqQyrlP2pypvHJfgWOu0UvX0TD2CbDFdNLmZ4MbwWtm2PdCOwcCLcJNqI9
	 V0gx8cbSC3Q1r8Jg8kUIF1UqnbNKE0wdpK1YxuwgnQ1nv09AEF6SEd5n8F8Tat94/Y8eQ
	 r5ez2MSpLBRjDwfWzoYTq+q1YHP0LgGH5RE39aJ/Npc7X0dO+kNLg68u3J+rSuNufSofs
	 ujOZW3l3bbTa2cmB/NeeBoENFsneEh08I0X2e/nWJ7f2zEPe3iZ04zMUeASPSug4Usw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 95198F8014C
	for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2026 15:32:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 95198F8014C
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18e70424dacfcd00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-lib/pr/541@alsa-project.org>
References: <alsa-project/alsa-lib/pr/541@alsa-project.org>
Subject: pcm: mmap_emul: report own appl_ptr in status
Date: Wed, 11 Nov 2026 15:32:16 +0100 (CET)
Message-ID-Hash: VMIBQ3TWRJLK5KYKW6S6N5IQU6LLPKDH
X-Message-ID-Hash: VMIBQ3TWRJLK5KYKW6S6N5IQU6LLPKDH
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VMIBQ3TWRJLK5KYKW6S6N5IQU6LLPKDH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

YWxzYS1wcm9qZWN0L2Fsc2EtbGliIHB1bGwgcmVxdWVzdCAjNTQxIHdhcyBvcGVuZWQgZnJvbSBh
bmR5LWJyaWdodHNpZ246CgpJbiBtbWFwX2VtdWwgbW9kZSB0aGUgbW1hcF9lbXVsIFBDTSBrZWVw
cyBpdHMgb3duIGFwcGxfcHRyIGFwYXJ0IGZyb20gdGhlIHNsYXZlLiBBIHBsYXliYWNrIGNvbW1p
dCBmb3J3YXJkcyBpdCBhbmQgdGhlbiB3cml0ZXMgdGhlIG5ldyBmcmFtZXMgdG8gdGhlIHNsYXZl
IHdpdGggc3luY19zbGF2ZV93cml0ZSgpLiBUaGUgY29tbWl0IHJldHVybnMgdGhlIGZ1bGwgc2l6
ZSBldmVuIHdoZW4gdGhhdCB3cml0ZSBmYWlscyBvciBjb21lcyB1cCBzaG9ydCwgZm9yIGV4YW1w
bGUgYWZ0ZXIgYW4geHJ1bi4KClRoZSBzdGF0dXMgb3Agd2FzIHNuZF9wY21fZ2VuZXJpY19zdGF0
dXMoKSwgd2hpY2ggcmV0dXJucyB0aGUgc2xhdmUgYXBwbF9wdHIuIFdoZW4gYSBwbHVnaW4gc3Vj
aCBhcyBzb2Z0dm9sIHNpdHMgYWJvdmUgbW1hcF9lbXVsLCBpdHMgYXBwbF9wdHIgZm9sbG93cyB0
aGUgbW1hcF9lbXVsIG9uZS4gQWZ0ZXIgYSBzaG9ydCB3cml0ZSB0aGUgdHdvIGRpZmZlciBhbmQg
c25kX3BjbV9wbHVnaW5fc3RhdHVzKCkgYWJvcnRzIG9uCgogIHBjbV9wbHVnaW4uYzogc25kX3Bj
bV9wbHVnaW5fc3RhdHVzOiBBc3NlcnRpb24KICBgc3RhdHVzLT5hcHBsX3B0ciA9PSAqcGNtLT5h
cHBsLnB0cicgZmFpbGVkLgoKVGhpcyBoYXBwZW5zIHdpdGggYW55IGh3IFBDTSB3aG9zZSBkcml2
ZXIgbGFja3MgbW1hcCBzdXBwb3J0IHdoZW4gaXQgaXMgdXNlZCB0aHJvdWdoIHBsdWcgd2l0aCBz
b2Z0dm9sIGFib3ZlIGl0LCBvbiB0aGUgZmlyc3QgeHJ1biBmb2xsb3dlZCBieSBzbmRfcGNtX3N0
YXR1cygpLiBXZSBoaXQgaXQgb24gYW4gTEcgU29DIHdob3NlIEFMU0EgZHJpdmVyIG9ubHkgb2Zm
ZXJzIFJXIGFjY2Vzcywgd2hlcmUgbXB2IGFib3J0cyBvbiB0aGUgZmlyc3QgeHJ1bi4KCkl0IGFs
c28gcmVwcm9kdWNlcyB3aXRob3V0IGhhcmR3YXJlLCB3aXRoIGEgbGluZWFyIFBDTSBvdmVyIG1t
YXBfZW11bCBvdmVyIGFuIGlvcGx1ZyBzbGF2ZSB0aGF0IG9mZmVycyBvbmx5IFJXX0lOVEVSTEVB
VkVEIGFjY2VzcyBhbmQgZmFpbHMgb25lIHRyYW5zZmVyLiBXaGV0aGVyIHRoYXQgdHJhbnNmZXIg
cmV0dXJucyAtRVBJUEUgKHN0YXRlIFhSVU4pIG9yIC1FSU8sIHRoZSBuZXh0IHNuZF9wY21fc3Rh
dHVzKCkgb24gdGhlIGxpbmVhciBQQ00gYWJvcnRzLgoKQWRkIGEgc3RhdHVzIG9wIHRoYXQgcmVw
b3J0cyB0aGUgbW1hcF9lbXVsIGFwcGxfcHRyIGluIGVtdWxhdGlvbiBtb2RlIGZvciBwbGF5YmFj
ay4gSXQgdGFrZXMgdGhlIGZyYW1lcyBub3QgeWV0IHdyaXR0ZW4gdG8gdGhlIHNsYXZlIG91dCBv
ZiBhdmFpbCwgYW5kIGFkZHMgdGhlbSB0byBkZWxheSBvbmx5IHdoaWxlIHRoZSBzdHJlYW0gaXMg
cnVubmluZyBvciBkcmFpbmluZywgYmVjYXVzZSB0aGUga2VybmVsIHN0YXR1cyByZXBvcnRzIG5v
IGRlbGF5IGluIG90aGVyIHN0YXRlcy4gQSBjb3VudCBhYm92ZSB0aGUgYnVmZmVyIHNpemUgbWVh
bnMgdGhlIHR3byBhcHBsX3B0cnMgYXJlIG91dCBvZiBzeW5jLCBhcyBhZnRlciBzbmRfcGNtX3Jl
c2V0KCkgb24gYSBydW5uaW5nIHN0cmVhbSwgYW5kIGlzIGlnbm9yZWQuIE5vbi1lbXVsYXRlZCBh
bmQgY2FwdHVyZSBzdHJlYW1zIGFyZSB1bmNoYW5nZWQuCgpUZXN0ZWQgd2l0aCBhIGhvc3QgcmVw
cm9kdWNlcjogbGluZWFyIOKGkiBtbWFwX2VtdWwg4oaSIGFuIFJXLW9ubHkgaW9wbHVnIHNsYXZl
IHdob3NlIHdyaXRlIGZhaWxzLiBNYXN0ZXIgYWJvcnRzIGluIDMgb2YgNSBzY2VuYXJpb3MgYW5k
IHBhc3NlcyBhbGwgNSB3aXRoIHRoaXMgcGF0Y2guIE9uIHRoZSBhZmZlY3RlZCBkZXZpY2UgKGEg
ZHJpdmVyIHdpdGhvdXQgbW1hcCBzdXBwb3J0LCB1c2VkIHRocm91Z2ggcGx1ZyB3aXRoIHNvZnR2
b2wpLCBhcGxheSBhc3NlcnRlZCBpbiA1IG9mIDYgcnVucyBiZWZvcmUgdGhlIHBhdGNoIGFuZCBp
biAwIG9mIDIwIGFmdGVyLgoKUmVxdWVzdCBVUkwgICA6IGh0dHBzOi8vZ2l0aHViLmNvbS9hbHNh
LXByb2plY3QvYWxzYS1saWIvcHVsbC81NDEKUGF0Y2ggVVJMICAgICA6IGh0dHBzOi8vZ2l0aHVi
LmNvbS9hbHNhLXByb2plY3QvYWxzYS1saWIvcHVsbC81NDEucGF0Y2gKUmVwb3NpdG9yeSBVUkw6
IGh0dHBzOi8vZ2l0aHViLmNvbS9hbHNhLXByb2plY3QvYWxzYS1saWIK
