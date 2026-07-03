Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7498BC43458
	for <alsa-devel@archiver.kernel.org>; Sun,  5 Jul 2026 10:00:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 41D93601F2;
	Sun,  5 Jul 2026 12:00:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 41D93601F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1783245642;
	bh=KETg63QyAVz8Iy3WXA/+HPsMDUaWHNzyo7wwIqK34zg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=qUtWg7aDwiGiedmScDkPo2A9Xwa/D3ar39C4B4haZegYmXcsWs9VmFRM+YDAVS/l+
	 V/zXLvxr0Pm5BzP2fRyqdPclAZRQb1CxwegLwzigbpIZQaM74nn/x7+SAmimaOLTkT
	 KbH1z0L6SPx5CHKcok4pnQXiupfcAO7AnrLRE2Jk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E5284F80612; Sun,  5 Jul 2026 12:00:05 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id AFEC1F8061A;
	Sun,  5 Jul 2026 12:00:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1A35CF80579; Fri,  3 Jul 2026 05:28:33 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1783049310;
	b=g+A7DSY2v4TfmE9BoUPRZQoILboaTFERdjIeHbSxbrXCI8/2DndoubXi+f3nh4Vd6cnr
	 BK6xLtL4rfH/+l/AeG1mzFaNJFDzz4KNgHo21eHlq2467X9dX9RWc5xkxTSLFsIfOSXW6
	 /GnIVBnaJWVUGkJptFNmqeuOtwID0I0fKCMvv8gq/EQLqHT3G02ashe9wW+gnR9dxAQDv
	 +nJ7ClVkskL3HxxeEHQ9RWTXWTWPiwdyfoIwgle6t4E4tC2DuDu0P+qKMuDRIRccdBfGA
	 gXDnkKKvSvn2vo7bFWkcvvwry/k1Ra76IZa43rbAmctbenH8I7lPnciEJ6aIyqyT5kw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1783049310;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:From;
	bh=KETg63QyAVz8Iy3WXA/+HPsMDUaWHNzyo7wwIqK34zg=;
	b=XTMLRSt3R0bW21e86Ll9gew/T/J5kNUUYhDyGR765ROj8GIVEGQntFL/8Kh2G2eFv/r0
	 gA+htfkSZachn3PN8hmnZ5bWIhcH6YrkfbrjfftWAGDvOciFbavLfy5w8BJSBgTMK6IL0
	 Nx0+LN64tuPmoRqgO3ewLmGtnfoIiRWgSry45m9d4aK0FfmBA9zHptcvFPtDbcFDaWrla
	 au8iwcuQK2+zC8d56TTo/4c47TNOZqJ4CKsGeuuEeEkA72DcUfkGlNrRNtkttpIL9X7SY
	 2HlLDDk040UTbs4E4F4s7Nzrp+fwm/6BGfdpxoqEUdKwoSnvhPUoujmJtsowFFeKXcQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=i+LIXgAD;
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A78AFF8011B
	for <alsa-devel@alsa-project.org>; Fri,  3 Jul 2026 05:28:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A78AFF8011B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=i+LIXgAD
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-c9c26a5fb98so84887a12.0
        for <alsa-devel@alsa-project.org>;
 Thu, 02 Jul 2026 20:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783049307; x=1783654107;
 darn=alsa-project.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9af5QJrOyBu/hey/MipR49TzaYy5BSj5PKVbFBhQuCc=;
        b=i+LIXgADL6cIMxi1oTZdePxB9Eqck8uQ66/g2yr+hd897syJp8Yk9Ia1C4lFnrRIrv
         bQZoxBraK8sF4mZcIdqrb0aBwtdiP0fu6DI99Nb5UjGb3E6W1UCO5jhPrEKyZ5POnAen
         5rDF/gATx1nBRoKCNzZBGzthWx/v9r4vpQKwHNMh/Vuenb003jKJPNCjf9LpLbOn8cW1
         1ZIruXiTUekhdCWtcUHNAMrBthvTSZLjp1gdXjYv0mqMwUVvwlUrGrPw/PJlOJdu840U
         qp4v4r0knM/ELgoN0f7PpABmk7l+/qAGQjIp1S+bdLqWMDsD+jBHPkcvBLCqpU9oRMdI
         aa7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783049307; x=1783654107;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9af5QJrOyBu/hey/MipR49TzaYy5BSj5PKVbFBhQuCc=;
        b=Pw0PXtD58vNx8+OlSk/7ksVDwLGhGAEUH2MAr3zKEekcQyW1kuw0HxZWq69s+ymrQl
         kGGtOGqjbgTaUecFSWvlY6dsqPOnK7DrzjTv//2b+DWjSChUVeRg9MHkmuRCV3pZSJoh
         VaPtFlFCPxdzG4RHQSh27NBrYxYlF4tduXEbMSbOJBbQcwYNqgg10QN3DuoOtm/lO/re
         RLvDFju42hojMSJ/nYDmYPgQ97UPcWVTB/+c91DXCH7aJO33kaxz2Civ3t091X6/ur4I
         rY1uKhax0kP6kysU/b4ylDnnypN5nuKLOU5BsWDtM9Kdfuk8HyjhStPSKUKaSe3qwqKX
         2sIQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/5HB1Ns9B2g3hHCONlkKPKg04azh9+qlRF8P3ZOXLHBsc7fBYVowpNNWRWAV1KmKyB+ZAz5fxxgRDm@alsa-project.org
X-Gm-Message-State: AOJu0Yysn+QA0XpCqiYBSUU5Kq0Yg0i1Q3Gk/L9aTtCl1APLstEYu8wG
	HYMbStpTMOVp0z/f8p67xp2zxER6HpsO6dGU/PzOIhxys3oVnep5+SZs
X-Gm-Gg: AfdE7clnyZR4RY5SY+H5UttRGtoxrcjz0pWGbRjRJkZCVO2v0G96WD5jwynjMz+ysmV
	OeTN/cw9Z5Ay4LzzUDVVau5y8WDjjcV8DN2DMaCpoW9GY8wcnpe5frypxUrAQ1LsfgInPGS/aJ8
	hgTpL4H+MJqHPCnfFl+erc3gRNiuHJK+ziQ3JofChRRoP1VniZqWk4rLK3DKEk0j7LvF65Uicxb
	h8QjzelKjxh899PxSVGdgmdWAjLAoYnnNg+jiY1SPXn/Nm/QcMVekxKYgMKD8EdZdhIx94C/dfa
	47FQ9qUPthH1Rb053nQ/qNZzzZJaAWhqRLTIf/EAJ2H81po86xndWZPNR/ndAHHEnIuoKuVfay1
	luUbhJHqP8zUyw+qBkSbyxl/6gPTbZmfvqEbszrHaSa2zcthgq9qCauF2BnSciyTM/fhKgScxRK
	JYhkFyDOCjRq/V5QxLRJ1Gh7QsWEFcUNimppHkEP485NIgB0sKjg==
X-Received: by 2002:a05:6a20:918b:b0:3bd:1cfc:1b9b with SMTP id
 adf61e73a8af0-3c01c65feb5mr2729058637.10.1783049306833;
        Thu, 02 Jul 2026 20:28:26 -0700 (PDT)
Received: from [172.20.10.3] (114-137-82-69.emome-ip.hinet.net.
 [114.137.82.69])
        by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c9e91b0762esm1988467a12.20.2026.07.02.20.28.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 20:28:26 -0700 (PDT)
Message-ID: <3b32493b-b827-e4ed-3ad1-281dc19faf40@gmail.com>
Date: Fri, 3 Jul 2026 11:26:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v5 2/2] ASoC: codecs: nau8360: Add support for NAU83G60
 amplifier
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>, Neo Chang <YLCHANG2@nuvoton.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, robh@kernel.org, krzk+dt@kernel.org,
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, kchsu0@nuvoton.com, sjlin0@nuvoton.com
References: <20260630021510.821919-1-YLCHANG2@nuvoton.com>
 <20260630021510.821919-3-YLCHANG2@nuvoton.com>
 <66ce56eb-95b9-4915-8658-a1e4d1eacd7f@sirena.org.uk>
From: YLCHANG2 <neo.chang70@gmail.com>
In-Reply-To: <66ce56eb-95b9-4915-8658-a1e4d1eacd7f@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MailFrom: neo.chang70@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: PMCZFD5X7H5NQYNZRH3B4ZL7WRGIM57M
X-Message-ID-Hash: PMCZFD5X7H5NQYNZRH3B4ZL7WRGIM57M
X-Mailman-Approved-At: Sun, 05 Jul 2026 09:59:56 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PMCZFD5X7H5NQYNZRH3B4ZL7WRGIM57M/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On 7/2/26 23:15, Mark Brown wrote:
> On Tue, Jun 30, 2026 at 10:15:10AM +0800, Neo Chang wrote:
>> Add support for the Nuvoton NAU83G60 audio codec. The NAU83G60 is a
>> stereo 30W+30W smart amplifier with an integrated low-latency
>> Advanced Audio DSP.
>> +static const char *const tdm_data_length[] = { "16", "32" };
>> +
>> +static const char *const tdm_pdm_length[] = { "16", "32" };
>> +
>> +static const char *const tdm_data_n_length[] = { "8", "16" };
> I would expect TDM to be configured by set_tdm_slot() from the machine
> driver, not from userspace.  I see the driver does actually have a
> set_tdm_slot() operation...

Hi Mark,

Thanks for the feedback. Regarding the TDM configuration:
Our DSP functions require specific Slot mapping (e.g., Slot 0 for AECL, 
Slot 1 for AECR).
The standard set_tdm_slot() only defines active slots but doesn't handle 
the functional mapping.
We originally intended to allow dynamic mapping via UCM/userspacea and 
then apply these settings using set_tdm_slot().
How should we implement this mapping according to ASoC standards?
Should we define the default mapping during the codec probe stage,
or is there a preferred way to handle this via the machine driver?

>
>> +static int nau8360_read_device_properties(struct nau8360 *nau8360)
>> +{
>> +	ret = device_property_string_array_count(dev, "firmware-name");
>> +	if (ret != NAU8360_DSP_FW_NUM) {
>> +		dev_err(dev, "Missing or invalid firmware-name property in DT\n");
>> +		return -EINVAL;
>> +	}
>> +static int nau8360_i2c_probe(struct i2c_client *i2c)
>> +{
>> +	ret = nau8360_read_device_properties(nau8360);
>> +	if (ret)
>> +		return ret;
> This will fail the probe if we fail to read firmware-name from the DT so
> the firmware name is a required property in DT (and ACPI systems will
> have fun) even though it is not marked as such.  Either the driver needs
> to tolerate not having the name configured one way or another or the
> property needs to be mandatory in the bindings.
Since the DSP firmware is mandatory for the NAU83G60 to function,
I have updated the YAML binding to make firmware-name a required property.
To ensure robustness, I have also added a fallback mechanism in the 
driver to use default firmware paths
if reading the firmware-name property fails, ensuring the driver probe 
does not fail.
