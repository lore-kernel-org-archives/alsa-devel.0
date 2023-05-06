Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CCB3C77B75
	for <alsa-devel@archiver.kernel.org>; Sat,  6 May 2023 16:34:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CCB1329DC;
	Sat,  6 May 2023 18:33:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CCB1329DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1683390882;
	bh=ZT3/1TkMJL3KuQhEd5DWPy2pAx0/rY2EvwYWOh2wMqI=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=qwi/t0TDq2+PvtUvKqBjEL3fjEuNryReEs7BzuXyreJ+r8zyAKcsgBBQqAOC0G37K
	 2D/4//2xONVFwRvs1KtzdvkBt3O3AS9cJlV8jlB2X87UxK1eDiwvTCj4vWc1Gxpflx
	 FWNpeqV/AXEM3UqB7QFKuIlE6G8j39UXib8qIFjI=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6BB12F80087;
	Sat,  6 May 2023 18:33:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8387CF8052D; Sat,  6 May 2023 18:33:22 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id EAA65F80087
	for <alsa-devel@alsa-project.org>; Sat,  6 May 2023 18:33:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EAA65F80087
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1683390795753814459-webhooks-bot@alsa-project.org>
References: <1683390795753814459-webhooks-bot@alsa-project.org>
Subject: Some USB-Audio speakers with non-existent S/PDIF outputs
Message-Id: <20230506163322.8387CF8052D@alsa1.perex.cz>
Date: Sat,  6 May 2023 18:33:22 +0200 (CEST)
Message-ID-Hash: S2Q5T2CEILKG2CUZYRQMHQZRLED4AZZB
X-Message-ID-Hash: S2Q5T2CEILKG2CUZYRQMHQZRLED4AZZB
X-MailFrom: github@alsa-project.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/S2Q5T2CEILKG2CUZYRQMHQZRLED4AZZB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib issue #315 was edited from drjhe:

I've come across a couple of USB-Audio speaker sets which get configured with non-existent S/PDIF outputs:

- **Creative Pebble V3:** USB ID 041e:3272, ALSA name "Pebble V3"
- **Jabra SPEAK 510:** USB ID 0b0e:0420, ALSA name "Jabra SPEAK 510 USB"
- **'Ricco' Elite Silicon-based USB speakers:** USB ID 18c3:6255, ALSA name "USB Audio Device"

The phantom outputs for the Pebble V3 and Jabra can be removed by adding 
```
        "Pebble V3" 999
        "Jabra SPEAK 510 USB" 999
```
to the ```USB-Audio.pcm.iec958_device``` section of USB-Audio.conf.

For the Ricco speakers the ALSA name seems a bit too generic to add to USB-Audio.conf -- is there a way to achieve the same effect matching on the USB ID?

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/315
Repository URL: https://github.com/alsa-project/alsa-lib
