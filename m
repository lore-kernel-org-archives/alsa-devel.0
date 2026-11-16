Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A155606A891
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Nov 2026 13:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=bhPw5Mpr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=j56LsaYI
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E57D260219;
	Mon, 16 Nov 2026 14:47:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E57D260219
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794836864;
	bh=rrx4hFhuLoJiwRyWvPIjG++pDJtUwwNZ4lUWY+pJ/vk=;
	h=From:Date:Subject:To:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=bhPw5Mprd81kURw0lml6xp60Pr9V0WP3wAGgRHPBPgUlKqmbEX0m5fnZQ2vIPm2ZU
	 JALvgC7t3Z5v0Zzx/YJaLmJQgKccNLX98SqcDbeCkxb9o5C/HL2TyScalJQ1rKsXvK
	 nYKG3q6AYvan/PmM6gRz/VxRe73+5mdAP4FMwwUw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DBCD0F8065C; Mon, 16 Nov 2026 14:46:47 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id AAB42F80671;
	Mon, 16 Nov 2026 14:46:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AE8D1F80510; Mon, 16 Nov 2026 11:17:53 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.49
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1794824272;
	b=MLazJun4WfzfS+desWworV5mB+CO2m5rcr/fsX/HuT+Lcgo+GyTd2i6S2UVXwHduUzDb
	 FavYqFwTt9yl7ngeLVZj9QyLeV22jzwjLSzEfCYl3dbHxKvAN67V4BlnfGHOsJoaAY0Y3
	 el5s7A46ik4HIg2ypsxTVQY+jFXSuYEochGjg5MNcBxmpXO55mTYHyTEjitGMgI5nxrGb
	 M/6GtGQWnMyJt8083DyLyo7EyWH6Cix6EGV5SRcRwHsET3mW6uJZ7BpnP7+1spov63h3d
	 911iPbK+u+CEH0PIS2w2pFIUFizthBdYmmBZ/YNFtkCz2mtgZec1VkjY9ENFw2OjEgQ==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794824272;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To;
	bh=/e5/Wx1KHeCI14gt58fRTNC7f5DvoCmhtL8Y60A1XFk=;
	b=Yd93mIG6/oIezHfK+MGKXg7JEd6incD5qkaVHHPzIL4VKZ0k9s21uXdq1ME2t1eD+eQh
	 Rs2KjYK1Emy5Q6PzE12dLuB1yqcffi1p0tIzo3X+S5b3trsZHJNbz5Z5B91jbM7KL39z8
	 cbo1NceIa+OxX0hX2XlA5N73hXsQdDNpLboT1TN6Ttx100D7IaULbIRdAe1UYc2k8a5Yj
	 y9p2R3R1JwpQXAV4pa+rak6Rd0PtTRud1mwpAzN6/44n2uND5ncyqw+t+E01e8IeqwMJP
	 yoB1/eSdxOeh4hdwRUAqn9bzOCwjtakOteUOh2W4hnPH2lJAI1VKPwrvd27Dck/o/Dg==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com
 header.a=rsa-sha256 header.s=20260707 header.b=j56LsaYI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.49
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com
 [209.85.167.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 33EACF8024C
	for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2026 11:17:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 33EACF8024C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=googlemail.com header.i=@googlemail.com
 header.a=rsa-sha256 header.s=20260707 header.b=j56LsaYI
Received: by mail-lf1-f49.google.com with SMTP id
 2adb3069b0e04-5c0a520df2eso3249816e87.0
        for <alsa-devel@alsa-project.org>;
 Mon, 16 Nov 2026 02:17:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794824270; cv=none;
        d=google.com; s=arc-20260327;
        b=mPIOMf8OqP6DmZ2ZU3qqkWUift9fZJbgniwQpcn2mYRcg1LbB0AHfOciWJPEFA3jrX
         PZEYGCwYnolTYblOmNWqivBOke8QPIHC7y0lLCBiZulGhjsY6v4cszg0gpP1x8jA0yM1
         2d+xaIKOb+uajd51eORz/QpFwJYd57NTB1tDnrg/KFV0t9sZcdSav4EJiX+2wck1iYal
         /YGDDgL9YSigktIZ0347bXP70aeO2yGZZyj4qxSAgBBi1FzXOj9pMnJ5Yl4NTdDd/rYP
         qBLx5H5/xQEjrrdw01+PCqBXI++Umpw1Zf3NoHWMW0Jjl6ClJdABjIf0hgwj2tbVhGa7
         WwXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=tcHFY60o13H4m7C8LD3+ClkxoZIMX2gssCllBP8nPZk=;
        fh=sLHHi6iQqDuXDvpzwAa2YApxG5d10s8aTTD4+ni0PbE=;
        b=XgwioVwpBaOO+3Xqo175pluEHEA8roL89rMYlJyhNzLBGPzFi7iMs9TsNB+fMMtwEO
         W8xXQUgEX2hda7A1QfBEBrzlisBmfWkTjoc3wfrzddUhZUtfdFAMWPWNpUjU5JraZU+Y
         AbKJs/Y/6NtLn46Y6eTzaJXK1+igzFjUhkd9hleDpizDe+SiptHr2jw8P84hH86BQDQb
         kox2M/iQMO36U6jxO9Tf1J4411LvGsdQ2zGMFEhjI2xBjoSeHexlBnxnXaqvP3+dunl2
         GiFNM/se1NyRjjXkPYpP9FjPQR9Y1wdDOAKRD8ZUrI75oLTZQhh54Z5GO6zr9grs1GW5
         CehQ==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1794824270; x=1795429070;
 darn=alsa-project.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=tcHFY60o13H4m7C8LD3+ClkxoZIMX2gssCllBP8nPZk=;
        b=j56LsaYIbYgClyb0FbSHAx7/phx/l2IW9peEB1MXJ/fRS1Cjfc7RoZFlcJyR3BBLeR
         RVbsChb07NjTAXsCaY4nNMMeMiWNhx9DwfXj1qKGhVzdCUIsuOkUdtya9q5prhywWajQ
         YlV7ybeN/6SHRtPOQqizZPFXyDh4g9I95MvOUJ2TK3bevGYtqjiUTPTKmJkDx9N7TF/E
         YvnUulHOWTJFpKbO82DuCX2CqQZfwmRD4R3Od91sGRlhL4GFzrrnLFVlXlVrxhfrwEt5
         zMj2Arvm2bj3094P3JiIC6z/PCKyx8PMZxfLddnsZoHvZiMd1ZES40e0ACIxvyQPUlhj
         vz5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794824270; x=1795429070;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tcHFY60o13H4m7C8LD3+ClkxoZIMX2gssCllBP8nPZk=;
        b=KSfemRS5Fw5QWnK+qBfzmqJ8U8KUdDu03ytvpIxH+NoRxxjzV4hgCq7pnOC+0FTSib
         U9xinrGNEalalN7FugHB4nlgPnxcjzuQ7oHWyUULYI3cskr1g1fke5F2H1q/EahECHM7
         lNWuPskzEMjEm1LE/djLFVBKbslhxykgTVN6pioboG7ZEJF3EdDuabq8tj6EtWCJOtxQ
         5PZlV4rJmsS7Fd8e/PpgiRWa3TbAnRxrNiylTTd4frA7gUdnUShjE2GCmMKwDuQDxm3V
         ah+eJfRi43GnCCRS9eaAbkRRaA3bg3C7klnmU3a+fvRmVkJEV2KFT07VbaTyKW1qmJ+g
         1uKw==
X-Gm-Message-State: APuU4Z8nkD6COtOqDsZqHm+T3ePcuHDgPh1viptsRXnl6reUDF1CVyPl
	f36wJp+FUFHaLZlfIic3lpuCGHurvZ0R2a1fxsw0OAh7v3689dUt6bLJgUoMbAmssth4GW77V5N
	mBtcpPeyU4stuiyoug7u7RLZ9o8UsSla0ykbahaA=
X-Gm-Gg: AYBFou2We9GXeCoHo3iklsv159piA1CNc4zyOrQTE1DgcBNkX4iTJMtEasHFw5MumYF
	gZ3LISJkEzjLKVp6Sc9CxqCRgcFAx1I3Ci7jzRkmMtkGUtolFvGV2nEYQnWUo1IBuo24yejeOej
	8/S9CNO1eHzXPJ0DP0F4fluPDQlSofgpmI8M9R1G5iE0emFwZA+jdw2xCffxO3V17fKeYfzIRpf
	HSAbxVDSU3qh7f+ex262lT5y8GIPTqjj/r7YvXpYlyvSmM8fCqY8yShlnL+YyIeWDXIbo0LubHG
	h3sLL/Yl1/wzqSV+DDiIZOVHdS4U+032m6TtyV9hdOvjU32+mMg9jtkEO6+ns2mSpOMYpaC+M9D
	KcYRgsjVvxMT3DIhgBbY5GTBAR2jFg5p7wG5FCMTPhCRjcDBefRJnG1A27aQRjhE+EOx/G9M2Cs
	cn0sIU0WCfQGYOqYpU/4PBN/3uz9s=
X-Received: by 2002:a05:6512:2523:b0:5c1:4a79:b9c1 with SMTP id
 2adb3069b0e04-5c17079aad6mr3538883e87.22.1794824269320; Mon, 16 Nov 2026
 02:17:49 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Peter Ross <peter.r9191@googlemail.com>
Date: Mon, 16 Nov 2026 11:17:38 +0100
X-Gm-Features: Aa3M54pMzxl5HjhBuCbJF3nLBr3M_dKVg99kzdZJCFx88Th7d-vm0bPa3I6LqNg
Message-ID: 
 <CAFt4o5NwqywePKrA=oj6xxxx=sa4bwywawh2AO5NdUv7tWNDpA@mail.gmail.com>
Subject: [PATCH] ALSA: hda/realtek: Add quirk for Razer Blade 18 (RZ09-0484)`
To: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
X-MailFrom: peter.r9191@googlemail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: 6HMYK5V3UODJWH3DST6JPL6DLPPDCN3V
X-Message-ID-Hash: 6HMYK5V3UODJWH3DST6JPL6DLPPDCN3V
X-Mailman-Approved-At: Mon, 16 Nov 2026 13:46:28 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6HMYK5V3UODJWH3DST6JPL6DLPPDCN3V/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

VGhlIGludGVybmFsIHNwZWFrZXJzIG9uIHRoZSBSYXplciBCbGFkZSAxOCAoUlowOS0wNDg0LCBB
TEMyOTgsIHN1YnN5c3RlbSBJRA0KMWE1ODozMDA3KSBhcmUgc2lsZW50IGJlY2F1c2UgdGhlIHNw
ZWFrZXIgYW1wbGlmaWVycyBhcmUgbmV2ZXIgaW5pdGlhbGlzZWQuDQpBcHBseWluZyB0aGUgZXhp
c3RpbmcgQUxDMjk4X0ZJWFVQX1JBWkVSX0JMQURFMTZfMjAyNSBmaXh1cCBmaXhlcyB0aGlzLiBJ
dA0Kd2FzDQp0ZXN0ZWQgd2l0aCBgaGRhX21vZGVsPTFhNTg6MzAwZWAgb24ga2VybmVsIDcuMy4z
Lg0KDQpgYGBkaWZmDQotLS0gYS9zb3VuZC9oZGEvY29kZWNzL3JlYWx0ZWsvYWxjMjY5LmMNCisr
KyBiL3NvdW5kL2hkYS9jb2RlY3MvcmVhbHRlay9hbGMyNjkuYw0KQEANCiAgU05EX1BDSV9RVUlS
SygweDFhNTgsIDB4MjAyMywgIlJhemVyIEJsYWRlIDE2ICgyMDI1KSIsDQpBTEMyOThfRklYVVBf
UkFaRVJfQkxBREUxNl8yMDI1KSwNCisgU05EX1BDSV9RVUlSSygweDFhNTgsIDB4MzAwNywgIlJh
emVyIEJsYWRlIDE4IChSWjA5LTA0ODQpIiwNCkFMQzI5OF9GSVhVUF9SQVpFUl9CTEFERTE2XzIw
MjUpLA0KICBTTkRfUENJX1FVSVJLKDB4MWE1OCwgMHgzMDBlLCAiUmF6ZXIgQmxhZGUgMTYgKDIw
MjUpIiwNCkFMQzI5OF9GSVhVUF9SQVpFUl9CTEFERTE2XzIwMjUpLA0KYGBgDQoNCmBTaWduZWQt
b2ZmLWJ5OiBQZXRlciBSb3NzIDxwZXRlci5yOTE5MUBnbWFpbC5jb20+YA0K
