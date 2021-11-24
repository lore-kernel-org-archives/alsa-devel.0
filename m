Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C38B3C433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Nov 2021 04:24:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1DA841671;
	Wed, 24 Nov 2021 05:23:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1DA841671
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637727850;
	bh=0QdGYmscw1tQBvj/bGRTDW/6dEBuk1H0oELxSUCWa4I=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NoXwCngP/I0eRFgK+amkM6BrAcuVHFsUgPI5LcdP3qcKLQyj1lj4vwn+zbHPCwJ4b
	 LYJVMm/yzLPxJgmL5ZF0rjFUbuPhaCvSVpoliNzSf/izlocmYMTLcxvlz+usauYLYz
	 GXS05CB9ApkuKh/bBjtMUcNwl7Ch/KS3sRrxmWfg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9F527F8014D;
	Wed, 24 Nov 2021 05:23:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 80EABF801F7; Wed, 24 Nov 2021 05:23:17 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 9588EF8011F
 for <alsa-devel@alsa-project.org>; Wed, 24 Nov 2021 05:23:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9588EF8011F
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1637727793699150085-webhooks-bot@alsa-project.org>
References: <1637727793699150085-webhooks-bot@alsa-project.org>
Subject: Creating UCM2 profiles for devices to split multichannel streams
Message-Id: <20211124042317.80EABF801F7@alsa1.perex.cz>
Date: Wed, 24 Nov 2021 05:23:17 +0100 (CET)
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

alsa-project/alsa-ucm-conf issue #122 was opened from brndd:

Hey. Apologies for this question-issue, but I wasn't sure where to ask and figured it was better to do it here in public (so that others may benefit from the discussion) than ask by email or something.

I randomly stumbled upon #121 which is about creating a UCM2 profile for the TC-Helicon GoXLR device to split some multichannel streams to better match the physical layout of the device.

I had no idea this was possible with UCM2 (in fact I looked at UCM2 for this a few months ago and got the impression that it was *not* possible), and would be interested in creating a similar profile for my device, a Behringer UMC204HD. This device has a similar problem of reporting a stereo input stream when the physical layout is two mono inputs, and a 4-channel output stream when the physical layout is two stereo outputs. Thus far I've been using PulseAudio/PipeWire remappings to get around the issue, but a UCM2 profile would be a far superior solution, if indeed it is possible.

So, my questions are:
- Is being able to split streams like this a new feature of ALSA/UCM2? How do I know if my system (Fedora 34) supports this feature?
- Is there documentation somewhere to get me started with writing a config for my device? I have no idea what half the stuff in https://github.com/alsa-project/alsa-ucm-conf/commit/97beee6ded9e3dddfb56580eee360088fbfa8595 means so I'm expecting to fall into some pits during the process ;)

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/122
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
