Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BFA6C3DA4A
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Aug 2024 11:11:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4EAF22BCD;
	Fri, 16 Aug 2024 13:11:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4EAF22BCD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1723806679;
	bh=dYYl/zEU3YloE/8ql4/5xTV82V5JC5BtMXJrSGS5L1Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=vkqMQ36HgR5FGwOUYTBKCDq/plJXaxfbx+8/ywBVwCbB6zUPeI0kAEjWt7KRYtYxQ
	 uiHlvSXyNd/wM2X4vn7m44zzwiISJ6aRhTrd7kfsxmbV7fSAeNcwvACToathqAQzj0
	 0iGM/VSoOMto/gmBXN0/1oipd8VtKmNogQUxqzzU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1243EF806B6; Fri, 16 Aug 2024 13:08:59 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 79016F806C8;
	Fri, 16 Aug 2024 13:08:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2E36DF80423; Thu, 15 Aug 2024 14:59:25 +0200 (CEST)
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9F2EDF800BF
	for <alsa-devel@alsa-project.org>; Thu, 15 Aug 2024 14:58:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9F2EDF800BF
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=antheas.dev header.i=@antheas.dev header.a=rsa-sha256
 header.s=default header.b=JCvUmjU4
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com
 [209.85.208.181])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 3DD942E088A5
	for <alsa-devel@alsa-project.org>; Thu, 15 Aug 2024 15:58:47 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1723726727;
	bh=dYYl/zEU3YloE/8ql4/5xTV82V5JC5BtMXJrSGS5L1Q=;
	h=Received:From:Subject:To;
	b=JCvUmjU45rF8A1SmgqRRKtq4H61pr+Ft5HikdT+HA/UFWViEC1FKk+QSePAA4x4FA
	 tCNB/PveF4YDHfnZijBBLXYFwZNsXzKpm/2vMSkLDWl7gysOUwYYkfcdnrw6cQOGSW
	 gAFJRi1DOszS4yvFZPQg1aQQzqhoxNneLwgHYtW0=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.181) smtp.mailfrom=lkml@antheas.dev
 smtp.helo=mail-lj1-f181.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f181.google.com with SMTP id
 38308e7fff4ca-2ef2fccca2cso9748871fa.1
        for <alsa-devel@alsa-project.org>;
 Thu, 15 Aug 2024 05:58:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCWcLx0PFesISiGXcOeQEIwQcz3TaZ5UGMaDIHHgCBkG0EvAEwlJ30ajjFpyj6X81JYKD9DZHfFNkB9eRWnd+SEAiQdoufxTCLfL3Ek=
X-Gm-Message-State: AOJu0YzujfRV1ci4ZsHpuN/A8W1leKq3pcusjyFWuErMtWOsXF7DUQ0Z
	phekUt/G6J9xsGg+owkfxOMah3qxwPwQZhAjSIodDM9cqcF6jQvgBPPNPrsMR9YxK1I/L+hawB/
	uQsC+zO8i+X4zv36FFLVTzkalbpU=
X-Google-Smtp-Source: 
 AGHT+IFrou51Z8pUpDNFuNloIRa7tvrDFTxZla2TjlRq66JSbVpmhQS3SCT25qlL0RD+hlDEygE8KGpnL8+Hsiab9LE=
X-Received: by 2002:a2e:7a18:0:b0:2ef:2d3a:e70a with SMTP id
 38308e7fff4ca-2f3aa1c6705mr32595871fa.18.1723726726491; Thu, 15 Aug 2024
 05:58:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240812045325.47736-1-jlobue10@gmail.com>
 <87frra2ocp.wl-tiwai@suse.de>
 <CAGwozwF7aR5UypRTe7tNFR+xOfQ=rhqkzYUgBcYH4_LvO9_zXQ@mail.gmail.com>
 <87cymedlrt.wl-tiwai@suse.de>
In-Reply-To: <87cymedlrt.wl-tiwai@suse.de>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Thu, 15 Aug 2024 15:58:35 +0300
X-Gmail-Original-Message-ID: 
 <CAGwozwEyhhDspUTyUwd9fqacKwoUwJJ=ZOHpJ5UfsaBs1kcx_w@mail.gmail.com>
Message-ID: 
 <CAGwozwEyhhDspUTyUwd9fqacKwoUwJJ=ZOHpJ5UfsaBs1kcx_w@mail.gmail.com>
Subject: Re: [PATCH] ALSA: hda/realtek: tas2781: Fix ROG ALLY X audio
To: Takashi Iwai <tiwai@suse.de>
Cc: Jonathan LoBue <jlobue10@gmail.com>, perex@perex.cz, tiwai@suse.com,
	shenghao-ding@ti.com, kailang@realtek.com, alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	derekjohn.clark@gmail.com, luke@ljones.dev, benato.denis96@gmail.com,
	Kyle Gospodnetich <me@kylegospodneti.ch>,
 Jan Drogehoff <sentrycraft123@gmail.com>,
	Richard Alvarez <alvarez.richard@gmail.com>,
	Miles Montierth <cyber_dopamine@intheblackmedia.com>, "Chen,
 Robin" <robinchen@ti.com>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <172372672773.4733.11902800016949798287@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean
X-MailFrom: lkml@antheas.dev
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: HHEDH55QMLKY2YADGG6QOBDZL6YZXBOO
X-Message-ID-Hash: HHEDH55QMLKY2YADGG6QOBDZL6YZXBOO
X-Mailman-Approved-At: Fri, 16 Aug 2024 11:06:22 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/POMJRAI4UVFXB5YDIGISOZNSEUE7OLD5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi everyone,
I created the following Draft MR for the Ally firmware files:
https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/272

Please comment on it at your leisure. I will remove the Draft status once
all the sign-off members verify it for correctness.

@Shenghao: can you restate publicly the license of the firmware files and if
there are no issues, sign-off on the MR?

Best,
Antheas
