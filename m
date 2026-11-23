Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71926606A321
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Nov 2026 18:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=DvpUovzo
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 50FE86020E;
	Mon, 23 Nov 2026 19:42:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 50FE86020E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1795459386;
	bh=JfcG6X5fIMYklXI6iZB2/DECq78q8gGbiX0ScF/MvGA=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=DvpUovzojhqVZE0vJn20QA+v5Xs2ygreTcdCO3RZoseYmbIAlMSmmKee5nH+osYEm
	 PKqelmMUAFj0jQLpODkAqbyqUNb91bPec3FdICBpQitlnBBQJp7M3BBK2hjBFWP1RP
	 5jFmmASJe8M/efy04IoW34gBlcREOveyeueuCtbM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5D717F805FB; Mon, 23 Nov 2026 19:42:33 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7C291F80600;
	Mon, 23 Nov 2026 19:42:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F4038F804CF; Mon, 23 Nov 2026 19:42:25 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1795459344;
	b=eRWd4EZcmEnEQOQFLk1zz+lLKGQ4tO0j8oOAFM1EvoWlc1c2ZJQetKt4tKsdMp/+8ZLC
	 GzRd70mnyzTHq6fD9ZziPNTGNFmgDAavrxGIw5rVf4vFJK+ARgQffP6w7UCWFVKg3Lws/
	 xV2Cl9CYyGdHETvBRLXYCcPSauJRqtUv7xlENaq2E53C+1betr1F6xQVk/Bl4JfeRaDG/
	 e2pgDaJYMpyFL437+q1xrHoIEPAZFtI3CyxPiDeTEEdS3NH6qB/fwz2UDmiLhwbaJnFGP
	 LrC5ThchXT8se6ZtSEwUxKXYbVK777wkKWS1o0O+4L7oZcY6I5HuGwt+50/9UDRokfQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1795459344;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=JfcG6X5fIMYklXI6iZB2/DECq78q8gGbiX0ScF/MvGA=;
	b=mwGksFhXWiHU7D2objyVnM1t+/sSMXA5Gb/AEyWMvVdDC7MAWTHTMlyzpvNN1ZTjmKX4
	 K9Tct+0FZs28TMKpwcHailHYTKPTPFijyNYt3ZEPVu2MMsaugoNE7iXB0IWLWFv53g/GM
	 9NvsXjWK5DVtdsuTw4mjlx+WoNKzNY629Ndw6n3QloO4TFl5HFijS/ErRvsVpiOb+k2DU
	 XweXoMh74qYe06VKL+1/wY9SNZs2fPJZuWBnTpZX8khh6QZqm0G7YC/teV0T8XzNPC0TD
	 jU1dfT0pbWO27uQYKQ2wKMloxXpi/ffBakLxnDulw24VYouWlmx7rRfl+UoWb5ON6ig==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 49CDCF80495
	for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2026 19:42:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 49CDCF80495
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18eac0c25a84ba00-webhooks-bot@alsa-project.org>
In-Reply-To: <18eac0c25a58d500-webhooks-bot@alsa-project.org>
References: <18eac0c25a58d500-webhooks-bot@alsa-project.org>
Subject: Teufel CAGE PRO (2cc2:0033): HiFi profile rejected when dongle
 exposes only one playback PCM
Date: Mon, 23 Nov 2026 19:42:25 +0100 (CET)
Message-ID-Hash: KKCQXCA7HS3KY7U3RUA6T4RZSUIQMARB
X-Message-ID-Hash: KKCQXCA7HS3KY7U3RUA6T4RZSUIQMARB
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KKCQXCA7HS3KY7U3RUA6T4RZSUIQMARB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

YWxzYS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYgaXNzdWUgIzkyNiB3YXMgb3BlbmVkIGZyb20gWndz
bGluOgoKIyMgU3VtbWFyeQoKVGhlIFVDTSBwcm9maWxlIGBVU0ItQXVkaW8vVGV1ZmVsL0NBR0Ut
UFJPLUhpRmkuY29uZmAgZGVmaW5lcyB0d28gcGxheWJhY2sgZGV2aWNlczoKCi0gYEhlYWRzZXRg
ICgiQ2hhdCIpIOKGkiBgaHc6JHtDYXJkSWR9LDBgCi0gYEhlYWRwaG9uZXNgICgiR2FtZSIpIOKG
kiBgaHc6JHtDYXJkSWR9LDFgCgpUaGUgcHJvZmlsZSB3YXMgYWRkZWQgaW4gIzU4MiBmb3IgYSBk
b25nbGUgd2l0aCAidHdvIHN0ZXJlbyBvdXRwdXRzOiBvbmUgZm9yIGdhbWUgYW5kIG9uZSBmb3Ig
Y2hhdCIuIE15IGRvbmdsZSwgaG93ZXZlciwgZXhwb3NlcyBvbmx5ICoqb25lKiogcGxheWJhY2sg
UENNIChgaHc6UFJPLDBgKS4gT3BlbmluZyBgaHc6UFJPLDFgIGZhaWxzLCBzbyB0aGUgd2hvbGUg
YEhpRmlgIHZlcmIgaXMgcmVqZWN0ZWQuIFBpcGVXaXJlL0FDUCB0aGVuIG9mZmVycyBvbmx5IHRo
ZSBgb2ZmYCBwcm9maWxlLCB3aGljaCBtZWFucyB0aGUgaGVhZHNldCBjYW4ndCBiZSB1c2VkIGF0
IGFsbCB3aXRob3V0IGEgd29ya2Fyb3VuZC4KCiMjIEVudmlyb25tZW50CgotIERpc3RyaWJ1dGlv
bjogQ2FjaHlPUyAoQXJjaC1iYXNlZCksIGtlcm5lbCA3LjMuNS0yLWNhY2h5b3MKLSBhbHNhLXVj
bS1jb25mIDEuMi4xNi4xLTEKLSBwaXBld2lyZSAxLjYuMTEtMiwgd2lyZXBsdW1iZXIgMC41LjE5
LTEuMQotIERldmljZTogYDJjYzI6MDAzMyBMYXV0c3ByZWNoZXIgVGV1ZmVsIEdtYkggQ0FHRSBQ
Uk9gIChVU0Igc3RyaW5nczogTWFudWZhY3R1cmVyICJNZWRpYVRlayBJbmMiLCBiY2REZXZpY2Ug
MS4wMCksIHdpcmVsZXNzIFVTQiBkb25nbGUsIGZ1bGwgc3BlZWQKCiMjIE9ic2VydmVkIGRldmlj
ZSBsYXlvdXQKCmAvcHJvYy9hc291bmQvY2FyZDIvc3RyZWFtMGA6CgpgYGAKTWVkaWFUZWsgSW5j
IENBR0UgUFJPIGF0IHVzYi0wMDAwOjAwOjE0LjAtMSwgZnVsbCBzcGVlZCA6IFVTQiBBdWRpbwoK
UGxheWJhY2s6CiAgSW50ZXJmYWNlIDEKICAgIEFsdHNldCAxOiBTMTZfTEUsIDIgY2gsIDQ4MDAw
Lzk2MDAwIEh6LCBFUCAweDAxIE9VVCAoQURBUFRJVkUpCiAgICBBbHRzZXQgMjogUzI0XzNMRSwg
MiBjaCwgNDgwMDAvOTYwMDAgSHosIEVQIDB4MDEgT1VUIChBREFQVElWRSkKCkNhcHR1cmU6CiAg
SW50ZXJmYWNlIDIKICAgIEFsdHNldCAxOiBTMTZfTEUsIDEgY2gsIDE2MDAwLzQ4MDAwIEh6LCBF
UCAweDgxIElOIChBREFQVElWRSkKYGBgCgpgbHN1c2IgLXZgIHNob3dzIDQgaW50ZXJmYWNlczog
MCA9IEF1ZGlvIENvbnRyb2wsIDEgPSBTdHJlYW1pbmcgT1VUIChFUCAweDAxKSwgMiA9IFN0cmVh
bWluZyBJTiAoRVAgMHg4MSksIDMgPSBISUQuIFRoZXJlIGlzIG5vIHNlY29uZCBwbGF5YmFjayBp
bnRlcmZhY2UsIHNvIGBhcGxheSAtbGAgbGlzdHMgb25seSBgY2FyZCAyOiBQUk8gW0NBR0UgUFJP
XSwgZGV2aWNlIDA6IFVTQiBBdWRpb2AuCgojIyBQcm9iZSBvdXRwdXQKCmBzcGEtYWNwLXRvb2wg
LWMgMiAtdnYgaW5mb2A6CgpgYGAKSSAgICAgICBhbHNhLXVjbS5jOjI1NjcgICAgICBQcm9iaW5n
IHByb2ZpbGUgSGlGaQpJICAgICAgYWxzYS11dGlsLmM6NzI0ICAgICAgIEFMU0EgZGV2aWNlIG9w
ZW4gJ191Y20wMDAxLmh3OlBSTywwJyBwbGF5YmFjawpJICAgICAgYWxzYS11dGlsLmM6NzIxICAg
ICAgIEVycm9yIG9wZW5pbmcgUENNIGRldmljZSBfdWNtMDAwMS5odzpQUk8sMTogTm8gc3VjaCBm
aWxlIG9yIGRpcmVjdG9yeQpJICAgICAgIGFsc2EtdWNtLmM6MjU5MSAgICAgIFByb2ZpbGUgJ0hp
RmknIG1hcHBpbmcgJ0hpRmk6IEhlYWRwaG9uZXM6IHNpbmsnOiBvdXRwdXQgUENNIG9wZW4gZmFp
bGVkCkkgICAgICAgYWxzYS11Y20uYzoyNjIxICAgICAgUHJvZmlsZSBIaUZpIG5vdCBzdXBwb3J0
ZWQKYGBgCgojIyBQb3NzaWJseSByZWxldmFudDogdGhlIGRvbmdsZSBtYXkgc3dpdGNoIGxheW91
dHMKCldoZW4gdGhlIGRvbmdsZSB3YXMgcGx1Z2dlZCBpbiwgdGhlIGtlcm5lbCBsb2cgc2hvd2Vk
IGEgZmlyc3QgZW51bWVyYXRpb24gdGhhdCByZWZlcmVuY2VkIGFkZGl0aW9uYWwgaW50ZXJmYWNl
cy9lbmRwb2ludHMgKGluY2x1ZGluZyBhIHNlY29uZCBPVVQgZW5kcG9pbnQgYGVwIDB4MmAgb24g
aW50ZXJmYWNlIDMpLiBUaGUgZGV2aWNlIHRoZW4gZGlzY29ubmVjdGVkIGFuZCByZS1lbnVtZXJh
dGVkIGltbWVkaWF0ZWx5IHdpdGggdGhlIHNpbmdsZS1vdXRwdXQgbGF5b3V0IHNob3duIGFib3Zl
OgoKYGBgCnVzYiAzLTE6IDE6MTogY2Fubm90IGdldCBmcmVxIGF0IGVwIDB4MQp1c2IgMy0xOiAx
OjI6IGNhbm5vdCBnZXQgZnJlcSBhdCBlcCAweDEKdXNiIDMtMTogMzoxOiBjYW5ub3QgZ2V0IGZy
ZXEgYXQgZXAgMHgyCnVzYiAzLTE6IFVTQiBkaXNjb25uZWN0LCBkZXZpY2UgbnVtYmVyIDYKdXNi
IDMtMTogNDoxOiBjYW5ub3Qgc2V0IGZyZXEgNDgwMDAgdG8gZXAgMHg4MQouLi4KdXNiIDMtMTog
bmV3IGZ1bGwtc3BlZWQgVVNCIGRldmljZSBudW1iZXIgNyB1c2luZyB4aGNpX2hjZAp1c2IgMy0x
OiBOZXcgVVNCIGRldmljZSBmb3VuZCwgaWRWZW5kb3I9MmNjMiwgaWRQcm9kdWN0PTAwMzMsIGJj
ZERldmljZT0gMS4wMApgYGAKClNvIHRoZSBzYW1lIFVTQiBJRCBzZWVtcyB0byBjb21lIHVwIGVp
dGhlciB3aXRoIHR3byBwbGF5YmFjayBQQ01zIChDaGF0ICsgR2FtZSwgd2hpY2ggdGhlIGN1cnJl
bnQgVUNNIGZpbGUgYXNzdW1lcykgb3Igd2l0aCBqdXN0IG9uZSwgZGVwZW5kaW5nIG9uIGZpcm13
YXJlLCBtb2RlIG9yIHRpbWluZy4gSSBkb24ndCBrbm93IHdoYXQgdHJpZ2dlcnMgdGhlIHN3aXRj
aC4KCiMjIFdvcmthcm91bmQKCkRpc2FibGluZyBVQ00gZm9yIHRoaXMgY2FyZCBtYWtlcyB0aGUg
c3RhbmRhcmQgQUNQIHByb2ZpbGUgc2V0IHdvcms6IGBhbmFsb2ctc3RlcmVvYCBvdXRwdXQgcGx1
cyBgbW9uby1mYWxsYmFja2AgaW5wdXQuIFBsYXliYWNrIGFuZCB0aGUgbWljcm9waG9uZSBib3Ro
IHdvcmsgZmluZS4KCmB+Ly5jb25maWcvd2lyZXBsdW1iZXIvd2lyZXBsdW1iZXIuY29uZi5kLzUx
LXRldWZlbC1jYWdlLXByby5jb25mYDoKCmBgYAptb25pdG9yLmFsc2EucnVsZXMgPSBbCiAgewog
ICAgbWF0Y2hlcyA9IFsgeyBkZXZpY2UubmFtZSA9ICJhbHNhX2NhcmQudXNiLU1lZGlhVGVrX0lu
Y19DQUdFX1BST18wMDAwMDAwMDAwMDAwMDAwLTAwIiB9IF0KICAgIGFjdGlvbnMgPSB7IHVwZGF0
ZS1wcm9wcyA9IHsgYXBpLmFsc2EudXNlLXVjbSA9IGZhbHNlIH0gfQogIH0KXQpgYGAKCiMjIFN1
Z2dlc3RlZCBmaXgKCk1ha2UgdGhlIGBIZWFkcGhvbmVzYC8iR2FtZSIgZGV2aWNlIGNvbmRpdGlv
bmFsIG9uIHRoZSBzZWNvbmQgUENNIGJlaW5nIHByZXNlbnQsIHNvIHRoYXQgdGhlIHByb2ZpbGUg
c3RpbGwgd29ya3Mgd2l0aCB0aGUgc2luZ2xlLVBDTSBsYXlvdXQuIE9uZSBvcHRpb24gbWlnaHQg
YmUgYW4gYElmYCBibG9jayB3aXRoIGBUeXBlIENvbnRyb2xFeGlzdHNgIG9uIHRoZSBpbmRleC0x
IFBDTSBwbGF5YmFjayBjb250cm9sLCB3aGljaCB0aGUgZmlsZSBhbHJlYWR5IHJlZmVyZW5jZXMg
YXMgYFBDTSwxYCBhbmQgd2hpY2ggb25seSBleGlzdHMgaW4gdGhlIHR3by1QQ00gbGF5b3V0LiBJ
IGhhdmVuJ3QgdGVzdGVkIHRoaXMsIHNvIHBsZWFzZSBjaG9vc2Ugd2hhdGV2ZXIgY29uZGl0aW9u
IGZpdHMgYmVzdC4KCkknbSBoYXBweSB0byB0ZXN0IHBhdGNoZXMgb3IgcHJvdmlkZSBtb3JlIG91
dHB1dCAoYGFsc2EtaW5mby5zaGAsIGZ1bGwgYGxzdXNiIC12YCkuCgpJc3N1ZSBVUkwgICAgIDog
aHR0cHM6Ly9naXRodWIuY29tL2Fsc2EtcHJvamVjdC9hbHNhLXVjbS1jb25mL2lzc3Vlcy85MjYK
UmVwb3NpdG9yeSBVUkw6IGh0dHBzOi8vZ2l0aHViLmNvbS9hbHNhLXByb2plY3QvYWxzYS11Y20t
Y29uZgo=
