Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF443FEEF4E
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Apr 2026 14:28:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9B845601F8;
	Tue,  7 Apr 2026 16:28:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9B845601F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775572125;
	bh=p6PDNVuYeqvst96/mUiT936U27o1lYUly0E3cP2Nub8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ZQMr71DoK0usB+seJUIhhCRHySAHeVTex9H0zNRmYXNhmusdeQNb2HSxHHnny5lai
	 B7BsrdpnHhQPqoPwNWomn5FS/y4g1OiUs4Y8uoiUCFuf2tXCuAR0DH16qxEoaFJjJj
	 pH2AsbX8al3h14Wy4uQLBTj4F4dsY7CUcUzG+p6k=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 755F6F805F5; Tue,  7 Apr 2026 16:28:13 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 76455F805F3;
	Tue,  7 Apr 2026 16:28:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5B450F80548; Tue,  7 Apr 2026 14:04:02 +0200 (CEST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 66F1CF80154
	for <alsa-devel@alsa-project.org>; Tue,  7 Apr 2026 14:03:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 66F1CF80154
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=InFGFWXk
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-b9c280322e0so590843666b.0
        for <alsa-devel@alsa-project.org>;
 Tue, 07 Apr 2026 05:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775563439; x=1776168239;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w1LDzbcx9hv1SBKLVaF0WXtQT7MEV/JaBSgS16LIvcs=;
        b=InFGFWXkmY16aZC6fAZVHg3FYEApAYPVBcW/KhaPcXxHFFPB6N2cE4FFZJXeZgSerx
         MKm+TWL0fGaliZTR/orDZhGme89w/TRzXul3V8DhYRvmoUXvyNy/YUZ0TxjQQEBB4/xf
         CTkerVxRfV3q9/EIFxRBlKwpmyg3riOfoycwj0eLOa09pFgA+6DjkU3TQhxxvUPrQCMV
         ImOsq3xTPx9HdrUB1GgaElzZbW8IDNZpVGc4UmgNlKQ399PShV1jrgmmnAwW6ynTchs8
         V7OLLHgRZmYgq3QbAc3h3XWicTxN5QXDdsCJBmwr3/SY1lQ4Mlc7MOcYTS/i2lNXpeyO
         iD8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775563439; x=1776168239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w1LDzbcx9hv1SBKLVaF0WXtQT7MEV/JaBSgS16LIvcs=;
        b=nIWR7tuQwOSIY/IOKaxlppDN7/kKwUjA0G7v91HEp6+eP4e4NgjJYUhA+SjzbkLyul
         Pthg5ZkTo5bWQqud8NcLtzOus5a4b6OOZ3vldBM2kOYfowTUP7KFyyvS6iw379kbLHM2
         nMU4oRdXzFR3p4fDml5Q0AOgk2VyrG2gGoTy+jEv3/uAumeO649DocigOmd84GC+MOLv
         U8yMTWGAIkKhyonN77t7STJWXo61og2jrraoFL9vnmbEVq36Ljsn1UiYw1+INfJu8ooM
         lk6Fi3SbwpqdHDzy4+45PFgGmGPbAWUzZeQM/K745AZ9p88wY4BF2tth9AJIxdQkUQVv
         FxaA==
X-Gm-Message-State: AOJu0YwkNR9G87Hs+UdL3Gz7SIvxtaqFaioWgIpe9k+lYhzMI0kylotg
	MnXyYqW1RESgHwtjdWw69vj6CJu/FvZg7wPFdQFxLyBSZEip6TXHrLY7
X-Gm-Gg: AeBDieuw5zS8dWWZacF3wSfLBR1AntaVYLoM4mzDZdkXIoDyXjlgAAeSYidO2jBBBN5
	9Ld+SJvrhWM50RJ4OZB+TZyTMUi/yghBrYKesvBsSlAyfLEimFeHY9NPi18/R2V23+0lJxDWBUk
	TNjVL1V91FnRIDenwXxzbbvVFWC4aKUQ2LTV4BI+EvOMJ16zrFc9EeJo/oidovffQIKh9PVU6bJ
	12axlWeeayCupu8NWA92CH6rbHhvsNTcRjGS3XQtcA2qRgoVXqHt3oe4VgUAKphwqC6Lo+6j1km
	kW+TfjuoDq4BSAG23miD/d/p7iQsJXQg08pYpRXUb48xON7W7orekUMZCl3nSfmheVjyWXeT8B+
	tquNO7+hsqZeaSZtEE4H99hQ+ejm6w2JJjqO9869MsjTgb5sbv5BViiVV/5pcnpBi73GLX5Ul3m
	wogcOxof6m0g9pPAGvgIOcd1DsWSMKOzRktuBHCZ4=
X-Received: by 2002:a17:907:a0cf:b0:b98:36cd:7e14 with SMTP id
 a640c23a62f3a-b9c6793df4bmr837389566b.42.1775563438646;
        Tue, 07 Apr 2026 05:03:58 -0700 (PDT)
Received: from workbeast.orfanidis.nl
 ([2a01:90a0:1ff:b600:6f1c:4ff7:1aec:3fd8])
        by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9c3cff19c0sm545515166b.48.2026.04.07.05.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 05:03:58 -0700 (PDT)
From: Theodoros Orfanidis <teoulas@gmail.com>
To: m.krycki@gmail.com
Cc: alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	tiwai@suse.de
Subject: Re: [BUG] ALSA: hda/realtek: SSID 1458:a194 is shared by different
 Gigabyte ALC897 front-panel layouts
Date: Tue,  7 Apr 2026 14:03:48 +0200
Message-ID: <20260407120350.42282-1-teoulas@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: 
 <CAEfRphPU_ABuVFzaHhspxgp2WAqi7kKNGo4yOOt0zeVFPSj8+Q@mail.gmail.com>
References: 
 <CAEfRphPU_ABuVFzaHhspxgp2WAqi7kKNGo4yOOt0zeVFPSj8+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: teoulas@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: ZEBDTEJKUZMZOLCQWTHBOFMGV2DC2FOY
X-Message-ID-Hash: ZEBDTEJKUZMZOLCQWTHBOFMGV2DC2FOY
X-Mailman-Approved-At: Tue, 07 Apr 2026 14:28:05 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZEBDTEJKUZMZOLCQWTHBOFMGV2DC2FOY/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, 06 Apr 2026, Marcin Krycki wrote:
> [BUG] ALSA: hda/realtek: SSID 1458:a194 is shared by different
> Gigabyte ALC897 front-panel layouts

Same issue here. After a recent kernel update from 6.19.10 to 6.19.11
(Arch Linux), I realized my mic port had become another headphone out.

Pin 0x19 (the physical Front Mic jack) is re-tasked as a second
headphone output, and the microphone input disappears from the
available sources in the system.

Prior to this patch (tested on kernel 6.19.10), auto-config correctly
identified the separate pins:
  inputs: Rear Mic=0x18, Front Mic=0x19
  hp_outs=1 (0x1b)

With this patch applied:
  inputs: Mic=0x18
  hp_outs=2 (0x1b, 0x19)
  Front Mic (0x19) is missing from inputs.

Manually re-tasking Pin 0x19 back to'Microphone' via hdajackretask
restores the expected behavior.

Hardware: Gigabyte B660I AORUS PRO DDR4 (rev. 1.x)
PCI SSID: 1458:a194
Codec: Realtek ALC897
