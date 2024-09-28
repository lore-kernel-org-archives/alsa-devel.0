Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09AC3CF6491
	for <alsa-devel@archiver.kernel.org>; Sat, 28 Sep 2024 17:19:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BA8FEE7F;
	Sat, 28 Sep 2024 19:18:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BA8FEE7F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1727543948;
	bh=v4hTBocrMjj7KzxT5w0peqAqgkDcEiGS8xnyrmOw8H4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=JF/DduQ+2I0/5iGo0h5YM30b7IPgufHjqXfW8yEYzAjYieAumojPh97z3LpTuSARJ
	 w4A2wFERn7uovQPeuSGdsXPLT0qvWSIklO4HKEoiGpTfg40exVBYcHkQLPB/NgimE2
	 n+MTRlC1niBQ3OjyNfsqFyYw+avj3+D1fUDGh3M0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 36B70F805AB; Sat, 28 Sep 2024 19:18:37 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D9A7EF805A1;
	Sat, 28 Sep 2024 19:18:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 84CCEF802DB; Sat, 28 Sep 2024 19:18:31 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id DB0DBF80007
	for <alsa-devel@alsa-project.org>; Sat, 28 Sep 2024 19:18:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DB0DBF80007
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1727543909667818308-webhooks-bot@alsa-project.org>
References: <1727543909667818308-webhooks-bot@alsa-project.org>
Subject: ucm2: Add Roland Bridge Cast V2
Message-Id: <20240928171831.84CCEF802DB@alsa1.perex.cz>
Date: Sat, 28 Sep 2024 19:18:31 +0200 (CEST)
Message-ID-Hash: KN4XRUIZEH7EZDLFIWB63RB3WUJZENES
X-Message-ID-Hash: KN4XRUIZEH7EZDLFIWB63RB3WUJZENES
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KN4XRUIZEH7EZDLFIWB63RB3WUJZENES/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #445 was edited from Fumler:

Roland Bridge Cast recently had a firmware update which brings in e.g. virtual surround and is dubbed as "V2" and has a separate usb device id than the existing Bridge Cast in the repo. This PR adds the changes needed for the new firmware to be mapped correctly, as a new USB audio device.

Changelog: https://www.roland.com/global/support/by_product/bridge_cast/updates_drivers/7e9b7ea2-2c20-4749-a423-0ff28709cdac/

Thanks to [geoffreybennett](https://old.reddit.com/user/geoffreybennett) on reddit for helping me understand how to debug this stuff. Thread: https://old.reddit.com/r/linuxaudio/comments/1fq06z8/roland_bridge_cast_no_longer_having_separate/?cache-bust=1727469957022

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/445
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/445.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
