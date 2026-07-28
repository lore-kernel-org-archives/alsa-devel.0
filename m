Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B25F6C54F4C
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Jul 2026 06:33:35 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 083C560195;
	Tue, 28 Jul 2026 08:33:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 083C560195
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1785220413;
	bh=s4I8hA07bYfkv10EyOtOZ+9RWacnaPLhPhy5283Gynk=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=AEOdocf2lM0Arqr2aWmaiImJ3cDoLz7fZpcCQLAOudgDtgq/v66GDhRwkmGUuVscX
	 iivys4mHEP+Wfn8p3VFKYXWNAYLYiSMnLo61rWjmVHY8cAmRfDlaeWOfkv2XmlQagi
	 yTIIpOol+Vq+caf+OEzn/JMI3CgHdVbb8x/6HXaA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 123D9F805F2; Tue, 28 Jul 2026 08:32:59 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5398AF805ED;
	Tue, 28 Jul 2026 08:32:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 09618F80526; Tue, 28 Jul 2026 08:32:51 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1785220369;
	b=dRNEUFs7D5KO5LWq4zM+fbBT62s6VuFIQU4bLMvgomsAn/0ULZrWf3EZvTw4Uc53jTVY
	 ltcB3bVolOcTTUvp02tF+/sDvDaPEvyXnbaNhfraD3oiqBkTk0PVmr7yPUEsWNDEcy/bC
	 3Sc3AI+TB6yWomSt7kN8pxxas/nXbAP/8nlgDQRGQCBXBKNML2NKDTHr2JOH/eS4akvrp
	 k97sq18jDeSyYEjkHtSEY6VV65uZ/Xv1LhbFjrHNb91VcaOBNDs82c6HsgOhS7HWoVPdp
	 feK/iU6NO0JEPM75VnXTgHFzSFAmqyr5XQ74OIzZz4pvInnGXVowQ/Y2s3BJtl4Y8Pw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1785220369;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=s4I8hA07bYfkv10EyOtOZ+9RWacnaPLhPhy5283Gynk=;
	b=aEgibiCDjH1DEx2Yy137zcIctCsh8sBIolUxUPrtBEyX6Ptc90niuN5XEQZWez8hyFb9
	 ROgiNkjtQCEb6yHgq7D0/ua7Zq+od/1I4UO0l/i+jlzlrt2hBgiMaqWBuE2gwDL9BW1TW
	 dCYc7LXCTntHZgGKcTyW3AzI8X2BbwrBPTJx5jh/OoIYC43ghJvkRmYA9WGQQSI4wG3VP
	 uDyFVQoZ3Rd1SX+BQYkufGS+3c+a2G0KvRd6Zp05cNfSxBJG4R6wbs0FnDHSX/YfUxDIs
	 LtK4CqOoLKbIJQXOcMX6cjQfIAVuUmGuvdMI1I9pVnlqgV2AL6Q2LHrUzSFX1w3mxbg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id E2893F801F7
	for <alsa-devel@alsa-project.org>; Tue, 28 Jul 2026 08:32:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E2893F801F7
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18c6607700bddf00-webhooks-bot@alsa-project.org>
In-Reply-To: <18c660770098b800-webhooks-bot@alsa-project.org>
References: <18c660770098b800-webhooks-bot@alsa-project.org>
Subject: New Device: TASCAM DR Series (DR-05XP)
Date: Tue, 28 Jul 2026 08:32:51 +0200 (CEST)
Message-ID-Hash: PJKP3YMZ7A64S4FXT27J3UENVWVJBXGT
X-Message-ID-Hash: PJKP3YMZ7A64S4FXT27J3UENVWVJBXGT
X-MailFrom: github@alsa-project.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PJKP3YMZ7A64S4FXT27J3UENVWVJBXGT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #819 was opened from robobenklein:

I'm not quite familiar enough here to add these devices since they all have different capabilities (channels/streams/etc). I only have the DR-05XP but was able to get it working in pipewire with just a rudimentary HiFi config.

The DR-05XP is 2-channel stereo input, however there are some other DR series devices that have more inputs and the USB identifier is not enough on it's own to know which device it is.

alsa-info: https://alsa-project.org/db/?f=92aab8003f13685db869a948e85b8b9809d1f9d8

udev USB info: (some unrelated lines omitted)

```
E: SUBSYSTEM=sound
E: SOUND_INITIALIZED=1
E: ID_VENDOR_FROM_DATABASE=TEAC Corp.
E: ID_BUS=usb
E: ID_MODEL=TASCAM_DR_Series
E: ID_MODEL_ENC=TASCAM\x20DR\x20Series
E: ID_MODEL_ID=8065
E: ID_SERIAL=TEAC_Corporation_TASCAM_DR_Series
E: ID_VENDOR=TEAC_Corporation
E: ID_VENDOR_ENC=TEAC\x20Corporation
E: ID_VENDOR_ID=0644
E: ID_REVISION=0121
E: ID_TYPE=audio
E: ID_USB_MODEL=TASCAM_DR_Series
E: ID_USB_MODEL_ENC=TASCAM\x20DR\x20Series
E: ID_USB_MODEL_ID=8065
E: ID_USB_SERIAL=TEAC_Corporation_TASCAM_DR_Series
E: ID_USB_VENDOR=TEAC_Corporation
E: ID_USB_VENDOR_ENC=TEAC\x20Corporation
E: ID_USB_VENDOR_ID=0644
E: ID_USB_REVISION=0121
E: ID_USB_TYPE=audio
E: ID_USB_INTERFACES=:010100:010200:030000:
E: ID_USB_INTERFACE_NUM=00
E: ID_USB_DRIVER=snd-usb-audio
E: ID_ID=usb-TEAC_Corporation_TASCAM_DR_Series-00
```

I can't even assume that the devices are all stereo channels either, like the DR-10L Pro is probably mono (lav mic). Any assistance/advice on getting this added would be appreciated.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/819
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
