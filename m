Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B65CC433EF
	for <alsa-devel@archiver.kernel.org>; Wed,  4 May 2022 03:08:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7E6C41E2;
	Wed,  4 May 2022 05:07:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7E6C41E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1651633723;
	bh=bqtOSfaLPlcszq3DR4anjstdSRamwm6p9+65DSyPJTc=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sIbWt0TqPUHwMRkK4HC5AqrYNemQhkgM3xnCZod60SBZYDp7VKrXxsU9QZimF8v0Y
	 8n49gEt3VvOIRGtgWUd3ANFEhBBtieOzkEUQWyRxULyGtdgvQGE8BGpRjkgMFtH0GR
	 +aOiOibzzfq+5M4TXOjTCwknQ8wQmg+9gHIMJASg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0E225F80141;
	Wed,  4 May 2022 05:07:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 82E4AF80163; Wed,  4 May 2022 05:07:51 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id B02C3F80129
 for <alsa-devel@alsa-project.org>; Wed,  4 May 2022 05:07:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B02C3F80129
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1651633664021152020-webhooks-bot@alsa-project.org>
References: <1651633664021152020-webhooks-bot@alsa-project.org>
Subject: alsa starts muted every reboot. /var/lib/alsa/asound.conf file does
 not exist
Message-Id: <20220504030751.82E4AF80163@alsa1.perex.cz>
Date: Wed,  4 May 2022 05:07:51 +0200 (CEST)
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

alsa-project/alsa-utils issue #145 was opened from dontbejay:

This is a multi distro issue. This has occured in EndeavourOS(XFCE), and Ubuntu(GNOME) as well.  Currently I am on openSUSE(KDE) and alsa has the same issue.  Every boot alsa has "Front" speakers Muted on my Sound Blaster Z. I have to go into alsamixer and unmute them. "sudo alsactl store" seems to do nothing to automatically restore settings on boot. Typing "sudo alsactl restore" Does fix the issue when it is used.

http://alsa-project.org/db/?f=8354e69bed4316f798b2d8300f8109cb6b672d18 (the Front speaker has been manually unmuted)

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/145
Repository URL: https://github.com/alsa-project/alsa-utils
