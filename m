Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD89BC43458
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2026 01:40:08 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 77AEF601E6;
	Tue,  7 Jul 2026 03:39:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 77AEF601E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1783388406;
	bh=Wa0KD1DglddRFKHPlS2tZTMx2biCtaJEvp5V8Vcy4Is=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=SzehYuEUM9Kma0WKiVrvvuvPUzu8auwgyJS3KX5PhdhTJR8GYZ03Jt+JvCnS9hYlT
	 WUm3YS2q9I8AwbpPvH3pAGW4FmgskLe3uHbr3cavFeSBgDpfAUf1RHcVKzdX/3csWq
	 v9b6oKTH4r54jFTWufU3rjLNeNyxR73iQcbT7o58=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D035DF805F4; Tue,  7 Jul 2026 03:39:32 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 714AAF805EC;
	Tue,  7 Jul 2026 03:39:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AEE06F8055A; Tue,  7 Jul 2026 03:39:25 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1783388365;
	b=MFSuk3CvbBeE6JgEOgiaE1dbohk49U76lpUU/lI0VlRzjYjIDK6Is2zc2BX5TPlgkFU+
	 5Jw+EhDqR2Cz+QsL4zvrNS+YVWXYaESTo8yO3+cmJYciQo8kh+iWuWpDsueBrwqIA+qfH
	 6Ghw90pYlsATSZ0ooep+49vDP7z/f7UvazWMIFNEYb4JQkeCOLho6fGQhOWiqCcSUb9uZ
	 Pu9uPs4fRiRGCWaGmVhw7jDHaE+Y03T7m/bBpKoaFcf04nxt1VryO3J2snFFcmGjr5XID
	 +D4LEi3QpGN0PJATdfc16VJuRkk1VkqDu5GEbDC5mnwuPDIin7I2tWDOA8dNUVbhsUQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1783388365;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=Wa0KD1DglddRFKHPlS2tZTMx2biCtaJEvp5V8Vcy4Is=;
	b=Y+3YGfKA43K1fWsM2DjQsPYvyou0cFZZjYcZVIMbJQbRVufbKug5E81a1R4aQ3N5x5ee
	 eyojc4RyFxh/HfyfLOa7hV4fCB9S54L/cZSo1HRIePdT8SLmi1rVKhbSxNdJa4TrY1wu6
	 8/PySB+7fyvs9KOzQH0rQ7G7LwHGtzInPUocRKrZtcWjOefFUtG904GCu0Djf9b8z7SNv
	 AhacGFxmxN+Kx2T1GmzJnXgUd5PzDP3J8sGcvD+sSxVrwQenhDfVm8lgnRrZwhW6pHLBh
	 wixfAJr2wbstqTY0vkiBUAecjL4B5gLMVV+6PkWyAc2fX4rnmfGYXcF7fAFUNfsrPQQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 3BC8EF8010B
	for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2026 03:39:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3BC8EF8010B
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18bfde44a2be3d00-webhooks-bot@alsa-project.org>
In-Reply-To: <18bfde44a2993900-webhooks-bot@alsa-project.org>
References: <18bfde44a2993900-webhooks-bot@alsa-project.org>
Subject: Realtek ALC245: Built-in speakers cannot be selected while headset is
 plugged in
Date: Tue,  7 Jul 2026 03:39:25 +0200 (CEST)
Message-ID-Hash: ZIY25UJQVU7CHL64EJSHO2E7QOVW56F3
X-Message-ID-Hash: ZIY25UJQVU7CHL64EJSHO2E7QOVW56F3
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZIY25UJQVU7CHL64EJSHO2E7QOVW56F3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #807 was edited from SSolarite:

## Hardware & System
* Machine: VICTUS BY HP 16.1 INCH GAMING LAPTOP PC 16-E0000 (2V8Z8AV)
* Audio Chip: Realtek ALC245
* Distro: Arch Linux
* Sound Server: PipeWire/WirePlumber

### Description
The UCM2 configuration does not expose an option to change to the built-in laptop speakers while a headset is plugged in, specifically, it splits both Speakers and Headphones into two profiles:
<img width="404" height="148" alt="Image" src="https://github.com/user-attachments/assets/e23fafc1-dccb-4c2c-af02-d3ea3c2923df" />

It only shows up once the headset is unplugged:

Headset in:
<img width="454" height="444" alt="Image" src="https://github.com/user-attachments/assets/fe636fe5-6e35-4bb1-bca0-97dc58f9714e" />

No headset:
<img width="460" height="450" alt="Image" src="https://github.com/user-attachments/assets/da2b7b6f-c145-465a-a1d1-699e02359d2f" />

I have also tried the Pro Audio profile. It shows these two, but none of them work. Record test only shows a little bit of static.
<img width="453" height="444" alt="Image" src="https://github.com/user-attachments/assets/5061600b-39a2-4149-8815-101bc21cd141" />

 `sound-test` plays through both the headset and speakers. The speakers can be toggled using `amixer -c2 sset Speaker [on/off]`

### Expected Behavior
Both the built-in speakers and headset should be selectable options without flip-flopping.

### alsa-info.txt
[alsa-info.txt](https://github.com/user-attachments/files/29711854/alsa-info.txt)

If this happens to be a configuration issue on my end, please give me steps to fix it.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/807
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
