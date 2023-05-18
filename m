Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30875C77B7D
	for <alsa-devel@archiver.kernel.org>; Thu, 18 May 2023 15:54:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0CFF0209;
	Thu, 18 May 2023 17:54:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0CFF0209
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684425297;
	bh=yy5e77k3doOrxSyCFI2HBiEAmW7848CBCulkXIzrGcU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=jw01N1KLPkpv3QBBpWWfbIMiFjFyzFPzfIQR6K0t4L4NQq810E0S33wObG5p7/g0o
	 MsKDZlPw3rrJpN/tZZVfqx0ac2PhHZzjTMcDOgPrkWyLgVoRrw0KsVot6HFg7tBHfj
	 zPGVwIwRJD6GJz5NvtNSQkmzKntK+zs6CFcGk7gk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A69C1F80431; Thu, 18 May 2023 17:53:39 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 34931F8016A;
	Thu, 18 May 2023 17:53:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 03576F80272; Thu, 18 May 2023 17:53:35 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 34EADF8016D
	for <alsa-devel@alsa-project.org>; Thu, 18 May 2023 17:53:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 34EADF8016D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ETzALONu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684425211; x=1715961211;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yy5e77k3doOrxSyCFI2HBiEAmW7848CBCulkXIzrGcU=;
  b=ETzALONuI+HbY7V3DfYdagfRq/ges7yEeVLuiB0kx6GuaxoZwI9kedbB
   I2SAM89uPsBKvgXMebKg6MhRPVQrXMHmo8fCrvT+M51INxDmwOV/sIYCS
   MU8Xg549g5sWn4zRfqC1Mrf4+W8eEX4l9dNwZIGUtUSbTKp59TgsoFKCE
   2BfhSAwzB3pFieYQgamoGp4hIbwA3I3+QwPbW1PnpcQJzdhCAGccrwvOh
   ysSgOqldb2o5LkKNMlo4O9aJXW4B4PUrkjj8r59mTF80mePmkMVpEjREr
   yl1I7/uM5kp607l4juhS2I6CJ0dNtxOzRRSe66i763W482ivCvF+HC0pH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="336692210"
X-IronPort-AV: E=Sophos;i="5.99,285,1677571200";
   d="scan'208";a="336692210"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2023 08:53:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="702172670"
X-IronPort-AV: E=Sophos;i="5.99,285,1677571200";
   d="scan'208";a="702172670"
Received: from nithinks-mobl1.amr.corp.intel.com (HELO [10.209.80.104])
 ([10.209.80.104])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2023 08:53:23 -0700
Message-ID: <650012a3-b455-8be5-fd6d-d0775e718e6a@linux.intel.com>
Date: Thu, 18 May 2023 10:16:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH 06/10] mfd: cs42l43: Add support for cs42l43 core driver
Content-Language: en-US
To: Charles Keepax <ckeepax@opensource.cirrus.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: broonie@kernel.org, lee@kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, tglx@linutronix.de,
 maz@kernel.org, linus.walleij@linaro.org, vkoul@kernel.org,
 lgirdwood@gmail.com, yung-chuan.liao@linux.intel.com,
 sanyog.r.kale@intel.com, alsa-devel@alsa-project.org,
 patches@opensource.cirrus.com, devicetree@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20230512122838.243002-1-ckeepax@opensource.cirrus.com>
 <20230512122838.243002-7-ckeepax@opensource.cirrus.com>
 <73438e58-bd96-818d-1f43-5681b0d1a1de@linaro.org>
 <20230518102442.GZ68926@ediswmail.ad.cirrus.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230518102442.GZ68926@ediswmail.ad.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID-Hash: 3C45BI4HJWCBC5647L3UT3QHC6DJLUK5
X-Message-ID-Hash: 3C45BI4HJWCBC5647L3UT3QHC6DJLUK5
X-MailFrom: pierre-louis.bossart@linux.intel.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3C45BI4HJWCBC5647L3UT3QHC6DJLUK5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


>>> +	ret = regmap_register_patch(cs42l43->regmap, cs42l43_reva_patch,
>>> +				    ARRAY_SIZE(cs42l43_reva_patch));
>>> +	if (ret) {
>>> +		dev_err(cs42l43->dev, "Failed to apply register patch: %d\n", ret);
>>> +		goto err;
>>> +	}
>>> +
>>> +	pm_runtime_mark_last_busy(cs42l43->dev);
>>> +	pm_runtime_put_autosuspend(cs42l43->dev);
>>> +
>>> +	ret = devm_mfd_add_devices(cs42l43->dev, PLATFORM_DEVID_NONE,
>>> +				   cs42l43_devs, ARRAY_SIZE(cs42l43_devs),
>>
>> I don't why adding devices is not in probe. They use the same regmap
>> right? So there will be no problem in probing them from MFD probe.
> 
> Well except SoundWire is a bit of a special boy, the hardware is
> not necessarily available in probe, the hardware is only available
> at some point later when the device attaches. Doing it this way all
> of the attaching (and various detach/attach cycles the device needs
> during configuration) are over by the time the child drivers bind, so
> they don't all need special code to handle that.

if the devices are added in the probe, then the regmap needs to be moved
to cache-only and another special API would be needed to tell the MFD
framework to turn the regmap cache-only off.

But if it's the same regmap, the regmap cache is handled in the
SoundWire update_status callback so maybe  Krzysztof's proposal does work?
