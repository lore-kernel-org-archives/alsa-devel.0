Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9723EC433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Mar 2022 00:25:29 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E3F1018A1;
	Fri, 11 Mar 2022 01:24:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E3F1018A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646958327;
	bh=hfRBmwVghNbcVI9cBhUy/gGposRjrhs72wQ5qRBn244=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DPJdG2/jYSapZgR3wfTos5rC8K1X5c01MqCZtWhK3X+zB0MabZvEkd7cIV0jaDGSE
	 4BLa/9iJ4s8MmxQd5zPESJRnqmE1/NxI4uoev5Jt988S1DJIpzn1NQXidCPCLt/sRj
	 ynCrKd4tAmoroVsRQME/WxEg2D5zvG1TAObm7zfE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5CE31F8012F;
	Fri, 11 Mar 2022 01:24:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0C02CF80137; Fri, 11 Mar 2022 01:24:35 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 7BA3AF800FD
 for <alsa-devel@alsa-project.org>; Fri, 11 Mar 2022 01:24:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7BA3AF800FD
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1646958271190315962-webhooks-bot@alsa-project.org>
References: <1646958271190315962-webhooks-bot@alsa-project.org>
Subject: Presence of "default" device name crashes unity3d games
Message-Id: <20220311002435.0C02CF80137@alsa1.perex.cz>
Date: Fri, 11 Mar 2022 01:24:35 +0100 (CET)
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

alsa-project/alsa-lib issue #214 was opened from the3dfxdude:

In a recent Slackware 15.0 distro release, the alsa-lib version is now 1.2.5.1. This causes a crash in Kerbal Space Program similar to issue #27. A change was made to close issue #27 in alsa-lib 1.2.3. That change did not correct the crash however in 1.2.3 or 1.2.5.1 in my case.

This is the noted difference for "aplay -L" between 1.2.3 and 1.2.1:
--- dump_1_2_1	2022-03-10 12:38:16.991433004 -0700
+++ dump_1_2_3	2022-03-10 12:37:53.467443226 -0700
@@ -1,5 +1,9 @@
 null
     Discard all samples (playback) or generate zero samples (capture)
+default
+    Default Audio Device
+sysdefault
+    Default Audio Device
 default:CARD=IXP
     ATI IXP, ATI IXP AC97
     Default Audio Device

Removing this "default" device entry fixes the issue on this system. You may remove the default device name by editing src/conf/pcm/default.conf and adding under the hint section "omit_noargs true".

Unity must be parsing the device name, and with certain device names, if there is no ':' doing something bad, as there is a pattern here on what it trips on. I have no idea how to get them to correct this, so opening the issue here at least for the record if anyone else has an issue with this.

Also, I am not sure what triggers "default" to show. I did a survey and 3 out of 5 of my slackware 15.0 systems have it. And 2 do not. Does this have something to do with parsing the system alsa config and the available sound devices in the system? I don't define any asound.conf for any of these, so these are almost 100% stock slackware systems, there should otherwise be no difference.

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/214
Repository URL: https://github.com/alsa-project/alsa-lib
