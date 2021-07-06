Return-Path: <SRS0=3BcS=MA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0436DC07E96
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Jul 2021 10:12:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CC5F619B6
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Jul 2021 10:12:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CC5F619B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 15D9916CD;
	Thu,  8 Jul 2021 12:11:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 15D9916CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1625739136;
	bh=5IBPTBNzD3J6oOXzM3OGSlev4Jt2NYJo58mN1KI9s9w=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CYBlHDClO8fNMmImFC6Qi8LN5kxKCY/VRtf0YAe4WuYdyKSe/2QFEcW0GeYkux0V8
	 HhsxU5QOc/1T4uNh5rGPGvzdLZfLYB9o4js12Vy9R9VJ5a1cfS5vVozz7PqlZ5A/TU
	 QM0Mvk51ArINhvF+C17k1JDOkW5x3I2OppH/leBU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 00233F80551;
	Thu,  8 Jul 2021 12:04:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DAFCEF8014E; Tue,  6 Jul 2021 13:42:44 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C8A2EF8014E
 for <alsa-devel@alsa-project.org>; Tue,  6 Jul 2021 13:42:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C8A2EF8014E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="TwRJy6+J"
Received: by mail-ed1-x531.google.com with SMTP id x12so27575821eds.5
 for <alsa-devel@alsa-project.org>; Tue, 06 Jul 2021 04:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=CDGtQ2yb8IShQ7cIRYFiJmp1Uu5BANeA/6Jg/xILJy0=;
 b=TwRJy6+J3urIn/EOHkX70XQHrPpIXFIOoiquz6eJSwyU/SQIQ4dADKORnRQAYcVLDd
 bGmCH+O3vZ/zwAN03+xnrlCOWn/T/Pz6KfPYlHzOgGXWb72eEAEAjVLMxY3sV52LOQiu
 4sMepvP8f2M/NuGTEEUpcS9djTSXyNUocbOOHuCxDZ/swc4Yj2krBjOK18+xBOWwYw7y
 O/LcWjnu0kdZ4pmyv7jFfFo0qSdeTOdmtP2CciCXwcdnQ5FYkYueWY1vZLSQqxLbXVdx
 xHWyXJmiVDLrlTvE9QGQSNArUJUGdY04ySHX3mfxNurDFI1sFLhNw1IKyh/ZzycJEC6f
 piBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CDGtQ2yb8IShQ7cIRYFiJmp1Uu5BANeA/6Jg/xILJy0=;
 b=tD3kOj+bbeTOaaqQIzSKqzu4X5BKbsvUDlb6Ofl2fTJZava/nUnbF27RkKYTd2+2uV
 G8xIY+3feBTUuJaV8vdoj9PA/P9656E+4Cr9ndB4bAT5jQicRIDfBeNSC8sPbtV655kG
 tH7wE1fEL6P1QJrqA5Wp7ecHXpZDvwttTAJe/fsDP/4KOCEkDM28nhbN6XlI6R88xyqd
 t6p5DQdaqt708zcTR3NdeeA5R8HliDhl42G2pjxh3lMZbkQB403ZaUaS76GAFwPHvD9B
 yDuZNCQdw2GNgw2nuRxEY26V5XS4oTwAJDVhwsImq4KHEKg0nYHR6aJWUK9q4vZSCd2A
 f9jQ==
X-Gm-Message-State: AOAM531toyyrUnDYDfrb3EYnpPsw6lsP7ODdLRR7o6WOKzI/tuwiGJVP
 9n6N2UUXCFY7buXFfUZ3dmk=
X-Google-Smtp-Source: ABdhPJwOR9RYbuFI1V8zYqZEcawlLdGKboqfR9DJ6TrIpurxtzPOHwaABH2lGpOOBvACTZh8ZOEU1A==
X-Received: by 2002:a05:6402:1c06:: with SMTP id
 ck6mr22330893edb.287.1625571755735; 
 Tue, 06 Jul 2021 04:42:35 -0700 (PDT)
Received: from [192.168.2.202] (pd9e5a48a.dip0.t-ipconnect.de.
 [217.229.164.138])
 by smtp.gmail.com with ESMTPSA id eb9sm5646083ejc.32.2021.07.06.04.42.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jul 2021 04:42:35 -0700 (PDT)
Subject: Re: [PATCH] bus: Make remove callback return void
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20210706095037.1425211-1-u.kleine-koenig@pengutronix.de>
From: Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <07c08230-6c71-2a73-c89f-05b9b5de78ab@gmail.com>
Date: Tue, 6 Jul 2021 13:42:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210706095037.1425211-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 08 Jul 2021 12:04:27 +0200
Cc: =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
 linux-hyperv@vger.kernel.org, Alex Elder <elder@kernel.org>,
 kvm@vger.kernel.org, nvdimm@lists.linux.dev, linux-mmc@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-fpga@vger.kernel.org,
 linux-pci@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-cxl@vger.kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
 target-devel@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-i3c@lists.infradead.org,
 "K. Y. Srinivasan" <kys@microsoft.com>, Jiri Slaby <jirislaby@kernel.org>,
 Rob Herring <robh@kernel.org>, Wei Liu <wei.liu@kernel.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>, linux-scsi@vger.kernel.org,
 Adrian Hunter <adrian.hunter@intel.com>, linux-staging@lists.linux.dev,
 Dexuan Cui <decui@microsoft.com>, linux-acpi@vger.kernel.org,
 Andy Gross <agross@kernel.org>, industrypack-devel@lists.sourceforge.net,
 linux-input@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 linux-mips@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-sunxi@lists.linux.dev, Len Brown <lenb@kernel.org>,
 platform-driver-x86@vger.kernel.org, linux-serial@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, linux-remoteproc@vger.kernel.org,
 Haiyang Zhang <haiyangz@microsoft.com>, Jiri Kosina <jikos@kernel.org>,
 Johan Hovold <johan@kernel.org>, Maxime Ripard <mripard@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>, Mark Brown <broonie@kernel.org>,
 xen-devel@lists.xenproject.org, Bjorn Helgaas <bhelgaas@google.com>,
 Mark Gross <mgross@linux.intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org, linux1394-devel@lists.sourceforge.net,
 Johannes Thumshirn <morbidrsa@gmail.com>, linux-parisc@vger.kernel.org,
 greybus-dev@lists.linaro.org, Stephen Boyd <sboyd@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-usb@vger.kernel.org,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, netdev@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-ntb@googlegroups.com, linux-media@vger.kernel.org,
 =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
 "David S. Miller" <davem@davemloft.net>
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

On 7/6/21 11:50 AM, Uwe Kleine-König wrote:
> The driver core ignores the return value of this callback because there
> is only little it can do when a device disappears.
> 
> This is the final bit of a long lasting cleanup quest where several
> buses were converted to also return void from their remove callback.
> Additionally some resource leaks were fixed that were caused by drivers
> returning an error code in the expectation that the driver won't go
> away.
> 
> With struct bus_type::remove returning void it's prevented that newly
> implemented buses return an ignored error code and so don't anticipate
> wrong expectations for driver authors.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

>   drivers/platform/surface/aggregator/bus.c | 4 +---

Acked-by: Maximilian Luz <luzmaximilian@gmail.com>
