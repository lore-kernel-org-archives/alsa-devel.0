Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2887C5B56A
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Aug 2026 09:27:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 83EE860257;
	Wed, 12 Aug 2026 11:27:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 83EE860257
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786526843;
	bh=FFUwGYmC3wBtLNtXGxPSqGoDBNSHUV86S/2Ea6M2ms0=;
	h=From:Date:Subject:To:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=IFP4+aNxQ6CKywiLeb/19gdUuCfqjYSfpvBYmzLtNk1aizYR4t3LMiCTDCS7KmEs7
	 EJuT3dVleXxdNFNrYdIJW9cLU4w73IMw/znYAfH6hVieZc/rcREwR19tOY5ATH/5Yh
	 6RkMKksTd6gcfLVzHT+kIoViZ7NHlB2mAMiAEpZ8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1EBC1F8065C; Wed, 12 Aug 2026 11:26:14 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B810EF8065E;
	Wed, 12 Aug 2026 11:26:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 53AE0F804CF; Wed, 12 Aug 2026 05:17:31 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.51
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1786504650;
	b=HZEwzYinc8zp76NAjtmNm8A61CMPnFHWuSVvoy7xv55nQcXGFWFypOpH2TgOftP/oWQZ
	 0nsQxWxDZbOQY+nDdvwbPZhLg7pTNzLrVRY2HO47tK6772qwgKp3sERTCKmTcqAGHGgPJ
	 +IqvN0YmhxV5iAieLGT5UZwCSkiO0kYFxHKgD33G7AZgQhkaY5oyuZi7ErBYm9M9FMKz9
	 EtmTMJ1fnz99A4wjhLtQdJEnSrzDCC+AHR6rQTfKrx2ZwEwAkx2S/1xTEtSgMDWWemow+
	 /lSJBQR+qQf/K0NA2lIIScjxuZ+UCeg1qaWufICYenqfUZOASA6fStB1leAKnjjkmVw==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1786504650;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To;
	bh=Ca3OrkP5TtrWrejJouHokC1Bq/Z1BH2fjyMnDQZHEDY=;
	b=heQ3r0LJd+nJEIUHsgnyVzjbS8tEKIGJVW92hwbC3yP6MD1lv74xnXNad+N+oWBJ9gHF
	 Lb7pRI7aBONhahSU18HLgrOGSkkbP4zTC34Cf6TAx1vF7l26eGjk+wedz0+HQ3YRASxuG
	 1Vusd/R2Sa7GhU2e7PFKLhzmR7VH8vR2x+t5apconw2yNF3fUi7U33ouncUR/pHr+h2at
	 8oNgqF2vEPWJ7NJ3Jrcpt9IHoWBuUBt64ruf0rc5nB27AguXrtysWarPL5XFMdstQJCiD
	 z48XBpnDTXSJk2EjNiKcTyopQGLu672DFkWr/m0fjOF5Zx+7RxIAPzimxs97DUO6W9Q==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=ZWBBWmDv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 793EDF8014C
	for <alsa-devel@alsa-project.org>; Wed, 12 Aug 2026 05:17:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 793EDF8014C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=ZWBBWmDv
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4956242332dso3723125e9.2
        for <alsa-devel@alsa-project.org>;
 Tue, 11 Aug 2026 20:17:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786504648; cv=none;
        d=google.com; s=arc-20260327;
        b=GeSnRik9eDbF6J7QDof7j/aDLRoObj6LHORr0WOrCV97yqbLvFUYK1tZKlekY5/Ifd
         /7QwFji10Ap+YT6iclDv6vKqdiwJovW2cHuZjF5i8C4V+6pGLMhh3dF//AaJKHti15hR
         a6pkIGYsO1IQSShEKSipe4yPARrUxhzWVyKaXTxywpgaT1rkrlfU6crOFQKuCNVSDTJ/
         Qe4klcUafXXo913j/w5xWhDOAuqcDlI0LIkejDamASKWhhexhP9x9sQAVHa1TCKRwZrI
         fhTrFgPGTIyqPQx8NqbMBTRpMvMG5chtTMFRCH6kXMdJo/eenRqxcUqfiJ5A0PQr7mf6
         J/iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=m9bn9ADndJ5XMHAgPwtvBEjvxsd0Ha9XaHjFB/LxzKc=;
        fh=s1h8N4U4ASgl2diPi2yKjEmsLSTuwbZjYBDYrAXLUvw=;
        b=itkisJUy4zMD28AprjAFrrIo0IwbCH0fBTK8ccF/a5M58xQGMpoAILV0PjEw+0een6
         EMeVseZdvZAqcWeZ3yQXznSlMsg/HH8sxo2QybFrO1cvHgXXAyO/SEEK6xLD/bbzlfgF
         pGM28vK6LerRC1zRvHtU9oG1vIMaFYdOfLAsjNMkUC5OrE2MAuDLVyC6PjQdsTbOJEja
         UK9lVlGBRfyN1NT5IN4fmEhAl2sLVT09qTf/MO20PfgwUgkdLfA1EeGskT512DV6S9Gu
         fx6Of7e56xdnd5Kg18vND10bJGE85jA8k1X+4/IMVKD8o2FIm1sAKgDhCfR1MRS9i4+X
         kedQ==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786504648; x=1787109448;
 darn=alsa-project.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=m9bn9ADndJ5XMHAgPwtvBEjvxsd0Ha9XaHjFB/LxzKc=;
        b=ZWBBWmDvSOLcImTpz8hoQ3WUVXjHPXWMeAh3setLWZUrqXd4FmN6iINcbx7xq6hSpJ
         tR7xhMp/ecDEg2biZJWJUhPOZXUaKxD15oSZtkx/g2AB1LuudafhtOQDiW7uLXGdRb08
         5a8U1YMfB+08Zr0M0r7H9fMoRGGH2pAuIBKhGaTvhGmeWAUBgn+q5HvJApz5u8vdbl4X
         gH8NhGrRra/qsRSAaMZ9r57eE5+VTl6KJGXrmE1fuIQXMJvOXBK7M6Yzy5bkk2LkLP+D
         LxWcE2Ms9LnCiYQD/Ky30fc5KQGjtIGTgfuETyUmvkufv1W+SAPLz8JnbzxvUWINOfjW
         8yLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786504648; x=1787109448;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m9bn9ADndJ5XMHAgPwtvBEjvxsd0Ha9XaHjFB/LxzKc=;
        b=QvBRHhy1AWYp0B/ExjE4XejKZ1JJyHs474qm9Uoyr6kRK0/7HWGfQIHx5WCEgSLH5b
         68oHnA6+DQKOgpxhuenfWtgkKpk90y1OdDG7hJwi58TJGM5cz8I9WMP765lsqmZYubk4
         2+DoK4xk5Lm45rmGzg0q+w+ZgyJevhQi0BgfcKtiapN//Mt9VSs0QVQOw/YDc4ljOSL2
         LBj53zLSSff3iK7viLyCnVa9EzyIUaQFDPTMg/nlcg7HtLyel8vvfeo/ToV7HJ53GMLB
         NRZbnaIerTlibVt9C87fPynAjvxA7rAfbli/uVaLKhpMSCChNb53O4M9yggSI3Gyp8Ex
         VoYw==
X-Gm-Message-State: AOJu0YyHMwAfGz/fu7ZiIda6WVmDQP+fajE/BcanB0BsFWgBCtvCULAR
	ZCtlGYvm/xEys8/mwOFAHYU6Dr1bGM5Sg/4PiwIU1MVrPDDDN4TYt+DtYx9Fbhelo67tdS+vME9
	97doZiOGkMUEr3iUA9pH5axj9TiQp9jJ2zMwE0LbLmw==
X-Gm-Gg: AR+sD129gGIVHfcVsqpWqY+nogZwwrVstY1H5k9/SI/lFPNDm9QnLLcoiKG+0+8wP2Q
	zlT8GUaxi9oW88tztEkMO81JbQAUeqSaLvyNKCiLiFZ11/G3ot6a4MIgHeXqQNw0OAN7o+35MeJ
	A2nRlLuQxzVudWvxEQaF+okpDz+WN8ItuJNEoMNt76GR0b39P23NIsOmWlOUZVXZU3cvfbpqugl
	huJkgxoq9CydIcnBaIMAtEKSh/+qKrJppPravBWtTePm4VLbzVbBPRpp4HWSzVqVM1Gs0nua+/2
	6nJThet31joeZyhjoTqjH/u7sEjl1juuPH6uDJfXYRFoKdpe9SMUO/wZ
X-Received: by 2002:a05:6000:46ce:b0:481:511c:8d45 with SMTP id
 ffacd0b85a97d-48152caa71cmr1193753f8f.20.1786504647767; Tue, 11 Aug 2026
 20:17:27 -0700 (PDT)
MIME-Version: 1.0
From: Samuel Nick <shimulkhan213@gmail.com>
Date: Wed, 12 Aug 2026 09:17:16 +0600
X-Gm-Features: AUfX_mwriPf0NGnki6huwTgpuKd4Utd_gVRfRYtM6DYeitRSkeMXIzOIdEwAX4k
Message-ID: 
 <CAMNbJUFNnHjh7frs7vfk2+WK6CP_5=cfG9L4Y3UtQjArGOP_xQ@mail.gmail.com>
Subject: [PATCH] ALSA: usb-audio: Add Native DSD support for CVJ Lila
 (262a:1ab2)
To: alsa-devel@alsa-project.org
X-MailFrom: shimulkhan213@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: ETSXXJI65KU7FTFDO4MQGUFZ4A6KAC74
X-Message-ID-Hash: ETSXXJI65KU7FTFDO4MQGUFZ4A6KAC74
X-Mailman-Approved-At: Wed, 12 Aug 2026 09:26:05 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ETSXXJI65KU7FTFDO4MQGUFZ4A6KAC74/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

UGxlYXNlIGFkZCBOYXRpdmUgRFNEIHN1cHBvcnQgZm9yIHRoZSBDVkogTGlsYSBVU0IgREFDIChT
YXZpdGVjaCBVU0INCmNvbnRyb2xsZXIpLg0KDQogICAtDQoNCiAgICpWSUQ6UElEOiogMjYyYTox
YWIyDQogICAtDQoNCiAgICpJbnRlcmZhY2U6KiBBbHRzZXQgNCAoRFNEIHJhdzogRE9QPTApDQo=
