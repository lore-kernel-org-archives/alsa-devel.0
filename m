Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79244C433FE
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Oct 2022 16:18:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4A2233A4F;
	Fri, 21 Oct 2022 18:17:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4A2233A4F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666369095;
	bh=QYlYvRsk+puGdTmrVcEJRPYe1uTMYtJ6DyeLESxCw/U=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=plI47zYE4vLMA5aDq8cEv9a1JFR3gKA2mH1bUtyTuTOvgb2cBH1omcSSU2uWtR6P0
	 X7oz7HqgQkT3m3KM1y8X5QT8PZliIIJTmOIEnIyb1aaSZAxz9pr0UNBb2tcsqGCLOS
	 4zy91WMZmqVdu3V6X/o5yb6FXMboUd2gzYWFQBV8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EB3E6F802E8;
	Fri, 21 Oct 2022 18:17:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 81935F8032B; Fri, 21 Oct 2022 18:17:24 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 4B533F8021D
 for <alsa-devel@alsa-project.org>; Fri, 21 Oct 2022 18:17:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4B533F8021D
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1666369042118359089-webhooks-bot@alsa-project.org>
References: <1666369042118359089-webhooks-bot@alsa-project.org>
Subject: alsactl restore udev rule failing
Message-Id: <20221021161724.81935F8032B@alsa1.perex.cz>
Date: Fri, 21 Oct 2022 18:17:24 +0200 (CEST)
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

alsa-project/alsa-utils issue #175 was edited from rnhmjoj:

It seems the udev rule to restore card settings is always failing during the boot:
```
$ journalctl -u systemd-udevd -b -o cat --grep alsa
controlC2: Process '/sbin/alsactl restore 2' failed with exit code 99.
controlC2: Process '/sbin/alsactl restore 2' failed with exit code 99.
controlC1: Process '/sbin/alsactl restore 1' failed with exit code 99.
controlC0: Process '/sbin/alsactl restore 0' failed with exit code 99.
```
I checked and made sure the file system is mounted and /var/lib/asound.state is ok by the time the rule runs. I guess the issue could be the hardware is not yet fully initialised.

Somehow the settings of card 0 (HDA Intel PCH) are restored anyway, but not those of card 2 (HDA ATI HDMI). Manually running `alsactl restore 2` later works, albeit partially (some softvol controls are never recovered).

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/175
Repository URL: https://github.com/alsa-project/alsa-utils
