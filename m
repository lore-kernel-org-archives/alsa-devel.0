Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91FF1CA101F
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Sep 2025 18:06:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 763246020F;
	Fri, 12 Sep 2025 20:06:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 763246020F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1757700411;
	bh=Vhk6ESTGtqFDxX56/q8gP6w760O74sUCFpLBJh7N468=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=f8xhXOuOTWEkBt9Efo9bTfGGwARP/i/Q8qOEaAzX9Fn9j2RH1d3Y5IC9T16gQ30uc
	 Yro4xdjYwXVsmkhJ5ClqvxsVk0I0LI8gXUS30hPQU4pd64c3MLX027lHn/XSur9QOJ
	 Mle9B895MEeyzY6mbeW/v7UHAbQ913Nj6IhTQRo4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1FFA1F805D6; Fri, 12 Sep 2025 20:06:15 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2BEFCF805C6;
	Fri, 12 Sep 2025 20:06:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A5394F80254; Fri, 12 Sep 2025 20:04:56 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 822EBF8021D
	for <alsa-devel@alsa-project.org>; Fri, 12 Sep 2025 20:04:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 822EBF8021D
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18649b1ac337ba00-webhooks-bot@alsa-project.org>
In-Reply-To: <18649b1aba103300-webhooks-bot@alsa-project.org>
References: <18649b1aba103300-webhooks-bot@alsa-project.org>
Subject: Internal microphone (Conexant SN6140) detected but shows
 inactive/unplugged on Lenovo IdeaPad Slim 5 16AKP10 83HY after alsa-ucm-conf
 1.2.14
Date: Fri, 12 Sep 2025 20:04:56 +0200 (CEST)
Message-ID-Hash: GSNUGZEX2V6YFD6RK4VZV2JUGJPGPEWH
X-Message-ID-Hash: GSNUGZEX2V6YFD6RK4VZV2JUGJPGPEWH
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GSNUGZEX2V6YFD6RK4VZV2JUGJPGPEWH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #612 was edited from JayJaber:

The internal microphone on a Lenovo IdeaPad Slim 5 16AKP10 83HY with Conexant SN6140 codec behaves as follows:

On alsa-ucm-conf 1.2.14 and newer:
- Family 17h/19h/1ah HD Audio Controller Digital Microphone appears as a recording device but does not record. Only a small bit of static is audible at the start and end of recordings.
- Family 17h/19h/1ah HD Audio Controller Stereo Microphone appears as inactive/unplugged. When headphones are plugged in, it becomes active and the headphone microphone works under that device.

After downgrading to alsa-ucm-conf 1.2.13-2:
- Both Family 17h/19h/1ah HD Audio Controller Internal Stereo Microphone and Family 17h/19h/1ah HD Audio Controller Digital Microphone appear as active recording devices without headphones plugged in.
- Digital Microphone still does not record usable audio, only a small bit of static at the beginning and end.
- Internal Stereo Microphone works correctly for the built-in mic when headphones are not plugged in. Plugging in headphones causes the headphone microphone to be used under the Internal Stereo Microphone device.

Summary:
The Digital Microphone is detected but never records usable audio.

On 1.2.13-2, the Internal Stereo Microphone routes audio correctly from the built-in mic, so recording works, but the Digital Microphone itself remains nonfunctional.

On 1.2.14+:
- Digital Microphone appears but remains completely nonfunctional.
- Stereo Microphone shows as inactive/unplugged until headphones are connected, making the internal microphone unusable.
- Headphone microphone routing works correctly.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/612
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
