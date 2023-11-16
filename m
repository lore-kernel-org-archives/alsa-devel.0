Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D505C54FB9
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Nov 2023 15:35:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1F13EDF;
	Thu, 16 Nov 2023 16:34:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1F13EDF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1700148929;
	bh=0EwvY1Ubt0pHp3BgS2MzL3aPuW3KfF3kis4J0fLkSTA=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=WSEGvzaDpIV7o6fM6RvCAEDGtXIQZVvPRoSt3+sJhAZGKp73hAKHrJVfEb/XqfAl+
	 TyGZqzIZKJsmwWhyGYAGe+IyItQlOgSQofyKjrQBofZ2hVmyQBr5yezcnBPY67BaDg
	 Sdo/6sZ7+MLarTBAb8AuA494fd3XwitOYNPuNQ8A=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C9BBBF8055C; Thu, 16 Nov 2023 16:34:11 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 62570F801D5;
	Thu, 16 Nov 2023 16:34:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A8323F801D5; Thu, 16 Nov 2023 16:34:05 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id EF6C0F800ED
	for <alsa-devel@alsa-project.org>; Thu, 16 Nov 2023 16:33:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EF6C0F800ED
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1700148837793172836-webhooks-bot@alsa-project.org>
References: <1700148837793172836-webhooks-bot@alsa-project.org>
Subject: Speaker volume control doesn't work by default on Lenovo Yoga 7 (AMD
 7840hs)
Message-Id: <20231116153405.A8323F801D5@alsa1.perex.cz>
Date: Thu, 16 Nov 2023 16:34:05 +0100 (CET)
Message-ID-Hash: ZENCFTV4XPTAX5NSSBB7AGOPLYTOY3GD
X-Message-ID-Hash: ZENCFTV4XPTAX5NSSBB7AGOPLYTOY3GD
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZENCFTV4XPTAX5NSSBB7AGOPLYTOY3GD/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib issue #366 was opened from smaug----:

(Not sure which alsa-repo is the correct one for this issue, or is this even a Fedora issue)
By default controlling headphone output volume works, but speaker output seems to be either muted or very loud. 

The following tweak fixes the issue.

+++ /usr/share/alsa-card-profile/mixer/paths/analog-output-speaker.conf	2023-11-14 02:45:24.182339962 +0200
@@ -79,8 +79,6 @@
 override-map.2 = all-left,all-right
 
 [Element Master]
-switch = mute
-volume = merge
 override-map.1 = all
 override-map.2 = all-left,all-right
 
@@ -243,4 +241,8 @@
 override-map.1 = all-center
 override-map.2 = all-center,lfe
 
+[Element Master]
+switch = mute
+volume = ignore
+
 .include analog-output.conf.common

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/366
Repository URL: https://github.com/alsa-project/alsa-lib
