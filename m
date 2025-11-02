Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F711CCF9E3
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Nov 2025 14:48:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7F915602DD;
	Mon, 10 Nov 2025 15:48:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7F915602DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1762786127;
	bh=ywmJMZa+TLZr7H2bdXNFxZE3jhHztSMHWubuBCGbS/o=;
	h=From:Date:Subject:To:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=CMJXR49457cgKAGuZi/mB2MnQSEKpKRXZafWFbInzt+M+PoTsNDpONZa+IYCsImCt
	 xE3e84RWqb/TdTJ2QVonA1myjRifCxlYnPKk1CZhvlsEJ2VwhTuXqdU4tsSx7ahB1I
	 InanF0HOc8nXgX1l81gekByqnf/Yw8D7xPRc67IM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9AB3DF897A9; Mon, 10 Nov 2025 15:42:05 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8F95CF897A3;
	Mon, 10 Nov 2025 15:42:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C2A54F80424; Sun,  2 Nov 2025 04:18:46 +0100 (CET)
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com
 [74.125.224.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 34DA1F8003C
	for <alsa-devel@alsa-project.org>; Sun,  2 Nov 2025 04:18:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 34DA1F8003C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20230601 header.b=k/WbKNqa
Received: by mail-yx1-f47.google.com with SMTP id
 956f58d0204a3-63bcfcb800aso3640702d50.0
        for <alsa-devel@alsa-project.org>;
 Sat, 01 Nov 2025 20:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762053520; x=1762658320;
 darn=alsa-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=km/fEQOqNnDYwC+f9Tnw85toJ/JZDx0sRrSLTb1K6m8=;
        b=k/WbKNqa0e6kfsKzlyUyg2VWvkLyiXGuDsrs6+edIyg5f0Yj5awHKMlqABvFP7R0kI
         yr2FcpTm+kciu6WDKEnpJST3QBM02e7bD6o7IBhs1KgqMeODQ5RTpBcXBQaW8UenFPK4
         XXG6bPlmJ6Wc5H2n1laCixWjUKIr+xywLxH8A0Ux5+mV1+Ta7OdJbQouKz5myIg3WDqT
         clru/bUlmyZRYB4pVhlf4R6ch58Gk8jiC+rov5lnLdQbs6BEcZBPBiGGEkbfABEQnOe4
         iGuNDDO8S8RCdm019hgW2bHDTtgLLJCNSqtRBVkJiAh0dVn2e/DFP8tCj4k51P4BeQDm
         e6cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762053520; x=1762658320;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=km/fEQOqNnDYwC+f9Tnw85toJ/JZDx0sRrSLTb1K6m8=;
        b=vy3sLFjEuzivc2W7oMMRMhfRiNEQO93MuJ+TPM8j0CG5do1lB2eDNnR50HoCrMuYXb
         J41K+fFs7YXd+vtYtz5kan0A0rofGNAxCXuHDjaaQ62XjI19PxmgbycgmEmzMoSDtuLI
         +pe4Xp8lKWb3UZQwSZ04yo77op8upjR1OB06hDOgy8GHhTeWMh9YWcX7H33NQ2Of5986
         PtSzcrkna0BOS6WbpZZr2oqMb6DNtngcCWZZjNImHOcWJqieO4YMZbHBZ+h84Ve2LxTU
         DRyHNHjYL6FTaBHYVA8T80IjARvSCb4vzud5zElZWtoWzm7Z9QW4IZNhVD3kI8/jhW+h
         0YaA==
X-Gm-Message-State: AOJu0YyktQuUraUT83YtFbn6lWx/+gEUyejoxTGZniA1SUXKW8nBN8O1
	339rpjk8ml1jvwwvCGmHy8/myn8PGaPVbIxHW2bXmn4/rwhIFbHaYnAkF+cuxQHutJWM+z/jmkC
	llmUMAkeL8U4QyppBZkdrgm95OXglFoAyByT5
X-Gm-Gg: ASbGncuGPtM0uthNmdlKw5QwbBxF323D/0xV/K7BrRh+dfFcz62lotx75H7GRci0eVR
	ofyp+P1124aCEh/fque8FdCseg8kGEN/6KPytnzhp0ahUcadCoJy5SU2a+4P/mGH+wLORViwgUg
	9OMZe1v6JkkOOOjHm81GJGYJM6Bm5fCF9GjdbrfIILQrnjau22ZddE5hcthmaE8LbX2XW2NH0+f
	UMNHSoM7zAlvT73xKZQiaIGOue00iXZqtv4xivXWvegYgiUlKB8egP0kAUNJ1/FDHAPCLkYfZ2j
	ZcAE/syFljZhsi8YlRkdIeRnU+k19DVUV54yfbwudI9KfW7NO7OghGML0aMlWoYCLs9RNDP83yU
	yxUHXWd+FW4KNHlvYvTCy0/63
X-Google-Smtp-Source: 
 AGHT+IG9DOeiZ9ZHZex2iU7fX03b9W1bJm4GsLElzrsNIT2MThahL+W2g6QJigAtYNHCkTbhdNyHP90pBDzFRteZlsY=
X-Received: by 2002:a05:690e:4083:b0:63e:914:28c8 with SMTP id
 956f58d0204a3-63f9a284e42mr4921730d50.68.1762053519400; Sat, 01 Nov 2025
 20:18:39 -0700 (PDT)
MIME-Version: 1.0
From: jo <messagerie44@gmail.com>
Date: Sun, 2 Nov 2025 04:18:28 +0100
X-Gm-Features: AWmQ_bl4xSK_yh4n0AQVrw_WsfRoaNzk-Rc0k9SmtO29u8vdDx4ekDKmx8vwkYI
Message-ID: 
 <CAGG2WP+Zr-kG+VcsU7Vw=558DLoSWv74qDETezmvg2r-j+TBng@mail.gmail.com>
Subject: Reg: Internal Microphone Broken on ASUS X509UA (ALC3251, SSID
 1043:1961) Starting AFTER Kernel 6.8.0-31
To: alsa-devel@alsa-project.org, tiwai@suse.de
X-MailFrom: messagerie44@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: 7XXKGGTXB3ESR5J2KHB6DTPLWWFCKCET
X-Message-ID-Hash: 7XXKGGTXB3ESR5J2KHB6DTPLWWFCKCET
X-Mailman-Approved-At: Mon, 10 Nov 2025 14:40:12 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.9
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7XXKGGTXB3ESR5J2KHB6DTPLWWFCKCET/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

KlN5c3RlbS9IYXJkd2FyZSBEZXRhaWxzOioNClBhcmFtZXRlciBWYWx1ZQ0KKkxhcHRvcCBNb2Rl
bCogKkFTVVMgVml2b0Jvb2sgWDUwOVVBKg0KKkNQVSBHZW5lcmF0aW9uKiBJbnRlbCBDb3JlIGkz
LTcwMjBVIChLYWJ5IExha2UgLyBTdW5yaXNlIFBvaW50LUxQKQ0KKkF1ZGlvIENvZGVjKiBSZWFs
dGVrIEFMQzMyNTEgKFZhcmlhbnQgb2YgQUxDMjU2KQ0KKlN1YnN5c3RlbSBJRCAoU1NJRCkqICox
MDQzOjE5NjEqIChBU1VTVGVLIENvbXB1dGVyIEluYy4pDQoqUENJIERldmljZSBJRCogSW50ZWwg
Q29ycG9yYXRpb24gU3VucmlzZSBQb2ludC1MUCBIRCBBdWRpbyBbODA4Njo5ZDcxXQ0KKldvcmtp
bmcgS2VybmVsIFZlcnNpb24qICpMaW51eCBLZXJuZWwgNi44LjAtMzEqIGFuZCBwcmV2aW91cyB2
ZXJzaW9ucy4NCipCcm9rZW4gS2VybmVsIFZlcnNpb24qICpTdGFydHMgQUZURVIgNi44LjAtMzEq
IChlLmcuLCA2LjguMC0zMiwgNi44LjAtMzUsDQpldGMuKS4NCg0KDQpEZXNjcmlwdGlvbiBvZiB0
aGUgSXNzdWUNCg0KVGhlIGludGVybmFsIG1pY3JvcGhvbmUgb24gdGhlIEFTVVMgWDUwOVVBIGlz
ICpubyBsb25nZXIgZnVuY3Rpb25hbCogb24NCkxpbnV4IGtlcm5lbHMgbmV3ZXIgdGhhbiB2ZXJz
aW9uIDYuOC4wLTMxLiBUaGUgaW5wdXQgZGV2aWNlIGlzIGRldGVjdGVkIGJ5DQpBTFNBL1B1bHNl
QXVkaW8sIGJ1dCB0aGUgY2FwdHVyZSBsZXZlbCByZW1haW5zIGF0IHplcm8gKG5vIHNvdW5kIGlz
DQpyZWNvcmRlZCkuDQoNClRoZSBpc3N1ZSBpcyBhICpjbGVhciByZWdyZXNzaW9uKiwgYXMgdGhl
IG1pY3JvcGhvbmUgd29ya2VkIGNvcnJlY3RseSBvbg0Ka2VybmVsIDYuOC4wLTMxIGFuZCBhbGwg
cHJldmlvdXMgdmVyc2lvbnMgKGUuZy4sIGluIFVidW50dSAyMi4wNCBMVFMpLiBJdA0KYWxzbyB3
b3JrcyBjb3JyZWN0bHkgdW5kZXIgQ2hyb21lIE9TIEZsZXgsIHdoaWNoIHVzZXMgYSBjdXN0b20t
cGF0Y2hlZA0Ka2VybmVsLg0KDQpEaWFnbm9zdGljIFN0ZXBzIFBlcmZvcm1lZA0KDQpBbGwgc3Rh
bmRhcmQgdXNlci1sZXZlbCBhbmQgY29tbW9uIGRldmVsb3BlciB3b3JrYXJvdW5kcyBoYXZlIGZh
aWxlZCBvbiB0aGUNCmFmZmVjdGVkIGtlcm5lbCB2ZXJzaW9uczoNCg0KICAgMS4NCg0KICAgKkFM
U0EgTWl4ZXIgTGV2ZWxzOiogQ29uZmlybWVkIHRoYXQgdGhlICJDYXB0dXJlLCIgIk1pYywiIGFu
ZCAiSW50ZXJuYWwNCiAgIE1pYyBCb29zdCIgbGV2ZWxzIGFyZSBjb3JyZWN0bHkgc2V0IChub3Qg
bXV0ZWTigJQiT08iIGluc3RlYWQgb2YgIk1NIikgYW5kDQogICBib29zdGVkICh0byA4MC0xMDAl
KS4NCiAgIDIuDQoNCiAgICpoZGFqYWNrcmV0YXNrIChQaW4gUmVtYXBwaW5nKToqIEFsbCBhdmFp
bGFibGUgcGlucywgaW5jbHVkaW5nIDB4MTksIDB4MWIsDQogICBhbmQgIk5vdCBDb25uZWN0ZWQi
IHBpbnMgKDB4MTIsIDB4MTMsIDB4MTgsIDB4MWEpLCB3ZXJlIHRlc3RlZCB3aXRoDQp0aGUgKiJJ
bnRlcm5hbA0KICAgbWljIiogZnVuY3Rpb24uIE5vbmUgb2YgdGhlc2Ugb3ZlcnJpZGVzIGNvcnJl
Y3RlZCB0aGUgaXNzdWUuDQogICAzLg0KDQogICAqaGRhLXZlcmIgQ29tbWFuZHM6KiBTdGFuZGFy
ZCBHUElPLWJhc2VkICpxdWlya3MqIGNvbW1vbmx5IHVzZWQgdG8gZml4DQogICBSZWFsdGVrIG1p
YyBpc3N1ZXMgKGUuZy4sIGhkYS12ZXJiIDB4MDEvMHgwMi8weDA0KSB3ZXJlIGV4ZWN1dGVkIGFu
ZA0KICAgZmFpbGVkIHRvIGFjdGl2YXRlIHRoZSBtaWNyb3Bob25lLg0KICAgNC4NCg0KICAgKkFM
U0EgTW9kZWwgUXVpcmsgT3B0aW9uczoqIFRoZSBmb2xsb3dpbmcgY29tbW9uIGFuZCB0YXJnZXRl
ZCBtb2RlbD0NCiAgIG9wdGlvbnMgd2VyZSBhZGRlZCB0byAvZXRjL21vZHByb2JlLmQvdGVzdC1h
dWRpby5jb25mIChvbmUgYXQgYSB0aW1lLA0KICAgZm9sbG93ZWQgYnkgc3VkbyBhbHNhIGZvcmNl
LXJlbG9hZCkgYW5kIGRpZCBub3QgcmVzb2x2ZSB0aGUgaXNzdWU6DQogICAtDQoNCiAgICAgIG9w
dGlvbnMgc25kLWhkYS1pbnRlbCBtb2RlbD1hbGMyNTYtYXN1cy1taWMxDQogICAgICAtDQoNCiAg
ICAgIG9wdGlvbnMgc25kLWhkYS1pbnRlbCBtb2RlbD1sYXB0b3AtYW1pYw0KICAgICAgLQ0KDQog
ICAgICBvcHRpb25zIHNuZC1oZGEtaW50ZWwgbW9kZWw9ZGVsbC1oZWFkc2V0LW11bHRpIChUaGlz
IGNhdXNlZCB0aGUNCiAgICAgIG1pY3JvcGhvbmUgdG8gZGlzYXBwZWFyIGVudGlyZWx5LikNCiAg
ICAgIDUuDQoNCiAgICpPbGQgQ29uZmlndXJhdGlvbiBGaWxlczoqIFJldmVydGluZyB0byBvciBh
cHBseWluZyB0aGUgZXhhY3QNCiAgIGNvbmZpZ3VyYXRpb24gZmlsZXMgKGhkYS5jb25mKSB0aGF0
ICp3b3JrZWQqIG9uIHRoZSBwcmUtNi44IGtlcm5lbHMNCiAgIGZhaWxlZCB0byBhY3RpdmF0ZSB0
aGUgbWljcm9waG9uZSBvbiB0aGUgcG9zdC02LjguMC0zMSBrZXJuZWxzLCBzdWdnZXN0aW5nDQog
ICBhIGRlZXBlciBzdHJ1Y3R1cmFsIGNoYW5nZSBpbiB0aGUgZHJpdmVyIGNvZGUuDQoNClJlcXVl
c3QNCg0KVGhlIGZhaWx1cmUgb2YgYWxsIHN0YW5kYXJkIHdvcmthcm91bmRzIGluZGljYXRlcyB0
aGF0IHRoZSByZWdyZXNzaW9uIGlzDQpkdWUgdG8gYSAqbWlzc2luZyBvciBpbmNvcnJlY3QgcGlu
LW1hcHBpbmcgY29uZmlndXJhdGlvbiogZm9yIHRoZSAqMTA0MzoxOTYxDQpTU0lEKiB3aXRoaW4g
dGhlIHNuZC1oZGEtaW50ZWwgZHJpdmVyLCBsaWtlbHkgaW50cm9kdWNlZCBpbiBhIHBhdGNoIGFm
dGVyDQoqNi44LjAtMzEqLg0KDQpBIHBhdGNoIGlzIG5lZWRlZCB0byByZS1pbnRyb2R1Y2UgdGhl
IGNvcnJlY3QgbWljcm9waG9uZSAqcXVpcmsqIGZvciB0aGUgKkFTVVMNClg1MDlVQSAoMTA0Mzox
OTYxKSogdG8gcmVzdG9yZSBmdW5jdGlvbmFsaXR5IG9uIHRoZSBsYXRlc3QgTGludXgga2VybmVs
DQpzZXJpZXMuDQo=
