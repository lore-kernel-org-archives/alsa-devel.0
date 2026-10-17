Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9346CCF2C1
	for <alsa-devel@archiver.kernel.org>; Sat, 17 Oct 2026 10:10:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9245F601EF;
	Sat, 17 Oct 2026 12:10:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9245F601EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1792231813;
	bh=aOxfPbMGvaAVvnjTMRAD0YPLb9tavDFsQ6Dx39TSM2o=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=VYQzF3sayuKYF0OBqU5bRw9Wc/o8zNjWwcwNZz2M8685BZ8TfCHsqZ0DC32lGlMrp
	 9fMvZRAUJJlMUtfmvMq+T1VPy13Nw9iO+3lV+6G5y25k8UgrrDBESdZXm7vX7GdQkl
	 AmoJvgJPS0eNxCxXz1glPhdjLB5HxBERPS08yg+o=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2055EF80601; Sat, 17 Oct 2026 12:09:36 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 40808F805F8;
	Sat, 17 Oct 2026 12:09:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 467C1F804F2; Sat, 17 Oct 2026 12:09:28 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1792231767;
	b=i2nqft54k78cXUBTxh4Z0D9+prIy1hTs4XePrlk7ox7++eGIPtrOPaIdexZIeMp5pEyE
	 BsOjTJl3n6rsk62zq68AB//awBjLFKU2TXcH9Enqp4mEXvic5b/oxwxT4stzAe+qsJTj6
	 lVgjJHzxYvEEHHPwjsnqPaAbhB+Yva79qyQVmvmochVSaZnGImDh17iCjCFraLcXYvJYs
	 1uNcQxlJWNreJiKtZb/toujAdxnJ3/DIU0o3Kf/BvlbUci6YCJ5wGOsMBFp77sF3Xeunn
	 NS9le4Q4LJkAtTebfEfZzyaSgBkouxQYOnp9msCSsxQ1jG7HeP2AeCwR/yXzfE/mmhw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1792231767;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=aOxfPbMGvaAVvnjTMRAD0YPLb9tavDFsQ6Dx39TSM2o=;
	b=f+FncEo0z3T2vwZi/lMJFl9WUM31yut6r3fvhCnY6YMNFb0B6p7ZfKCPxjfGgB8dPb61
	 wNt/U2m5msPr0qB3suAYDso2PjaBUUd4ND0cd/RjYy3LajULKijohqKcJAquZFQ2rZO5V
	 O9aKNhwmif0/NPZgr62J2VcAL2BeFhEMlk1uVGIej/6eStXymmvvkW7aYTIpiDkMADOHY
	 IQgd5ZN6yR8vLak0alL/S/QA9r0FabqlnjIsBa6SyQ7kTa6KuMeqyQ9ZbgwV6B/aW895+
	 12Be0kCkmpPthDoyZMdFvFTTafUr13muJ5BoSrxYXDvza7c0mlQILL4z/bmxv2JzAHw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 56EB0F80071
	for <alsa-devel@alsa-project.org>; Sat, 17 Oct 2026 12:09:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 56EB0F80071
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18df494b8c89ce00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/886@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/886@alsa-project.org>
Subject: ucm2: codecs: tas2783: use the real speaker switch names
Date: Sat, 17 Oct 2026 12:09:28 +0200 (CEST)
Message-ID-Hash: Y3XEDQBRMUB3D7BKYAPKW6RKTYCGMZTV
X-Message-ID-Hash: Y3XEDQBRMUB3D7BKYAPKW6RKTYCGMZTV
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/Y3XEDQBRMUB3D7BKYAPKW6RKTYCGMZTV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #886 was opened from gjouret:

The tas2783-sdw driver registers its per-amp speaker switches as
'Left Spk Switch', 'Right Spk Switch', 'Left Spk2 Switch' and
'Right Spk2 Switch' (amixer shows them as the simple controls
'Left Spk' ... with the 'Switch' suffix stripped). The BootSequence
uses the simple names, which match no control element, so the
csets fail and the amps keep whatever state they had:

  $ amixer -c sofsoundwire cget name='Left Spk'
  amixer: Cannot find the given element from control sysdefault:0
  $ amixer -c sofsoundwire cget name='Left Spk Switch'
  numid=18,iface=MIXER,name='Left Spk Switch'
    ...
    : values=on   (output trimmed)

Tested on an HP OmniBook Ultra 14 (board 8EB4, four TAS2783 on two
SoundWire links), kernel 7.2.5: with the full names all four
speakers are switched on at card init.

Fixes: 182d0122a7d9 ("ucm2: sof-soundwire: Add tas2783 support")
Signed-off-by: Guido Jouret <gjouret@gmail.com>

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/886
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/886.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
