Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB8F4CA5FFF
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Oct 2026 06:57:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A350E601E7;
	Wed,  7 Oct 2026 08:57:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A350E601E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791356269;
	bh=USrXeKSprW7SqZYeGO923ipqL2xDj5OuLMf67qcHrX0=;
	h=From:Date:Subject:To:Cc:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=Wi+R7753Abok9DLJSBNAhtukRk38ykQhOwpbkfVX0AwhP55+Qrq7PoMk6fBLigVu1
	 nMUwMqfVOGSRrGJ6DEKGYiXTemh4oJ2fZtwHQGX4EB08B93PXs+8+x/uPQcgeoHxoO
	 evEotWZcUPmHrV2DaBlcmj7zCjUcKGzcRpJfAcx0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3CE49F8060E; Wed,  7 Oct 2026 08:57:20 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B912FF80613;
	Wed,  7 Oct 2026 08:57:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5CC7DF8057F; Thu,  1 Oct 2026 20:26:29 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.45
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1790879187;
	b=H67fiyK0d85Nmc01u8p+508RkOYNg0fjKYfBbUUWyNkg7ZdNvCPmTvuZAb0cpYaffecf
	 bpEMWB0aqNweb0+25L1nW4ei/x4c2gmk/r3eT0aCSeZjzNDxp3PcgzxmvAvoWcwvcmFQU
	 husnd3ZBs3Uf7LrhOhXvS7D/aqvNi55AIZl6tuv2WeocV3HhKHg9CqkI9oz9i3L+rQ7DD
	 /SPBXIvlmTnOS+V97usx5f5gTdIAujEM3n8jjqkgpO6z18oHsa7KPhdaOrnafoNgz7T50
	 WNXH8NX77Fha5iRyJtEZ3mRfmJxS55WKdpNFIu/06J2fXrPEa5VP39NY0ErNRMdDvRw==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1790879187;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To;
	bh=8PGUnc9ycSfisEW7fqv5nfXJeSRgsApStE/61juStnA=;
	b=WZo5K67uzdvKxZr0WVvygxOe9FH10jV9GftqFdlEe2q0idjTldKNHHfextO+05wBLKQQ
	 QVVOXNNU9dKG/bfdwBdVJC1/6SML1YTa8TNdvuBYkT5SdtfdK6+A0nmsKIiE4KWtIotAF
	 cxzlBqKZgHpBEtqBQqyBnE9bY/87iYlS3bBMB5Rsw2AsnRF4daFNvZfBkQMAQNBNdUOeR
	 k2ODnWQ5oM5kx0SVDrUKX78Bwj+EiLc1NMPGU9JJJ1jpM1xRO2h9GWKmFkTmkd2k6T7z2
	 ESjlVeYKK+KbIp1Ffu7bc9oXP1fuiGnAbebYOsP9Me6knHRSDvkOVRIpI27Tq4yW+3w==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=KoMQebDU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.45
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com
 [209.85.210.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 220E0F804CC
	for <alsa-devel@alsa-project.org>; Thu,  1 Oct 2026 20:26:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 220E0F804CC
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=KoMQebDU
Received: by mail-ot1-f45.google.com with SMTP id
 46e09a7af769-8198a3a54d7so2852290a34.1
        for <alsa-devel@alsa-project.org>;
 Thu, 01 Oct 2026 11:26:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790879183; cv=none;
        d=google.com; s=arc-20260327;
        b=F/W/TcV+uihBAaLF5PvjUZRwec5ecNzE999Xl3vid5kzXfq/Py6+gs25WX1u30UXR7
         wJLXo/moDNJdAdyclt6Op7/JZHR4GGREQdON4eL6Dr6Bxq2jyFavURI6PXF/glMvyNxj
         9nL9WtMd+0yYe9JU63WAhqMhy//03XA2fXX87JSSsAvuyr654BGTRwmUsp0uAGhkMiRY
         zZ9cD/FdJEpnTLHMslDpvGOEcqmue7xiEXYkPdi7kfIHyN2zhvqmiVfHxaHDweUs5CEo
         0YArIIjheNbw+Jyf3MzgBp2WZiFGo6aJVtSKyy8Y5/LVGSL4DrJY3hGmelUE3ayYEUA+
         B8rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=x6Vhr9RjR2Vjk8JHdEBZL8KyAmxOhuMnmfC6gWMQWZk=;
        fh=u9A4OQGX79r3nuJi6TAF4WohijDx1UOUVwQooB1hYlg=;
        b=ZODgRkniSDkLnP2UnIJcStLhlamqtHpDWpIBXeEka514S4FO+NjMTQrjbAlhZr6Dyl
         pcd436sJirgiDxMKKO5awgge/ilxM4eYdfv6ftd0ljC5d7VSj76fXszazDsj9w7WN8fb
         iHonWWiIl12xXH8rP5PtvIBuN4yI1FB3kVOzUmOyHJtlg7Ib4sLBZJVlurH9aQB4r+bs
         waoilIYeuPKjlzBEFGBmzij3kgYzynuymz5ZgfpuECzh9jTHrTkLqZFOXZQc5kujsOtx
         MxjoX+z08b8U1+6t1c9mOXLjgTnBnZCTNOzk3Xw1xcMgHbr5uUuWZKIabWgkayJgdDPd
         bEWQ==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790879183; x=1791483983;
 darn=alsa-project.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=x6Vhr9RjR2Vjk8JHdEBZL8KyAmxOhuMnmfC6gWMQWZk=;
        b=KoMQebDU5P2+hd16MdofsESwghPQiKeDolLEvihDfqX9h/Um8tNPKn2xdr1NdwXMAH
         OXaXUjtDP5F7Kc+kwb2TqI2UqaCflB6qEoreb62fQkf4K0cXrBVk0NrGWMulZ9HCNUUf
         ija3lGWO+q1TmhY6Y4D10FNnhaX2wlULVil9+4Is48f5lK3OCNfiQ9irWJ0o+OKLXT+k
         of4PRk1QMW+iooDdYOOxjA6H09P70G7308Q4b00I70ey6ARifeOTSv3IsXZN/NRRQWhP
         i7RlVh/ZcZOKCojnaB5X5reZj75T1vgqcf8+mxhmO7drvSLTWM9M3HgThrrUxuoTjxAd
         yVnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790879183; x=1791483983;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=x6Vhr9RjR2Vjk8JHdEBZL8KyAmxOhuMnmfC6gWMQWZk=;
        b=Uy2se8OtJ/A6mqdGUmOYEl39tlbRfLxd09DQ+dMsORlG+49bsZqq5Sd9AveSuyfHSF
         9bKwCairzR9nbWuEMD/R2s7o7IwU+dI1yL2a2NG7DBqnITfqS/xHWE4W0KN5C20rZJFh
         uuY6VDHSz3JCwqi9jMCBThV9UVfxe8tAzcAMVsC/+lHVxzY5atjMZEI5Z5b0SRI6SpeT
         P2mTFqKPypG/GjE+tfW2CdfnNFrO19KjJO6x38E2gKR6J3KzMUloT9ryzfayVC36jCD0
         UcfDninpNc3S8TIGsO6yWgEeLNUngmJOxImwCklisS7lxbbgQs8zOB0BQMODiqM9DCv+
         URbw==
X-Gm-Message-State: AFuF++kr7U33sfYWQjq5Jlv8o404TprqOAH2iVRkRLJxoyLwCMgyQlOv
	Ayw6TC+JtE8DCh0cXEP9V60vz5FZ5q9+ed5cY0gtU/CYnaotL0TSNVYdizMJ8vYXREla34sPZ4i
	d1yGOEe53/6ge8nTKSf+HIP+fQJrrE062oJT1rX4=
X-Gm-Gg: AYBFou2OTbUg6bDcqd8FgbFDlvzcD6oZipi6T2DXqyIgtnMMsf4qx4mf40YHXVgGyLk
	adAP+yEtndXPmU49QlC2VvBIQL612+4K0s6jng4V3iSAoK311dr1cjuPPuvnwGo5kByw3/zC10y
	UBBab8TQg7kFOw9bAkpIi9hjhpUzfclIQ9ZyArEeaKtDAXp344HM7oAbn1EqvO0LH1x5v8fv5c/
	F0raQ87coQDU7JFmBE5ugDljNH4+cg31niDOB9aiNuZJ8bd8WAfMiFq9nedlHKL5Thx/n5hVq2E
	23+3Vf4U5SYE2VpmHJ82pfl+FYDRF/Ly+XyUpqNw6tX+xgQUUrHlBPUwF5AAx1qhAYxDYw==
X-Received: by 2002:a05:6808:23cc:b0:4d6:9133:cfe1 with SMTP id
 5614622812f47-4f30b6ff3f7mr3442492b6e.38.1790879183432; Thu, 01 Oct 2026
 11:26:23 -0700 (PDT)
MIME-Version: 1.0
From: Beau Lynn-Miller <beaulm@gmail.com>
Date: Thu, 1 Oct 2026 13:25:46 -0500
X-Gm-Features: AclHuK-lgW8aZWuscTlO9yHWIH-gzTqaFA6tq4HeEhuD20hTYg7L4bsHYGljegM
Message-ID: 
 <CAE+cq4DqF8DsgzLh89FvED78p53=eUZ1pUq+ePV-tGBodBt=vQ@mail.gmail.com>
Subject: [BUG] ALSA: amd: ps: acp63 DMIC capture freezes/rails after prolonged
 s2idle suspend on AMD Phoenix
To: alsa-devel@alsa-project.org
Cc: Vijendar.Mukunda@amd.com, Syed.SabaKareem@amd.com
X-MailFrom: beaulm@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: EEFTJXELTYDW4VWKV2S45QBXIQCV6KUD
X-Message-ID-Hash: EEFTJXELTYDW4VWKV2S45QBXIQCV6KUD
X-Mailman-Approved-At: Wed, 07 Oct 2026 06:57:14 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/EEFTJXELTYDW4VWKV2S45QBXIQCV6KUD/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

U1VNTUFSWQ0KT24gYSBMZW5vdm8gVGhpbmtQYWQgVDE2IEdlbiAyIEFNRCAoQU1EIFBob2VuaXgg
LyBBQ1A2LjMpLCB0aGUgaW50ZXJuYWwNCmRpZ2l0YWwgbWljcm9waG9uZSBhcnJheSAoRE1JQykg
Y29uc2lzdGVudGx5IGZhaWxzIHVwb24gcmVzdW1pbmcgZnJvbQ0KZXh0ZW5kZWQgczJpZGxlIHN1
c3BlbmQgKG92ZXJuaWdodCBvciA+Mi41IGhvdXJzKS4gQ2FwdHVyZSBzdGFydHMgYW5kDQpjbG9j
a3Mgd2l0aG91dCBrZXJuZWwgZXJyb3JzLCBidXQgcmV0dXJucyBhIGNvbnN0YW50IGZyb3plbiB2
YWx1ZSAoemVybw0KQUMtUk1TIC8gcmFpbGVkKSBpbnN0ZWFkIG9mIGFuIGFjb3VzdGljIHNpZ25h
bC4NCg0KU2hvcnQgZGF5dGltZSBzdXNwZW5kcyAodW5kZXIgMeKAkzIgaG91cnMpIGFuZCByYXBp
ZCBSVEMgd2FrZSBjeWNsZXMgZG8gTk9UDQp0cmlnZ2VyIHRoZSBpc3N1ZS4gT25jZSB0cmlnZ2Vy
ZWQsIHRoZSBoYXJkd2FyZSBzdGF0ZSBsYXRjaGVzOiBuZWl0aGVyDQp1bmxvYWRpbmcvcmVsb2Fk
aW5nIHRoZSBkcml2ZXIgbW9kdWxlcyBub3IgdW5iaW5kaW5nL3Jlc2Nhbm5pbmcgdGhlIFBDSQ0K
ZW5kcG9pbnQgdmlhIHN5c2ZzIHJlc3RvcmVzIGNhcHR1cmUuIE9ubHkgYSBjb21wbGV0ZSBzeXN0
ZW0gcmVib290IGNsZWFycw0KdGhlIGxhdGNoLg0KDQpIQVJEV0FSRSAmIEVOVklST05NRU5UDQot
IE1hY2hpbmU6IExlbm92byBUaGlua1BhZCBUMTYgR2VuIDIgQU1EICgyMUs3Q1RPMVdXKQ0KLSBB
UFU6IEFNRCBSeXplbiA3IFBSTyA3ODQwVSB3LyBSYWRlb24gNzgwTSBHcmFwaGljcyAoUGhvZW5p
eCwgQUNQIDYuMykNCi0gQklPUzogUjJGRVQ2OVcgKDEuNDkpLCBFQyBSMkZIVDQ5Vw0KLSBBdWRp
byBEZXY6IFBDSSAwMDAwOjY0OjAwLjUgWzEwMjI6MTVlMl0gTXVsdGltZWRpYSBjb250cm9sbGVy
IChyZXYgNjMpDQotIEFMU0EgQ2FyZDogY2FyZCAyOiBhY3A2MyBbYWNwNjNdLCBkZXZpY2UgMDog
RE1JQyBjYXB0dXJlIGRtaWMtaGlmaS0wIFtdDQotIERyaXZlcnM6IHNuZF9wY2lfcHMsIHNuZF9w
c19wZG1fZG1hLCBzbmRfc29jX3BzX21hY2gsIHNuZF9zb2NfZG1pYw0KLSBLZXJuZWxzOiBsaW51
eC1pbWFnZS02LjguMC0xMzYsIDYuOC4wLTEzOSwgNy4wLjAtMzEsIDcuMC4wLTM0LWdlbmVyaWMN
Ci0gRGlzdHJvOiBMaW51eCBNaW50IDIyLjMgKFVidW50dSAyNC4wNCBub2JsZSBiYXNlKSwgUGlw
ZVdpcmUgMS4wLjUgLyBBTFNBDQoxLjIuMTENCg0KVFJJR0dFUiBQQVRURVJOICYgVElNRUxJTkUN
CkNvbnRpbnVvdXMgMzAtbWludXRlIGJhY2tncm91bmQgbG9nZ2luZyAocmVjb3JkaW5nIDJzIHNh
bXBsZXMgdmlhDQpwdy1yZWNvcmQvYXJlY29yZCkgcmV2ZWFsZWQ6DQoxLiBTaG9ydCBzdXNwZW5k
cyBzdXJ2aXZlIGNsZWFubHk6DQogICAtIDEyIGF1dG9tYXRlZCBjeWNsZXMgb2YgMjBzIHMyaWRs
ZSBzbGVlcDogMCBmYWlsdXJlcy4NCiAgIC0gOCBkYXl0aW1lIHN1c3BlbmRzIGFjcm9zcyA0IGRh
eXMgb2YgdXB0aW1lIG9uIDcuMC4wLTMxOiBhbGwgbm9ybWFsDQphY291c3RpYyByZWFkaW5ncy4N
CiAgIC0gMjEgZGF5dGltZSBzdXNwZW5kcyBhY3Jvc3MgMyBkYXlzIG9uIDcuMC4wLTM0OiBhbGwg
bm9ybWFsIGFjb3VzdGljDQpyZWFkaW5ncy4NCjIuIFByb2xvbmdlZCBzMmlkbGUgc3VzcGVuZHMg
cmVwcm9kdWNpYmx5IGxhdGNoIHRoZSBmYWlsdXJlIHVwb24gcmVzdW1lOg0KICAgLSBPbiA2Ljgu
MC0xMzk6IFJhaWxlZCBpbW1lZGlhdGVseSB1cG9uIHdha2luZyBmcm9tIGFuIDhoIDQ3bSBvdmVy
bmlnaHQNCnNsZWVwLg0KICAgLSBPbiA3LjAuMC0zMTogUmFpbGVkIGltbWVkaWF0ZWx5IHVwb24g
d2FraW5nIGZyb20gYSAxNmggMTJtIHdlZWtlbmQNCnNsZWVwLg0KICAgLSBPbiA3LjAuMC0zMTog
UmFpbGVkIGFnYWluIHVwb24gd2FraW5nIGZyb20gYSAyaCA0Mm0gZXZlbmluZyBzbGVlcC4NCg0K
T0JTRVJWRUQgRkFJTFVSRSBTSUdOQVRVUkVTDQpDYXB0dXJlIHN0YXJ0cyBhbmQgRE1BIGFkdmFu
Y2VzIGF0IDQ4IGtIeiBTMzJfTEUgd2l0aG91dCBlcnJvciwgYnV0IGF1ZGlvDQpkYXRhIGlzIGZy
b3plbjoNCi0gVW5kZXIga2VybmVsIDYuODogRXZlcnkgc2FtcGxlIGlzIHBpbm5lZCB0byBuZWdh
dGl2ZSBmdWxsLXNjYWxlDQooMHg4MDAwMDAwMCAvIElOVDMyX01JTik6IHVuaXE9MSwgZnVsbC1z
Y2FsZT0xMDAuMCUsIERDPS0xLjAwMDAsDQpBQy1STVM9MC4wMDAwMA0KLSBVbmRlciBrZXJuZWwg
Ny4wOiBFdmVyeSBzYW1wbGUgaXMgcGlubmVkIHRvIGEgc3RhdGljIGNvbnN0YW50IHZhbHVlDQoo
LTAuODMzNyAvIDB4OTU0OTUxODMpOiB1bmlxPTEsIGZ1bGwtc2NhbGU9MC4wJSwgREM9LTAuODMz
NywgQUMtUk1TPTAuMDAwMDANCg0KU1RFUFMgVE8gUkVQUk9EVUNFDQoxLiBFbnN1cmUgaW50ZXJu
YWwgbWljIGlzIHdvcmtpbmcgbm9ybWFsbHkgKHJlY29yZCBzYW1wbGUgdmlhIGFyZWNvcmQgb3IN
CnB3LXJlY29yZCkuDQoyLiBQdXQgbWFjaGluZSBpbnRvIHMyaWRsZSBzdXNwZW5kIGZvciA+M+KA
kzggaG91cnMgKGUuZy4gb3Zlcm5pZ2h0IHNsZWVwKS4NCjMuIFdha2UgbWFjaGluZSBhbmQgcmVj
b3JkIGZyb20gdGhlIEFDUDYzIERNSUM6DQogICBhcmVjb3JkIC1EIGh3OkNBUkQ9YWNwNjMsREVW
PTAgLWYgUzMyX0xFIC1jIDIgLXIgNDgwMDAgLWQgMyAvdG1wL3Rlc3Qud2F2DQo0LiBJbnNwZWN0
IHNhbXBsZXMgaW4gL3RtcC90ZXN0Lndhdi4NCg0KRVhQRUNURUQNCk5vcm1hbCBhbWJpZW50IGF1
ZGlvIHdpdGggdGhvdXNhbmRzIG9mIGRpc3RpbmN0IHNhbXBsZSB2YWx1ZXMgYW5kIEFDLVJNUyA+
DQowLg0KDQpBQ1RVQUwNCkV2ZXJ5IHNpbmdsZSBzYW1wbGUgaW4gdGhlIGJ1ZmZlciBjb250YWlu
cyB0aGUgaWRlbnRpY2FsIDMyLWJpdCBpbnRlZ2VyDQp2YWx1ZS4gQUMtUk1TIGlzIDAuMDAwMDAu
IGRtZXNnIHNob3dzIHplcm8gZXJyb3JzIG9yIHdhcm5pbmdzIGZyb20NCnNuZF9wY2lfcHMgb3Ig
c25kX3BzX3BkbV9kbWEuDQoNCkZBSUxFRCBSRUNPVkVSWSBBVFRFTVBUUyAoV0hJTEUgSU4gUkFJ
TEVEIFNUQVRFKQ0KMS4gTW9kdWxlIHJlbG9hZDogU3RvcHBpbmcgUGlwZVdpcmUsIHJ1bm5pbmcg
YG1vZHByb2JlIC1yIHNuZF9zb2NfcHNfbWFjaA0Kc25kX3BzX3BkbV9kbWEgc25kX3NvY19kbWlj
IHNuZF9wY2lfcHNgLCBhbmQgcmVsb2FkaW5nIGRvZXMgTk9UIHJlc3RvcmUNCnNpZ25hbC4gQ2Fw
dHVyZWQgZGF0YSByZW1haW5zIGNvbnN0YW50Lg0KMi4gUENJIGZ1bmN0aW9uIHVuYmluZC9yZXNj
YW46IFN0b3BwaW5nIGF1ZGlvLCBpc3N1aW5nIGBlY2hvIDEgPg0KL3N5cy9idXMvcGNpL2Rldmlj
ZXMvMDAwMDo2NDowMC41L3JlbW92ZWAsIHNsZWVwaW5nLCBhbmQgaXNzdWluZyBgZWNobyAxID4N
Ci9zeXMvYnVzL3BjaS9yZXNjYW5gIHJlLXByb2JlcyBjbGVhbmx5LCBidXQgY2FwdHVyZSByZW1h
aW5zIGZyb3plbi4NCjMuIEhhcmR3YXJlIFBvd2VyLUN5Y2xlOiBBIGZ1bGwgcGxhdGZvcm0gcmVi
b290IG9yIHBvd2VyLWRvd24gY2xlYXJzIHRoZQ0KbGF0Y2ggYW5kIHJlc3RvcmVzIDEwMCUgbm9y
bWFsIG9wZXJhdGlvbi4NCg0KUk9PVCBDQVVTRSBBTkFMWVNJUw0KQmVjYXVzZSB0aGUgQUNQNjMg
YXVkaW8gY29wcm9jZXNzb3IgaXMgaW50ZWdyYXRlZCBvbiB0aGUgQVBVIHNpbGljb24sDQp1bmJp
bmRpbmcgdGhlIExpbnV4IFBDSSBlbmRwb2ludCBkb2VzIG5vdCBjeWNsZSBzaWxpY29uIHBvd2Vy
IG9yIHBlcmZvcm0gYQ0KRnVuY3Rpb24tTGV2ZWwgUmVzZXQgKEZMUikuIER1cmluZyBkZWVwIFNv
QyBwb3dlciBzdGF0ZXMgKHMwaXggLyBNb2Rlcm4NClN0YW5kYnkpIGFjcm9zcyBleHRlbmRlZCBp
ZGxlIHBlcmlvZHMsIHRoZSBoYXJkd2FyZSBQRE0gY2xvY2sgZ2VuZXJhdG9yIG9yDQpGSUZPIHN0
YXRlIG1hY2hpbmUgZHJvcHMgb3V0IG9yIGRlc3luY2hyb25pemVzLCBhbmQgdGhlIGRyaXZlcidz
IHJlc3VtZQ0Kc2VxdWVuY2UgZmFpbHMgdG8gcmUtY2xvY2svcmUtYXJtIHRoZSBBQ1AgaGFyZHdh
cmUgcmVnaXN0ZXJzLg0KDQpXT1JLQVJPVU5EDQpDb25maWd1cmUgc3lzdGVtZCBmb3IgYHN1c3Bl
bmQtdGhlbi1oaWJlcm5hdGVgIChzbGVlcGluZyBpbiBzMmlkbGUgZm9yIHVwDQp0byAyIGhvdXJz
LCB0aGVuIHRyYW5zaXRpb25pbmcgdG8gUzQgaGliZXJuYXRpb24gZm9yIGxvbmcgc2xlZXBzKS4g
UzQNCmhpYmVybmF0aW9uIHBvd2VyLWN5Y2xlcyB0aGUgcGxhdGZvcm0gb24gd2FrZSwgY2xlYW5s
eSByZWluaXRpYWxpemluZyB0aGUNCkFDUCBjb3Byb2Nlc3NvciB3aGlsZSBwcmVzZXJ2aW5nIG9w
ZW4gZGVza3RvcCBzZXNzaW9ucy4NCg==
