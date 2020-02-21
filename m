Return-Path: <SRS0=sxeJ=4J=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E85C35647
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Feb 2020 10:42:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3E9620722
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Feb 2020 10:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Gu4LcJ94";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="jFRFDwIW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3E9620722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2AB11166E;
	Fri, 21 Feb 2020 11:41:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2AB11166E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582281728;
	bh=nRlbY9nRxti2x53sAveYPcZpF/ji/YAmk8jayyBohnQ=;
	h=References:From:To:Subject:In-reply-to:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Gu4LcJ944jWqMfAttcapulIdQFYe06w/7tj7HJh96kbXcQtQntllA09+g/AciSaRT
	 rf35CcuCLVIUOim4iAaoAonWiFp6XgyQJii1UNDB4+AqQiREM+FmMrJMoch8Gqav6g
	 ZaC5CEZan83Yzzn+OeHzp3nGK2IjXHL631Wc+RSU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7A5A5F80240;
	Fri, 21 Feb 2020 11:41:17 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E67B5F8025F; Fri, 21 Feb 2020 11:41:15 +0100 (CET)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9B7A4F8011D
 for <alsa-devel@alsa-project.org>; Fri, 21 Feb 2020 11:41:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9B7A4F8011D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com
 header.i=@baylibre-com.20150623.gappssmtp.com header.b="jFRFDwIW"
Received: by mail-wr1-x441.google.com with SMTP id m16so1423428wrx.11
 for <alsa-devel@alsa-project.org>; Fri, 21 Feb 2020 02:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version;
 bh=nC38uQjZDz3wMRzUDRjp52c9Hy5uCnGBGkiYQn+GewE=;
 b=jFRFDwIWQUOtcfddu0setQkrtBAAsg+QM4SFFjMIfs1t2qtIm0uY7i8crq9De6BNzc
 Dtmli57wfgiv+8hXV/TFGnq9teiaSzgi8MwR1QQlhBXnc+XRDK0+UQ4NT5WD1X+CDrV+
 sJBDa7KYxgxHPFHz4VxYS/x5pJK+EguZ4u447bTGH5MPg5CdBX3mmARRiypZ7ZyZPr2e
 FKJTapXALLySo1mmmxFw0kI+65Y+YiqMiLgxJ67v6SZEA35vfk0WbL1/9p0xWJ6+W3pn
 BizqQ5sktYD0I+kUvccg9I9+ICSSgWYFz/5SmlbSxoi1InaZoRSpRNS//odmTCwExi2r
 spEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=nC38uQjZDz3wMRzUDRjp52c9Hy5uCnGBGkiYQn+GewE=;
 b=QwU6HhWDQSQZ2Ukm8/XB+RjTebEGcHXl9CXWf7uBbqQzfrD6+nOb2G3os62OHgJq+S
 MUkPcgdMFhTNv/RszyLqkS1w6y1IlRt6DGi+vcWRX3bIMP9E7DIaM/QFWsxoD1ehL0ww
 9CQv27Qfl+7K2vrBrcACJAQWkrbPNAl0OHud0WQta15kGHKIOdA9peOTG5LIQmEEMYfO
 SrmAGdp9lBDN7S1zotEhXLyW+hU4KsRNfcWA3fkyw9+YtBtIRqU45sopw/oNQeEqH3Su
 sQR8elGrhaKFUpiRZI1EpWCN8fUzaUpGKxC0K5+7zD6jx1oNNA17L7qDaZRCZ1NpGteC
 V89g==
X-Gm-Message-State: APjAAAX1344wyDyRxF/35qKbMtX8KgDOdpbb/FtiIrpMKle9tejV7Iaa
 SbDP4wdfEj3sJFQHWNcoj0Nx/Q==
X-Google-Smtp-Source: APXvYqy2Z7KXJqoiyg14kzMzg6EQiEnMDyNve9Bd9jHVjubhjmti6d9+RBVLDiLaHEsRbCPSAAbbmw==
X-Received: by 2002:adf:a453:: with SMTP id e19mr45872540wra.48.1582281671269; 
 Fri, 21 Feb 2020 02:41:11 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr.
 [90.63.244.31])
 by smtp.gmail.com with ESMTPSA id q9sm3437231wrx.18.2020.02.21.02.41.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 02:41:10 -0800 (PST)
References: <20200220205711.77953-1-martin.blumenstingl@googlemail.com>
 <20200220205711.77953-2-martin.blumenstingl@googlemail.com>
User-agent: mu4e 1.3.3; emacs 26.3
From: Jerome Brunet <jbrunet@baylibre.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
 alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 1/3] ASoC: meson: aiu: Document Meson8 and Meson8b support
 in the dt-bindings
In-reply-to: <20200220205711.77953-2-martin.blumenstingl@googlemail.com>
Date: Fri, 21 Feb 2020 11:41:09 +0100
Message-ID: <1jtv3k2pfe.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com,
 linux-arm-kernel@lists.infradead.org
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


On Thu 20 Feb 2020 at 21:57, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> The AIU audio output controller on the Meson8 and Meson8b SoC families
> is compatible with the one found in the GXBB family. Document the
> compatible string for these two older SoCs.
>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>

> ---
>  Documentation/devicetree/bindings/sound/amlogic,aiu.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/sound/amlogic,aiu.yaml b/Documentation/devicetree/bindings/sound/amlogic,aiu.yaml
> index 3ef7632dcb59..a61bccf915d8 100644
> --- a/Documentation/devicetree/bindings/sound/amlogic,aiu.yaml
> +++ b/Documentation/devicetree/bindings/sound/amlogic,aiu.yaml
> @@ -21,6 +21,8 @@ properties:
>        - enum:
>          - amlogic,aiu-gxbb
>          - amlogic,aiu-gxl
> +        - amlogic,aiu-meson8
> +        - amlogic,aiu-meson8b
>        - const:
>            amlogic,aiu

