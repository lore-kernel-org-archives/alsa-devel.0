Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B72D910F9968
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Apr 2026 20:01:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3522D60206;
	Wed,  8 Apr 2026 22:01:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3522D60206
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775678480;
	bh=oKjIQ39wQKIDcOZEhdEHOXiatid7VtMNARjawIGIL9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=iRoWECSP/m6WYIwRVX+vSbCzI1dA/j51PacVxu9iSLX2h/7aaiINqfuS36ol0q5Io
	 Otd0vlub7yyH3iGTE64gyu+oKfM8sgYhypqyeq9t6OOJCOlXfHKs1tDKws5fiSK98D
	 QK7+pkWohDf5B5mV279q9nJVezSt321sZEaqrfTw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EB679F805F4; Wed,  8 Apr 2026 22:00:47 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 50F5EF805E9;
	Wed,  8 Apr 2026 22:00:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 44AF3F804CF; Wed,  8 Apr 2026 22:00:36 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E0959F80154
	for <alsa-devel@alsa-project.org>; Wed,  8 Apr 2026 22:00:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E0959F80154
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=NKP63QsR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775678435; x=1807214435;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oKjIQ39wQKIDcOZEhdEHOXiatid7VtMNARjawIGIL9w=;
  b=NKP63QsR9d+rYwDs3fyJhMggR6VD4w0381j0l+yK4gvPrnV6OCecn28F
   AFNfBYU3//LQ/sKAuXuRNa8Cnmx6F8bZjbaGUZrZTDbOVAFfCRdy3x2nP
   WOSnlveflRCs+31iL5O4rB7qobNwo7qV4v842VWj73UEtF9y9pSIgHmck
   e6jUdBT9IRo9ePXxZ1wEjHW9twmn5qtcr7Pp+ssmWmTta+GfJpGOf53Sn
   AxxLf4Z0lIWptpgBCfrvaih4H4mg6oiXumkeLlBbEmBl8xtBbf7Ndht05
   KSCsbBFIpHcdiHislfsMiFf2ja1MKHdFGQDGerGQgDDYB+dMSioH/SwOI
   w==;
X-CSE-ConnectionGUID: D8c9LsgJS/ysCmp0BqVlBQ==
X-CSE-MsgGUID: Q+NmypKyRpGe+8nwKaq0Sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="76794915"
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000";
   d="scan'208";a="76794915"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 13:00:30 -0700
X-CSE-ConnectionGUID: mbW8P84dTtyr4GXPtt1eag==
X-CSE-MsgGUID: B8KbQBbJRs2OHlaqNqdFSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000";
   d="scan'208";a="233525506"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost)
 ([10.245.245.72])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 13:00:28 -0700
Date: Wed, 8 Apr 2026 23:00:25 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: broonie@kernel.org, tiwai@suse.de, 13916275206@139.com, krzk@kernel.org,
	alsa-devel@alsa-project.org, baojun.xu@ti.com
Subject: Re: [PATCH v2] ASoC: tas2781: Explicit association of Device, Device
 Name, and Device ID
Message-ID: <adaz2UD-OVf0hPL8@ashevche-desk.local>
References: <20260406103131.1883-1-shenghao-ding@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406103131.1883-1-shenghao-ding@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
Message-ID-Hash: ADEISU6ORVH5BU3ZTSTQ4YEXK3FTCTL5
X-Message-ID-Hash: ADEISU6ORVH5BU3ZTSTQ4YEXK3FTCTL5
X-MailFrom: andriy.shevchenko@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ADEISU6ORVH5BU3ZTSTQ4YEXK3FTCTL5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, Apr 06, 2026 at 06:31:31PM +0800, Shenghao Ding wrote:
> By correlating devices with their names and IDs, the driver becomes more
> discoverable.

...

>  static int tasdevice_i2c_probe(struct i2c_client *i2c)
>  {
> -	const struct acpi_device_id *acpi_id;
>  	struct tasdevice_priv *tas_priv;
> +	struct i2c_device_id *id_data;
>  	int ret;
>  
>  	tas_priv = tasdevice_kzalloc(i2c);
> @@ -2041,20 +2037,23 @@ static int tasdevice_i2c_probe(struct i2c_client *i2c)
>  	dev_set_drvdata(&i2c->dev, tas_priv);
>  
>  	if (ACPI_HANDLE(&i2c->dev)) {
> -		acpi_id = acpi_match_device(i2c->dev.driver->acpi_match_table,
> -				&i2c->dev);
> -		if (!acpi_id) {
> -			dev_err(&i2c->dev, "No driver data\n");
> -			ret = -EINVAL;
> -			goto err;
> -		}
> -		tas_priv->chip_id = acpi_id->driver_data;
> +		id_data = (struct i2c_device_id *)
> +			acpi_device_get_match_data(&i2c->dev);
>  		tas_priv->isacpi = true;
>  	} else {
> -		tas_priv->chip_id = (uintptr_t)i2c_get_match_data(i2c);
> +		id_data = (struct i2c_device_id *)i2c_get_match_data(i2c);
>  		tas_priv->isacpi = false;
>  	}
>  
> +	if (!id_data) {
> +		dev_err(&i2c->dev, "No driver data\n");
> +		ret = -EINVAL;
> +		goto err;
> +	}

Please, collapse all this to just i2c_get_match_data().

	const struct i2c_device_id *id_data;
	...
	id_data = i2c_get_match_data(i2c);

-- 
With Best Regards,
Andy Shevchenko


