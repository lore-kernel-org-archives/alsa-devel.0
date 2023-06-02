Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD9BC77B7A
	for <alsa-devel@archiver.kernel.org>; Fri,  2 Jun 2023 07:00:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E0D521FE;
	Fri,  2 Jun 2023 08:59:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E0D521FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1685689208;
	bh=GyY9J6rQp4cPjbTr/YEgV3e4S74jAvAlSN8bu3VpIW0=;
	h=From:Date:Subject:To:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=eM1OiLpLiZ1unFBG2yicDXQia1MHZtmQkIt/3DTLGEHvTJx2sHS3sAxL1T70a2820
	 eAllNRx1Cj5smpL3Bazck/pZVgq73cYK99MqxaBXUc30i5I4tZjXOZE7pptyqrhFYR
	 FQUe9z9tZxRKWb9yHaOBSqd5rxWNEgBRS+7uglXs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 74901F80149; Fri,  2 Jun 2023 08:59:17 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 43578F80149;
	Fri,  2 Jun 2023 08:59:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 22475F80149; Fri,  2 Jun 2023 08:58:58 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8FE39F800ED
	for <alsa-devel@alsa-project.org>; Fri,  2 Jun 2023 08:58:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8FE39F800ED
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20221208 header.b=j3OA/9cs
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-4effb818c37so2230312e87.3
        for <alsa-devel@alsa-project.org>;
 Thu, 01 Jun 2023 23:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685689132; x=1688281132;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GyY9J6rQp4cPjbTr/YEgV3e4S74jAvAlSN8bu3VpIW0=;
        b=j3OA/9csKljxEapfMtD0DS057Oi4S+e0eRNu4Pb/B/P1IJUyoePrnQKiUQ8OLb2soM
         TxXdv5VeERUkv0Yq+MMp4tO3OL+zyABtz3UJXIzji8ovCMOJM4rkzcPGgZJFzE/7h3fr
         Xcb3ur0r2rhQzF3YNIq1o1nhd9RMlZ02gpKZR4epCYoq9HioGmAZIfoPVsnpMBhEwhTw
         voYuU8vd3jEutuSlqUYJV+obqiep4hItQoegG7rg/rKs5/Vbh+1c4DZYAr83ytSlUxsr
         jfjaOY2pWWbfIJuzgSp27kkyE3O30dH+ShL7mvpKjnVT3swHqlYo22gslfDaH6W92t9A
         ECbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685689132; x=1688281132;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GyY9J6rQp4cPjbTr/YEgV3e4S74jAvAlSN8bu3VpIW0=;
        b=gANbo6iBbkH2MfoM7/06FpDFTgL1J2IDxBKqGGf8RwdQmJtm9DwHnOVsTFUaFn8o3g
         gTqukSnNJj2JXpCG77TpSaJLPEV4eEkRL2ZKKx2bfAlcvHzr8kUMPYhDxpFBKvxHR9U+
         AmbbNa+cwmsiyRhn8juZ2Cavojhw572ufQhxw41sGa7zcwN2UDr4FdCgDlUpzEKKzVPo
         BS9hGU3sp+OnFiPXsqWC8M4yF3ZmNcbMXknxXuiaYbcVDdqufRFKeXZVOfmc8dqRBrD8
         ozXzAs1OZrkzEFvLShg7+PXotj6+VpN8JGlJGeyC1CAioLvZNyu+5a3rc1Eh2L1uRfpa
         gvbw==
X-Gm-Message-State: AC+VfDwszA+NAaNb81j9g0St3raNeOd/ETyYg/64pC6ESCIrsbXXaWk8
	zM+DMidYIdzBBuq1SxFoItBBqshrp+vXfpTmhvvezZ4dpb8=
X-Google-Smtp-Source: 
 ACHHUZ5CGQK9dHKu++ozLHt5Gwq3Z5NWZmEg2fP8lJuv5ib9orBaegSmLQHHo0C6IC7fzkTq5epG1AU7RSLEiW6rklA=
X-Received: by 2002:a05:6512:98b:b0:4f5:a17f:4897 with SMTP id
 w11-20020a056512098b00b004f5a17f4897mr1208152lft.43.1685689132036; Thu, 01
 Jun 2023 23:58:52 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?Sm/Dq2wgS3LDpGhlbWFubg==?= <jkraehemann@gmail.com>
Date: Fri, 2 Jun 2023 08:58:41 +0200
Message-ID: 
 <CA+Owze4JqFjyYoWO_EDY6BoPAhoXdkXqjBLRMLAG7LsOaCbOXA@mail.gmail.com>
Subject: GSequencer enters MIDI awards a second time
To: alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Message-ID-Hash: CYJZSFHNWZCQJBP7KN36PERFLNATZBSR
X-Message-ID-Hash: CYJZSFHNWZCQJBP7KN36PERFLNATZBSR
X-MailFrom: jkraehemann@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/CYJZSFHNWZCQJBP7KN36PERFLNATZBSR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi all,

Please check and vote for your favorite sequencer:

https://www.midi.org/component/zoo/item/advanced-gtk-sequencer-2?Itemid=3D1=
423

cheers, Jo=C3=ABl

http://gsequencer.org
