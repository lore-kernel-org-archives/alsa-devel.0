Return-Path: <SRS0=QPpS=4H=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F753C34050
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Feb 2020 15:28:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C16DF24672
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Feb 2020 15:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="NNuAGi94";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="qLusgcn5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C16DF24672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 23F0B1689;
	Wed, 19 Feb 2020 16:27:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 23F0B1689
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582126089;
	bh=WBEhmHayKn74PP2FrDEXfZ52+SetbMM5DmezNZqwTKs=;
	h=References:From:To:Subject:In-reply-to:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NNuAGi94FnR8D4cpbrD2Ac8hX9v9nz8TQv5vlqsgxcBx46zQeJ8O6YCRbusv6gT7e
	 2qE8uek6NRCQM17KwVElxwZXvCCPwdntJqMpY2I1PmrXlwGH2TdAnqiXpw1hpF0Ifb
	 0UgA6XF+b1grq/DZC0QkBW+VjhY3Qwm2LxKZ/luI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A4E07F80276;
	Wed, 19 Feb 2020 16:27:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 56C94F80277; Wed, 19 Feb 2020 16:27:17 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A9DABF801F5
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2020 16:27:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A9DABF801F5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com
 header.i=@baylibre-com.20150623.gappssmtp.com header.b="qLusgcn5"
Received: by mail-wr1-x434.google.com with SMTP id w12so1056361wrt.2
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2020 07:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version;
 bh=xr4KCy9LjDDC7/U990Djpkp9h3+bHMJP/CuHnuQdnQo=;
 b=qLusgcn5KbYtblag3ItTqC/KfOT7gzpTagmfjrK72YZF2YtNKk3oZEojedbhvN+otQ
 NEw7qy5LvmAR9XYW/jvQ7BZup7ygvcw9HJGfzOe2jjfV3JjpMms5H1AQH9OFclJqgTuS
 uLKOer0DPMTVNsYuCC8CMbDhrv2Yt2TU+K14mhJTBIVNS9Sgu/AzaY7NEIm0yZK5c5dI
 y7LmmO8BuUCbitrvTF3q6PsbBkNkDXMFCW8Bc/F0qZb2yJex04sRccZWuXsWVFAxyjQ+
 31i/D8+L5aA1lXOsIVSGa3AuErQys1+UHlCv2IFT4kJ4ICrkBI5uiDC2hVNEkZuDCdgX
 u88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=xr4KCy9LjDDC7/U990Djpkp9h3+bHMJP/CuHnuQdnQo=;
 b=akrv+jGTTku0FiVEkVUvBZ7wdt22BImpJgjmvIvEuS1ZrShE0Nhg5zYupfQli5WDHn
 JClblV3rUX69324MSVzmF3Jyh6dUmCjzIcRrvYjW33V4J048t8QWaUAN5Da6kzYsqJaS
 NiP0pa76MMtvgczL3KUHgSvIqe71VSfYBo0eah0EdgeZMVwamzOBkxxVycah21YFbzqc
 k8UZBcnG20IINY3QTx6sBiUGshasz4T2K94c3hhtZa8kh51K2Wyz3tTiOuvaQ/f0Zf4y
 srX8nOk4yyTrfBorDN1THUQqj8ogjP6Kfa4sKkEKDzd9Xnk70ShCc+PbO+yh0kWulxtG
 +IaA==
X-Gm-Message-State: APjAAAWG4A5ai3+QnaLJ8ZMdgBEce/b1vfxJDqtUr2tFzlmrzWoWkyn8
 PvFCOxMQA3TJ3deR+fZVjqK4LLXVA7g=
X-Google-Smtp-Source: APXvYqwYyZmGAEcdumWTLBen7hSlFvchvYN2atMg/kgjiqNCGQr0Y4/R6fWnH8UUM7Wz8uv/QQZF1A==
X-Received: by 2002:adf:e50f:: with SMTP id j15mr36883719wrm.356.1582126033825; 
 Wed, 19 Feb 2020 07:27:13 -0800 (PST)
Received: from localhost (cag06-3-82-243-161-21.fbx.proxad.net.
 [82.243.161.21])
 by smtp.gmail.com with ESMTPSA id t81sm241883wmg.6.2020.02.19.07.27.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2020 07:27:13 -0800 (PST)
References: <20200219133646.1035506-1-jbrunet@baylibre.com>
 <20200219133646.1035506-3-jbrunet@baylibre.com>
 <20200219145500.GC4488@sirena.org.uk>
User-agent: mu4e 1.3.3; emacs 26.3
From: Jerome Brunet <jbrunet@baylibre.com>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: meson: add t9015 internal DAC driver
In-reply-to: <20200219145500.GC4488@sirena.org.uk>
Date: Wed, 19 Feb 2020 16:27:12 +0100
Message-ID: <1ja75ey4vj.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Kevin Hilman <khilman@baylibre.com>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
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


On Wed 19 Feb 2020 at 15:55, Mark Brown <broonie@kernel.org> wrote:

>> +	/* Channel Src */
>> +	SOC_ENUM("Right DAC Source", dacr_in_enum),
>> +	SOC_ENUM("Left DAC Source",  dacl_in_enum),
>
> Ideally these would be moved into DAPM (using an AIF_IN widget for the
> DAI).

I can (I initially did) but I don't think it is worth it.

I would split Playback into 2 AIF for Left and Right, then add a mux to
select one them if front of both DAC. It will had 4 widgets and 6 routes
but it won't allow turn anything on or off. There is no PM improvement.

Do you still want me to change this ?
