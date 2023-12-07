Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5121C4167B
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Dec 2023 14:00:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 009F7832;
	Thu,  7 Dec 2023 14:59:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 009F7832
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1701957609;
	bh=IL5G6D1SsbuUL/eXPV7buviNWw2rnZNXUQIeRNzSask=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=d+Se12Cp7sbChhpQslcYxRD5YK7V82aR5knKJ4zqo8ZVZOphO5mlhQ4U6/dykuQWJ
	 +uP/Kqu/eWAid+LAaQMz4RHmNIEsUT5OlYKE1izOid2yw95GVouI3rnuc1I/D8ONOE
	 GGNKtFv74w6YpVcHytN+0n+c0LJPU7ppuhfT5ogk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3B6BFF805EC; Thu,  7 Dec 2023 14:59:15 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2A151F805F0;
	Thu,  7 Dec 2023 14:59:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 521DFF8024E; Thu,  7 Dec 2023 14:58:35 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 4F2B5F800E4
	for <alsa-devel@alsa-project.org>; Thu,  7 Dec 2023 14:58:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4F2B5F800E4
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1701957513300485373-webhooks-bot@alsa-project.org>
References: <1701957513300485373-webhooks-bot@alsa-project.org>
Subject: No sound from frontal case jack AUX [MSI MAG Z690 Tomahawk Wifi]
Message-Id: <20231207135835.521DFF8024E@alsa1.perex.cz>
Date: Thu,  7 Dec 2023 14:58:35 +0100 (CET)
Message-ID-Hash: QHOFYNGBYD7E5XGFHQTQFFFWALFXOJQV
X-Message-ID-Hash: QHOFYNGBYD7E5XGFHQTQFFFWALFXOJQV
X-MailFrom: github@alsa-project.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QHOFYNGBYD7E5XGFHQTQFFFWALFXOJQV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #371 was edited from ricciolino:

I posted [this](https://ubuntuforums.org/showthread.php?t=2486774) some weeks ago and I thought I had been able to solve the issue.
Unfortunately, it does not seem like so.

**Summary of the issue**: attaching my headphone to the rear jack, sound is emitted correctly, whilst frontal AUX jack it just looks dead (headphone device is correctly recognized in sound system settings but no sound is emitted).

Summary of steps that brought me to the initial solution.

Check the sound card USB device with:
```
> lsusb | grep -i audio
Bus 001 Device 003: ID 0db0:b202 Micro Star International USB Audio
```

Execute the following commands in sequence:
```
sudo mv /usr/share/alsa/ucm /usr/share/alsa/ucm.bak
sudo mv /usr/share/alsa/ucm2 /usr/share/alsa/ucm2.bak
curl -L -o alsa-ucm-conf.tar.gz https://github.com/alsa-project/alsa-ucm-conf/archive/refs/heads/master.tar.gz
sudo tar xvzf alsa-ucm-conf.tar.gz -C /usr/share/alsa --strip-components=1 --wildcards "*/ucm" "*/ucm2"
rm alsa-ucm-conf.tar.gz
```

Reboot... than check:
```
> cat /usr/share/alsa/ucm2/USB-Audio/USB-Audio.conf | grep 0db0:b202
        # 0db0:b202 MSI MAG Z690 Tomahawk Wifi
```

Attaching the headphone now sound is emitted correctly from frontal AUX jack.

After a few weeks I returned to the initial situation, the front AUX jack does not emit any sound. I checked USB-Audio.conf file for being sure still MSI MAG Z690 Tomahawk Wifi MoBo is supported and output is confirmed.
```
> cat /usr/share/alsa/ucm2/USB-Audio/USB-Audio.conf | grep 0db0:b202
        # 0db0:b202 MSI MAG Z690 Tomahawk Wifi
```

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/371
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
