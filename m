Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B231CD0424
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Jan 2026 23:22:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A978860202;
	Tue,  6 Jan 2026 00:22:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A978860202
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1767655362;
	bh=/nzK3jaTezFm/L+maAiy38gGJt2vUrH5b+KySyzrLwg=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=JqTDhinKh6zRuR5Df+4VaRvv7WZqn+rtshZdBicLxMU5rftX5pK7Hb68sMQwrnhgr
	 CVKUqjOXU4crBDisbWQIj73R97f4NPC2tI+KKYoP5vBHrlIrd/hC/tiYsmip/lNQyn
	 Q2xmHbafHUc7ZoT0Uve17MlOzlapXik/Hrlcgsxs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 56D7BF805E2; Tue,  6 Jan 2026 00:22:08 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9FA70F805CA;
	Tue,  6 Jan 2026 00:22:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B406BF80088; Tue,  6 Jan 2026 00:21:30 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id EDFC3F80088
	for <alsa-devel@alsa-project.org>; Tue,  6 Jan 2026 00:21:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EDFC3F80088
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <1887f91c6681ec00-webhooks-bot@alsa-project.org>
In-Reply-To: <1887f91c65b40100-webhooks-bot@alsa-project.org>
References: <1887f91c65b40100-webhooks-bot@alsa-project.org>
Subject: SSL2.conf Defines Incorrect Number of Capture Channels
Date: Tue,  6 Jan 2026 00:21:30 +0100 (CET)
Message-ID-Hash: DH6FRGHHUX7RUU2KVQ4SUMGIJVQFU4PQ
X-Message-ID-Hash: DH6FRGHHUX7RUU2KVQ4SUMGIJVQFU4PQ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DH6FRGHHUX7RUU2KVQ4SUMGIJVQFU4PQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #676 was opened from TheBakedPotato:

The file at `ucm2/USB-Audio/SolidStateLabs/SSL2.conf` has the line
```
Define.DirectCaptureChannels 4
```
However, I believe that should actually be 
```
Define.DirectCaptureChannels 2
```
since the SSL2 (**not** the SSL2+) only has 2 physical inputs. 

As well, now, with that change, a third audio "profile" appears ago for the SSL2 output device of `Direct SSL 2`. 
<img width="416" height="78" alt="Image" src="https://github.com/user-attachments/assets/14998079-d81d-444f-80b1-b198ad049428" />
The `[ALSA UCM error]` still appears, but now the correct "profile" is available. As well, now my music player, Amberol, is able to persist the volume change between songs. Before if I changed the volume and proceed to the next song the audio in the Amberol application would get set to max.

The output in `journalctl` is still present
```
Jan 05 18:11:39 endeavour-zone wireplumber[1533]: spa.alsa: Error in ALSA UCM profile for _ucm0001.hw:S2,0 (HiFi: Mic2: source): CaptureChannels=4 > avail 2
Jan 05 18:11:39 endeavour-zone wireplumber[1533]: spa.alsa: Errors in ALSA UCM profile for card SSL 2
Jan 05 18:11:40 endeavour-zone wireplumber[1533]: spa.bluez5: BlueZ system service is not available
```
if the HiFi profile is selected. I'm assuming because the file `SSL2-HiFi.conf` needs to be updated for the correct number of hardware capture channels.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/676
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
