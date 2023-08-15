Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5C2AC001DB
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Aug 2023 00:41:23 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C6D51828;
	Tue, 15 Aug 2023 02:40:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C6D51828
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1692060080;
	bh=BFEEoZloe5ITMDE28fd+0EwqIiRKfU7N8KCKBkAICVc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=T6+PHTt5/AL/fnvM7Oz2965hkGlAhBAwsINTk/Vuw0dqLHHS/DD68o399hgOTYDn6
	 vD9iMiMNKc6wB1/oxOvk8eyolECQkwwbRWPI2P7nbYvPOfPXRBQ6KGerdFxVTNghsa
	 Ykv/gp76wkS0kULyQPW9+ATsI7vCHVTKdYzIqalQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AF02CF801EB; Tue, 15 Aug 2023 02:39:55 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1FF27F800EE;
	Tue, 15 Aug 2023 02:39:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2EE34F80254; Tue, 15 Aug 2023 02:39:50 +0200 (CEST)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9A9E8F800EE
	for <alsa-devel@alsa-project.org>; Tue, 15 Aug 2023 02:39:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9A9E8F800EE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20221208 header.b=ELGRZool
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-26b4cf4f7b9so1107429a91.1
        for <alsa-devel@alsa-project.org>;
 Mon, 14 Aug 2023 17:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692059981; x=1692664781;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XyLUo0F/r0ICJfUehZEVhryKQob46/OPKXU152Ye/RY=;
        b=ELGRZoolJR5Eb+DgIWoE8MYkwcCm5O+WJfDDZqTOG+ib3i3CPZcNE4UnWcBnRR33le
         +beolJrxrOrjuSaHyX2aTtoVkoWiJKWlzfQQO1QhGU2n2sb9RKlMCHB8UsbC4gt/bdNS
         3wtIKSDTE+23dS3tMBBN7tVbnnv3z23qMiFnd4zcrXuAXzySGgQJrejMiInXhIaI8pGf
         XZPLIuqKPWFq76paYxn3oYDnkyVvWpX4FNvY0y5JYkHdsSDKs5w5NIackld8AQ75Megq
         3fH+8EXjU8i5QL06QXKY6FOi+6m0ag3679NSP42dXZC3WEUq9DLbvlilzA1B2F6RQhyB
         2Rig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692059981; x=1692664781;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XyLUo0F/r0ICJfUehZEVhryKQob46/OPKXU152Ye/RY=;
        b=Ax5wXxss5r48CoF3St3a0XuFNxJ9IVGu3pyzhT6TGcYiQKsqg+T6KogwKdAgtRA2Dx
         ACEjlU8uA6dWsnFnb94/gDsnNvF5+5XWzBLv7kcNp3KkUt3r2R3jt8nXXGT+Se79q4cB
         tMpjxZhTTjNbZSCgaU0NqhBQrCijBKImgdIwV/eqdkLS0MxxyZXp5BUNLbiT3SrKGiEV
         3AmrFBG/MDbPv/OTTy4Dd+hiK5mGwLlXz5fisxJAln83wpBCNRce1Fg5LKGXsdisBJ4m
         5rp4gkFJy1eK2ykvMFC+ustp7m6zL9Dycl3GzOGmOl5J5ebceRu9N7CJ7FyLNsIH8I3D
         a02Q==
X-Gm-Message-State: AOJu0Yyi3dnw4eTf0ERY0eJ6DKy7jwM+q3uB5Ven01fOF5JBFwlSAELw
	q5xL/674ap+In5sR+D8ixNkHhKJgSIUOWw5zFFVT/A==
X-Google-Smtp-Source: 
 AGHT+IHWi6XscUrvW3D3Yi7LZ/VJRVJUG2UUp67NFztZjNmmzT9PpkruDoSe4OOy9o/WRSYwHdClA23LzMs8GpaF9zw=
X-Received: by 2002:a17:90a:49c9:b0:269:48dc:c1a1 with SMTP id
 l9-20020a17090a49c900b0026948dcc1a1mr8344875pjm.17.1692059980842; Mon, 14 Aug
 2023 17:39:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230814012637.487602-1-bradynorander@gmail.com>
 <b5fcf342-dd26-2cad-26dc-f6774f627668@linux.intel.com>
In-Reply-To: <b5fcf342-dd26-2cad-26dc-f6774f627668@linux.intel.com>
From: Curtis Malainey <cujomalainey@google.com>
Date: Mon, 14 Aug 2023 17:39:29 -0700
Message-ID: 
 <CAOReqxiOwYCyOEn-kPYDtkWwE_e_uZ1p0fFZKh82cADhqDfC0w@mail.gmail.com>
Subject: Re: [PATCH] ALSA: hda: intel-dsp-cfg: Add Chromebook quirk to ADL/RPL
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Brady Norander <bradynorander@gmail.com>, alsa-devel@alsa-project.org,
	broonie@kernel.org, cezary.rojewski@intel.com,
	amadeuszx.slawinski@linux.intel.com, perex@perex.cz, tiwai@suse.de
Message-ID-Hash: MEO243ZBLRPT6HXWDHF2H65AIJPRKM5T
X-Message-ID-Hash: MEO243ZBLRPT6HXWDHF2H65AIJPRKM5T
X-MailFrom: cujomalainey@google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.8
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MEO243ZBLRPT6HXWDHF2H65AIJPRKM5T/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

T24gTW9uLCBBdWcgMTQsIDIwMjMgYXQgNDo1NeKAr1BNIFBpZXJyZS1Mb3VpcyBCb3NzYXJ0IDwN
CnBpZXJyZS1sb3Vpcy5ib3NzYXJ0QGxpbnV4LmludGVsLmNvbT4gd3JvdGU6DQoNCj4NCj4NCj4g
T24gOC8xMy8yMyAyMDoyNiwgQnJhZHkgTm9yYW5kZXIgd3JvdGU6DQo+ID4gQWxkZXJMYWtlIGFu
ZCBSYXB0b3JMYWtlIENocm9tZWJvb2tzIGN1cnJlbnRseSB1c2UgdGhlIEhEQSBkcml2ZXIgYnkN
Cj4gPiBkZWZhdWx0LiBBZGQgYSBxdWlyayB0byB1c2UgdGhlIFNPRiBkcml2ZXIgb24gdGhlc2Ug
cGxhdGZvcm1zLCB3aGljaCBpcw0KPiA+IG5lZWRlZCBmb3IgZnVuY3Rpb25hbCBpbnRlcm5hbCBh
dWRpby4NCj4NCj4gQWZ0ZXIgY2hlY2tpbmcsIGhlcmUncyBhIGxpc3Qgb2Yga25vd24gQ2hyb21l
Ym9va3MuDQo+DQoNCkkgdGhpbmsgeW91IGZvcmdvdCB0byBoaXQgcGFzdGUgOikNCg0KQ3VydGlz
DQo=
