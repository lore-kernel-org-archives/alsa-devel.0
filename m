Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE92C46CD2
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Jan 2024 22:31:39 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2365E825;
	Wed, 24 Jan 2024 23:31:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2365E825
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1706135497;
	bh=PCrHwPg2G5V7E2X4Qce8/DylK2OW7jzKtpLHD9K/e6o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=GB7+d+ziuZ8vSZ5pRKcMHBQpCBViOdIUGAAhFSbo4OzvzlYx4gIteolHSXCPVefIn
	 0fF5T8jzbghiAMo0Iu2ibpZkTKvbLr91NCW3g6fzk5J4tyNbTNkSzuOGxV2Jp/ZQU7
	 N3l6yM71ZMQWxMI4IcnWqrsITKLqKB+cOQCZ5GyA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EC7C6F8057F; Wed, 24 Jan 2024 23:31:01 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4CF91F80588;
	Wed, 24 Jan 2024 23:31:01 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DBCA7F8028D; Wed, 24 Jan 2024 23:30:53 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 38576F8022B
	for <alsa-devel@alsa-project.org>; Wed, 24 Jan 2024 23:30:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 38576F8022B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20230601 header.b=FnRKduz1
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a313b51cf1fso26581266b.0
        for <alsa-devel@alsa-project.org>;
 Wed, 24 Jan 2024 14:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706135448; x=1706740248;
 darn=alsa-project.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PCrHwPg2G5V7E2X4Qce8/DylK2OW7jzKtpLHD9K/e6o=;
        b=FnRKduz1TbIudo5ZfkrFzktX3GmXEb8oUB5dfTF7IHm+w3EWHupbnJQo2tHdxKygnE
         iMVMOhK0/qQ0NYbFtgkHTsDpkufzQwqlGpmvM76lLl4bpWsGFS2VzMXHK00SLBJqvkaw
         Hc4SLuH3Q3Bt5GJ3kTCGFL6G/wPR9C+E6l0oyRn+gVJuvzr+oJeXf2OQr6rndbGG8iyG
         bXXSt7YbT29KYDmoge77SJOOALBAwpgv/r+tvY8Q+/TrNx1kcGBfBz1anT9Rzzq/ANRi
         2C02PRWkEsiKK3HUgekFgZia5S1rU4jri19uHochI4q4qcVKkca0/ZSIY7YpQATQBUrm
         mFeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706135448; x=1706740248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PCrHwPg2G5V7E2X4Qce8/DylK2OW7jzKtpLHD9K/e6o=;
        b=q7htzYzNE9JLMyDScvIG9pI+tYN78BAFg7ONOexAABAvJgF4blky1aESIG67N0poiQ
         piV27pJEdw9tT29J5JHaVX4c0+txzgsHb2uhCjkBPKhWKZrY3S4aEw5FR+r26SJpiUe2
         TR4lBjVKlhY+3fpXOHjC5djbazEf17BXOY+6qux1rpJI2tJCHR4I3YVRKyAkU7t+mN58
         8sbptQaD6ddgIA9OzjWEUNWNdVHuyjG9w4wVFCDXvGjAA9W35Y1Fwh0JAOJcQzfj1L5K
         YYC6U0N7XtZeaNjQSJnsu+MbA5GFqJee7ouFJf6STSrKWgV7RpLLmYJZvtvkeU3ioI/1
         mY5w==
X-Gm-Message-State: AOJu0Yxdh4BPsY24LhYmN5zHNcGolfLyCIPOnCak/4BBZT0PBKja/tP7
	kPNTyC9GgFaY31/bi+X8HkWr2lKJtbbUVIw3J6TBJV1cRCOK2fmqHJpy5hv5TV1XzK1Md+H6CyC
	uAJOtURTV4TT9RHYhKSqy48S8Jt4=
X-Google-Smtp-Source: 
 AGHT+IGdsLu1owlneuqVPizU9u4+SoEDlau3fgfMISZmQkmtNqJZiH9gg2dcieUYQSVJ++3zMHn1JRijWb4RPbKARz8=
X-Received: by 2002:a17:907:7897:b0:a2d:54a8:5864 with SMTP id
 ku23-20020a170907789700b00a2d54a85864mr304717ejc.31.1706135447793; Wed, 24
 Jan 2024 14:30:47 -0800 (PST)
MIME-Version: 1.0
References: <20240124165558.1876407-1-ckeepax@opensource.cirrus.com>
 <20240124165558.1876407-5-ckeepax@opensource.cirrus.com>
In-Reply-To: <20240124165558.1876407-5-ckeepax@opensource.cirrus.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 25 Jan 2024 00:30:11 +0200
Message-ID: 
 <CAHp75Ve3FDPU39oMBkTVLUeUeYDUDx6eaBnikWf6Tx-JM8PujA@mail.gmail.com>
Subject: Re: [PATCH 5/7] ASoC: cs42l43: Use USEC_PER_MSEC rather than hard
 coding
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Message-ID-Hash: 6WEOGW7GGNFG6X6OHK4RDLGJZTJJIYC3
X-Message-ID-Hash: 6WEOGW7GGNFG6X6OHK4RDLGJZTJJIYC3
X-MailFrom: andy.shevchenko@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6WEOGW7GGNFG6X6OHK4RDLGJZTJJIYC3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, Jan 24, 2024 at 6:56=E2=80=AFPM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:

Commit message?

> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Otherwise, LGTM,

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

--=20
With Best Regards,
Andy Shevchenko
