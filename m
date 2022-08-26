Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F071ECAAA3
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Aug 2022 19:45:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 739D41657;
	Fri, 26 Aug 2022 21:45:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 739D41657
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1661543154;
	bh=SfKEAxDWA+JMJePDA2TN3/35lKaFRYxLQ7oJtk9OTK8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vP5QvIBcA76E/IlzRLyOMYNogABiqfqF9rD8Jzoj19tJ7D79WwJvWMRfXaya5T0JP
	 /fq9OVU26+LqIq82kzm78Ko5NvhaEU22rcsMi4Ck3fVZSe6ml87yQtnKoM+Q903UTF
	 vY2JQdGI+AEMIfVln2p+XcqI+g16Henn7o7us1NI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 01B5BF8014B;
	Fri, 26 Aug 2022 21:45:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9DEEAF80238; Fri, 26 Aug 2022 21:45:02 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 45401F80105
 for <alsa-devel@alsa-project.org>; Fri, 26 Aug 2022 21:44:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 45401F80105
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1661543095703939915-webhooks-bot@alsa-project.org>
References: <1661543095703939915-webhooks-bot@alsa-project.org>
Subject: MPG X570S EDGE MAX WIFI compatibility
Message-Id: <20220826194502.9DEEAF80238@alsa1.perex.cz>
Date: Fri, 26 Aug 2022 21:45:02 +0200 (CEST)
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

alsa-project/alsa-ucm-conf issue #172 was edited from yhojann-cl:

Please, add `0db0:151f` to `realtek-alc4080` chip compatibility in MPG X570S EDGE MAX WIFI motherboard:

```
$ lsusb | grep 0db0
Bus 001 Device 003: ID 0db0:151f Micro Star International USB Audio
```

In `ucm2/USB-Audio/USB-Audio.conf` add `151f` to regex of `0db0`:

```
Regex "USB((0b05:(1996|1a2[07]))|(0db0:(1feb|419c|a073|151f)))"
```

My Motherboard is MSI X570S and output audio works fine but:

- Motherboard microphone plug is not work.
- Frontal microphone plug is not work.
- When change output from gnome settings to hdmi audio does not work, the audio continues to play in the plug and not in the monitor.
- When I change the input or output from digital to analog or sinput it does not change at all.
- The strangest thing is that the microphone input captures the audio that is heard in the system as if it were the output, audacious records the audio from the desktop when it tries to monitor the microphone.
- When plugging or unplugging the microphone, the system detects this change and tries to change the audio input automatically, but it does not capture the microphone and the desktop continues to be heard.
- When plug headphone in frontal plug the gnome setting change automaticaly to the headphone item, but the sound play in speakers, not in headphone.
- On Audacity when capture Alsa + "USB Audio: #2 (hw: 1,2)" works fine!, but can not set on gnome settings.

My alsa data: http://alsa-project.org/db/?f=df4d1f6c126260eabc5f159e64cff37efa064a38

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/172
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
