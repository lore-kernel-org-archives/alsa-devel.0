Return-Path: <SRS0=L7tj=54=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144EBC2BA2B
	for <alsa-devel@archiver.kernel.org>; Sun, 12 Apr 2020 08:16:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB440206E9
	for <alsa-devel@archiver.kernel.org>; Sun, 12 Apr 2020 08:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="OTa/eJjo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB440206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1FFB216B6;
	Sun, 12 Apr 2020 10:15:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1FFB216B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586679405;
	bh=AYD9Ys+9NCCxqsrAUQ7vy5Io3DcHAH6gEtMoOLhAoxU=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=OTa/eJjomtYjZn8CEGsQ5BvfklZ9NwK1/hv7e/Cx99Ah7ly24EXZI2uPE5apEidyp
	 x63AUUdIhAZcMwoJUL8lSlpjM1EmTEVrjq2vuCb5U9m0yr5NxHlB/m/EFqZUkCPxeo
	 XEgoMWAlxhcg8oqvQNlF+WXakPK2AkZ5WYDd2YGQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 86A3AF8028C;
	Sun, 12 Apr 2020 10:14:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 01F43F8016F; Sun, 12 Apr 2020 10:13:45 +0200 (CEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EB4A1F8014E
 for <alsa-devel@alsa-project.org>; Sun, 12 Apr 2020 10:13:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EB4A1F8014E
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 0F683AC84
 for <alsa-devel@alsa-project.org>; Sun, 12 Apr 2020 08:13:36 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/4] ALSA: usb-audio: More workarounds for TRX40-mobos
Date: Sun, 12 Apr 2020 10:13:27 +0200
Message-Id: <20200412081331.4742-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
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

Hi,

it turned out that the recent mobos shipped with Realtek codec need
more workarounds.  In the end, most of the fixes here are generic
issues, hence marked for stable.

The bugtracker is at:
  https://bugzilla.kernel.org/show_bug.cgi?id=206873

Takashi

===

Takashi Iwai (4):
  ALSA: usb-audio: Filter error from connector kctl ops, too
  ALSA: usb-audio: Don't override ignore_ctl_error value from the map
  ALSA: usb-audio: Don't create jack controls for PCM terminals
  ALSA: usb-audio: Check mapping at creating connector controls, too

 sound/usb/mixer.c      | 31 +++++++++++++++++++------------
 sound/usb/mixer_maps.c |  4 +++-
 2 files changed, 22 insertions(+), 13 deletions(-)

-- 
2.16.4

