Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88F6CC83F25
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Jul 2025 22:19:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4BA3C60208;
	Tue, 22 Jul 2025 00:19:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4BA3C60208
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1753136389;
	bh=4JrRrRRbt+6xRxE/Jy/BhPXZ5IDE84q6zDOiy0wUqEY=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=hsboVWVUyWriZ0+VXM9smFuxUjpqUdbYYb3bYQKlA3tTxdmtUn2W9VwO2kK9iS5Ti
	 Y5qGUUpAYGxYFOVIGKlE5eQszOCNO4eJHd6vCffHPNXQMt1SsPJYy1qD0FDAJPT8zO
	 6iERQPHbzDj7LX8uUqkNtAGyfmMpTqVmfy1M1mb0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 526A9F805D2; Tue, 22 Jul 2025 00:19:13 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2019AF805C9;
	Tue, 22 Jul 2025 00:19:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4EAF4F804FF; Tue, 22 Jul 2025 00:19:05 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id A5E1DF800E4
	for <alsa-devel@alsa-project.org>; Tue, 22 Jul 2025 00:19:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A5E1DF800E4
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18546436f8cb9f00-webhooks-bot@alsa-project.org>
In-Reply-To: <18546436f7559900-webhooks-bot@alsa-project.org>
References: <18546436f7559900-webhooks-bot@alsa-project.org>
Subject: Cannot write control 'numid=11,iface=HWDEP,name='DDS''
Date: Tue, 22 Jul 2025 00:19:05 +0200 (CEST)
Message-ID-Hash: RD65NKFG7CRCZYRKHEO6ZA4SQCUUKCCV
X-Message-ID-Hash: RD65NKFG7CRCZYRKHEO6ZA4SQCUUKCCV
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RD65NKFG7CRCZYRKHEO6ZA4SQCUUKCCV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-utils issue #305 was opened from rubin55:

When running `alsactl restore` on an RME HDSPe AIO Pro (using the `snd-hdspe` kernel module), I get the following error:

```
# alsactl restore -U
Found hardware: "HDSPe" "RME HDSPe" "" "0x0000" "0x0000"
Hardware is initialized using a generic method
alsactl: set_control:1494: Cannot write control 'numid=11,iface=HWDEP,name='DDS'' : Invalid argument
```

This seems to prevent systemd's `alsa-restore` oneshot from working, although I don't really understand why; running `alsactl store/restore -U` from command line shows the same error, but *does* store/restore volume levels. The same via systemd, logs the errors in `systemd status alsa-restore` but volume levels are never restored.

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/305
Repository URL: https://github.com/alsa-project/alsa-utils
