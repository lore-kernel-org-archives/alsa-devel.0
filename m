Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED0E606A31A
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Nov 2026 12:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=pC7pem7L;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=udCLgFkf
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7990760219;
	Mon, 23 Nov 2026 13:04:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7990760219
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1795435494;
	bh=27BuKKlZ6oJTfj9fX/JiYTQgclr8+Sr38MnO8WhXl8Y=;
	h=From:Date:Subject:To:Cc:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=pC7pem7LaRlrqyXkCOjo0jXufB/9l7Z6ZtglqG2N2xMeqoAqPbb3ImQjWj3jB0OVO
	 AV6YjkgmzyKM+vAPEVZaQDkD+Ll7Nk+y85CjaJ93XIIPyuJ9mXKe94y5Gjp81+NN6k
	 plQYxhfK7UMAW7JGfd9PBQNBA/6i2H2gI24kRhgg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AB5B5F806F0; Mon, 23 Nov 2026 13:02:49 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6827EF806F9;
	Mon, 23 Nov 2026 13:02:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4823CF80537; Sat, 21 Nov 2026 15:15:28 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.51
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1795270525;
	b=rqO3OV7rWFAwQsleOVUa2XEeZup0ujUGU5VjpYYF0mpx0q932TRtJJI1coFxlDVm3lN2
	 /J+e6ywuioKrPVQzm8tgPGOQTW0MiY6TxEidXlt7ydeknoo+Re9meYqXAXofAwW5JTeP9
	 iIxGWUyn8xJT/Dz0IlNZcbfqzc9MEV+obCQATW7GXbRk5T7NacUWZqrpPo66RQVtvGkj7
	 M9o08aagFBH1IPPXHu9tYzxSHa7v+wOYPKX39wiJ8jyb6emOBB+kpCYqLpZSDD2/POo1Y
	 vFoBbsuQtcfaVZyag9cDVEURIjsBhNn3IRfhqf+ydWXuoDNENGVkjQj0u4VLTMpz+Uw==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1795270525;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To;
	bh=IhBDvPOP2HargptFs6KJ62L18GU5BTi3xjd86letKFQ=;
	b=K3j4Fr5XdGB8d9MOpGeI1tgbSlJGABm2luJWNjrPZ/q0RxAYasSUiAmOylBoDKyowxxX
	 af/FjMJl5zxsNWGyDoCu/KrjG/LPGdc0fGvudKxawX73e5wC+2NSBKepVw6yXXAjSQZet
	 YKZjjN5VWgDZxCbJyl6gzYJnsZJ1lQgvw1xThIJS+ht5NDQy/80uWW/E3kjNbbv8nxvYS
	 8Olwwp2EquX5bkp/0ijSJvkWPtVafIfEeq1XMXKD7/9w8LkEDx1496Vdwihmn2jYng4Bq
	 84K/hR8w7Vmbjtx7lgzSmqO+GvLaD3j1WiK279hS0OemohHBJzGR7gC/fpFeLT1uXfA==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=udCLgFkf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.51
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com
 [209.85.219.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7BD91F800C1
	for <alsa-devel@alsa-project.org>; Sat, 21 Nov 2026 15:15:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7BD91F800C1
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=udCLgFkf
Received: by mail-qv1-f51.google.com with SMTP id
 6a1803df08f44-920fed989b2so19181696d6.2
        for <alsa-devel@alsa-project.org>;
 Sat, 21 Nov 2026 06:15:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795270522; cv=none;
        d=google.com; s=arc-20260327;
        b=oWBeWej45FqWUUvT46A6dC3BuI9v3DVnRRIyKqBrbBA0TLtQ6A15Ab1Pa1JxqwwIpX
         4dnF+ZUJdwrfXzeT4HRPjApjHTFuZiBBqm2XtjD0Nqsu4A7STpIKi3jFaL0xUiC4gjv+
         V5IVGNrXAQ1SxUSkB/8hv0w6FX5ku/idscqr77AqvNTceSUIPXooEg0p7nyDivlXs5kg
         1nSvuG39+hzcvm4Sh9LSLkT3EEnaFJuQne9V8EJkjCyzEBYAluX6t4rUvv3X0njLgRqa
         aO212Fq6yL0VV8rT0vD81TDWISUjsnPl/sTkzgrfzv6dQCn/IizelIboQpvOdKgEbrur
         05VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=IhBDvPOP2HargptFs6KJ62L18GU5BTi3xjd86letKFQ=;
        fh=b9QZcgcipxDImMVQmp3V8QZfvzNGN/FeUPxjlXqQBOY=;
        b=Kiickjk7bNQHneb/zy+BDt9UoJ1s2LhXV6pNuZnLAuN8wrfso7iGb3YBg+adWrfQfa
         iOtl6OvID2rHF1zwfuqQh0zZ7s4TpgNILhFQFl4++igEQB6/au7S5qOqm/lz1wVVRshf
         DMK55larB4X++KwHRTpUDYXs6L0rzFNlhaYcGxLPBaiXjGn+WzgvvAQxeM712LVxINyM
         Un6X65k5JWQlM55zpEBqy90PbN84gkcaqNEYmYB3EqGOryw7toqiyK+gbXKmD5lWZfaY
         oYYT43RYY3tUCVBZPNUZH+pk14IK+qbOFMTtfrX6EqVHZcl50jP0G8PCqPmCyM+BV9X6
         tE3g==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795270522; x=1795875322;
 darn=alsa-project.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IhBDvPOP2HargptFs6KJ62L18GU5BTi3xjd86letKFQ=;
        b=udCLgFkfKu2ck8nzk+Zvg5DdPQVq2ghWAz2B8ruzCv9LWsZyIb+imea90BY/40PmSk
         uJ6Orl2YfJJwmlVArtbMSDcF4jOoe55UUKVgZsHDSs+vbuxAqyuyiKOwIYDUWxXyYWM6
         1emWk6MhFS8xzRMENUq1fEFeejvmqhq1lefca+1kUW3uor8dRe+XycQ5wGZvm5TF81be
         qXh9UFLiTUuzwaFe3KestqPVJR6+gACrGe3xncfbtRo7ZTmKjUXCI71P9BNPd2RcixC8
         v5H5qXwNr6Mv8DSmcc7HnxFZ6HASSO0morfj6ckHDP2X8Zgk8glIneDyqyt2iK0tzXg2
         V4zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795270522; x=1795875322;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IhBDvPOP2HargptFs6KJ62L18GU5BTi3xjd86letKFQ=;
        b=nmhDDEw5kVwLOS2S987vL0iTlZ+E4IbcjU/ttvCAaWhQpgsiqNJPssPhv26TYtLv43
         udnVtNjKcPw5sDJnASSmokRdBQfr4Pe11QUo4NR1IajzQo64sxYq+6dqg3tV7TEwaeI1
         NQ+aFzULWnTNqYPrB4H0xteV5YYOak8V57RPK1Rdkt/mnxUutRZtylsd8VWhtCC5kK9b
         6v+nCO5VFoycohlmBTDio43h8G8tBafeEUTWAQqcAIdmeGEA+MJCvxs/htBI735jzWTX
         TkIoHGlyNQeJuuteMQYeQ2t4NuPs0gsoKMsVclTN0ej+UCMtg3VnMCRmY6OE0XrvyWB3
         w8JQ==
X-Gm-Message-State: APuU4Z+oFUX2b2b1jtExmdYX1SKtrxOeHyBBdAQbJFQD+Sk6TVEcJhw5
	v6s/bZ7N+lVvyIN0SVndxcOxekjsp/mKIQywcAiRBOa+uxr44y4o/RF2et+TIZTqnhOv4ET0i9d
	kFviPdwsoEX2k3GLgjhOHlfC9F1jO19o=
X-Gm-Gg: AZFdTZfWYyeQSuFBa5aY2GwnD7GSDg3O/PM9Z2MXg7rGY6BZlfmIdwAiMqVQBbNpnaR
	ixXczTesNE5x0CEcmU2GwqHriLiXJxqeyBAzwQavy79XIX2hAknF4b0nQW5uL7Ao7KIlIqw08Bp
	x3r+ER8Ivdl+jlfT43JHhFTn5xp8EeHvCK/BQWh77dYrrUN/JHKH/MXjZsgXaxaV+FwfbGr1+mg
	iGldU8xONnHau/UODVdptKTz5/bQ6RHLVN6s2Wca9cnw0NYuyzoW6NGJ8RxfOYyerWwazohRm7E
	XOj+nusAySSXTrounjasG8t/1flyn7V+gQlb9jvfRr66B7vLEpq14sBx5gJdkB5IDx9N4XpEu7a
	POkCFXURjrXNscJcwJJwYy/cUbbqqkeO00uxGXCFxdnsfhFC3SMA1NY8/lpJXFk0v8ygDaqQ=
X-Received: by 2002:a05:620a:8395:b0:949:849d:e3c7 with SMTP id
 af79cd13be357-949baa0b24bmr971581185a.33.1795270522137; Sat, 21 Nov 2026
 06:15:22 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Shripad <shripadsuper@gmail.com>
Date: Sat, 21 Nov 2026 19:45:11 +0530
X-Gm-Features: Aa3M54rSywwxCYFRifHXJux0bOAyyP23uTB9ue8cdcoknUk--FOLBP1S2Uwy438
Message-ID: 
 <CANMwtEiqf9yTbzvX3CojcbOKqnMocyMqYiv4vNUAjdP_qzZ_dQ@mail.gmail.com>
Subject: RT722 SDCA speaker silence on Acer Swift Pro SFP14-55 (Emdoor
 2782:5900) - thesofproject/linux#6040
To: jack.yu@realtek.com
Cc: alsa-devel@alsa-project.org
X-MailFrom: shripadsuper@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: PHARA2HVM6EFFIC6RUORPTZ2OZDSFDRQ
X-Message-ID-Hash: PHARA2HVM6EFFIC6RUORPTZ2OZDSFDRQ
X-Mailman-Approved-At: Mon, 23 Nov 2026 12:02:14 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PHARA2HVM6EFFIC6RUORPTZ2OZDSFDRQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

SGkgSmFjaywNCg0KSSdtIHJlYWNoaW5nIG91dCByZWdhcmRpbmcgdGhlIFJUNzIyIFNEQ0EgYXVk
aW8gY29kZWMgb24gdGhlIEFjZXIgU3dpZnQgUHJvDQpTRlAxNC01NSAoTWV0ZW9yIExha2UgQ29y
ZSBVbHRyYSA1IDEyNUgsIEVtZG9vciBib2FyZCAyNzgyOjU5MDAsIFNvdW5kV2lyZQ0KMDI1ZDow
NzIyOjAxKS4gQW5vdGhlciBvd25lciAoc3ViaHJhbmlsLTE3OSBvbiBBcmNoKSBhbmQgSSAob24N
ClVidW50dS9ab3JpbikgaGF2ZSBiZWVuIHRyYWNraW5nIGFuIGlzc3VlIHdoZXJlIHRoZSBpbnRl
cm5hbCBzcGVha2VycyBzdGF5DQpjb21wbGV0ZWx5IHNpbGVudCBvbiBMaW51eCwgZXZlbiB0aG91
Z2ggYXVkaW8gd29ya3Mgbm9ybWFsbHkgb24gV2luZG93cyAxMQ0Kb24gdGhlIHNhbWUgdW5pdHMu
DQoNCldlJ3ZlIGJlZW4gZG9jdW1lbnRpbmcgb3VyIG1lYXN1cmVtZW50cyBvbiB1cHN0cmVhbSBp
c3N1ZQ0KaHR0cHM6Ly9naXRodWIuY29tL3RoZXNvZnByb2plY3QvbGludXgvaXNzdWVzLzYwNDAu
DQoNCk9uIExpbnV4ICh0ZXN0ZWQgYWNyb3NzIDcuMCwgNy4zLCBhbmQgNy40LXJjMSB3aXRoIFNP
RiAyLjE0LjEgYW5kIGZ1bmN0aW9uDQp0b3BvbG9naWVzKSwgdGhlIGVudGlyZSBTb3VuZFdpcmUg
dHJhbnNwb3J0IGFuZCBEU1Agc3RyZWFtIGFyZSBjb25maXJtZWQNCmFjdGl2ZToNCi0gU291bmRX
aXJlIERQMyBpcyBydW5uaW5nIGFuZCBzdHJlYW1pbmcgKEJhbmsgMSAweDMzMCA9IDB4Mywgc3Rl
cmVvDQpjaGFubmVscyAwLzEgYWN0aXZlKS4NCi0gaG9zdC1jb3BpZXIsIGFsaC1jb3BpZXIsIHJ0
NzIyIERQM1JYLCBQREUyMyAoUFMwKSwgRUFQRCwgYW5kIEZVMDYNCih1bm11dGVkIGF0IDAgZEIp
IGFyZSBhbGwgcG93ZXJlZCBhbmQgcm91dGVkLg0KLSBIZWFkcGhvbmUgb3V0cHV0IGFuZCBETUlD
IGNhcHR1cmUgd29yayBjbGVhbmx5Lg0KLSBTb3VuZFdpcmUgcmVnaXN0ZXJzIHNob3cgYW1wX3Bk
ZT0wLCAweDIwMDAwMGY9MHgwMDQwIChiaXQgMTQgY2xlYXIpLCBhbmQNCjB4NWYwMDAwYj0weGRk
ZjguDQoNCkEgZmV3IHRoaW5ncyB3ZSd2ZSB2ZXJpZmllZCBzbyBmYXI6DQoxLiBPbiBhIHdvcmtp
bmcgV2luZG93cyAxMSBpbnN0YWxsIG9mIHRoaXMgbGFwdG9wLCB3ZSBzZWFyY2hlZCB0aGUgZW50
aXJlDQpkaXNrIGFuZCBEcml2ZXJTdG9yZTogdGhlcmUgYXJlIG5vIHBsYWludGV4dCBDQUUgZmly
bXdhcmUgZmlsZXMNCigqcnQ3MjIqLmRhdCwgcnQ3MjJfUkFFXyouZGF0LCBvciBSQUVfWFUuYmlu
KS4gT25seSBSVEtEQVRfMjc4Mi5kYXQgYW5kDQpSVEtEQVRfR0VORVJBTC5kYXQgZXhpc3QuDQoy
LiBJbiBBQ1BJIChTU0RUMjQpLCBEZXZpY2UgKEFGMDQpIGhhcyBubyBfUFMwLCBfUFMzLCBvciBH
cGlvSW8gcGlucywgc28NCnRoZXJlIGlzbid0IGFuIGV4dGVybmFsIG1vdGhlcmJvYXJkIEdQSU8g
aG9sZGluZyB0aGUgc3BlYWtlciBhbXAgaW4gcmVzZXQuDQozLiBBQ1BJIEFGMDQgZG9lcyBzdXBw
bHkgYSAyMjAtYnl0ZSBCVUYwIEZJVCB0YWJsZSBjb250YWluaW5nIDUtYnl0ZSBpbml0DQplbnRy
aWVzIChpbmNsdWRpbmcgdGhlIDB4NWQ6MHgxMDAwMC4uNCBibG9jaykuDQoNCkNvdWxkIHlvdSBo
ZWxwIGNsYXJpZnkgdHdvIHF1aWNrIHBvaW50cyBmb3IgdXM/DQoxLiBJcyBDQUUgYmluYXJ5IGZp
cm13YXJlICh0aGUgcnQ3MjJfUkFFX0FjZXJfU0ZQMTQtNTVfKi5kYXQgZmlsZSByZXF1ZXN0ZWQN
CmJ5IHJ0NzIyX2NhZV9sb2FkKSByZXF1aXJlZCBmb3IgdGhlIGludGVybmFsIENsYXNzLUQgYW1w
IHRvIHByb2R1Y2UgYmFzaWMNCnNvdW5kLCBvciBpcyBzcGVha2VyIHBsYXliYWNrIGV4cGVjdGVk
IHRvIHdvcmsgd2l0aG91dCBpdD8NCjIuIERvZXMgdGhlIFJUNzIyIHJlbHkgb24gdGhlIEFDUEkg
QUYwNCBGSVQgc2VxdWVuY2UgKG9yIGEgc3BlY2lmaWMgdmVuZG9yDQpzZXF1ZW5jZSBmb3IgcmVn
aXN0ZXJzIGxpa2UgMHg1ZCAvIENMU0RfQ1RSTDIgLyBNSVNDX0NUUkwyKSB0byBnYXRlIENsYXNz
LUQNCm91dHB1dCBvbiB0aGlzIEVtZG9vciBoYXJkd2FyZSwgYW5kIGhvdyBkb2VzIFJlYWx0ZWsg
cmVjb21tZW5kIHRoZSBMaW51eA0KZHJpdmVyIGhhbmRsZSB0aGF0Pw0KDQpGdWxsIGFsc2EtaW5m
bywgcmVnaXN0ZXIgZHVtcHMsIGFuZCBkbWVzZyBsb2dzIGFyZSBjb2xsZWN0ZWQgaW4gdGhlIEdp
dEh1Yg0KaXNzdWU6DQpodHRwczovL2dpdGh1Yi5jb20vdGhlc29mcHJvamVjdC9saW51eC9pc3N1
ZXMvNjA0MA0KDQpXZSBib3RoIGhhdmUgaGFyZHdhcmUgcmVhZHkgYW5kIGFyZSB2ZXJ5IGhhcHB5
IHRvIHRlc3QgdGVzdC1wYXRjaGVzIG9yIGR1bXANCmFueSByZWdpc3RlcnMgeW91IG5lZWQuDQoN
ClRoYW5rcywNClNocmlwYWQNCg==
