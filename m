Return-Path: <SRS0=NgmJ=CM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD51C433E2
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:43:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EF8E20716
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hlq4uiJk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EF8E20716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5A09218E8;
	Thu,  3 Sep 2020 12:42:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5A09218E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599129814;
	bh=yu4UJM3JG1lL+IHiYd3JKbTapxGRWF5jjHDKkDjFfqM=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hlq4uiJk+mriPP4tP3UUFrn9D2MuMjnI9QGO3MwJu0/SNTOq9TAINsjnWpFx/M5pj
	 6SvEu2UR6JmXLPY7ukjp2H7uLl7YMIev/egw36TWmKOrueuCA9h/3ZO/+da11IoH1d
	 9BpXiDlxUrIygt3QPZpwk9O4l/AR+0YqOpxp+EmM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0620FF802DD;
	Thu,  3 Sep 2020 12:41:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 48BD8F802DB; Thu,  3 Sep 2020 12:41:49 +0200 (CEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6431EF800BA
 for <alsa-devel@alsa-project.org>; Thu,  3 Sep 2020 12:41:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6431EF800BA
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id A43F6AF40;
 Thu,  3 Sep 2020 10:41:38 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 00/11] ALSA: Kill tasklet usage
Date: Thu,  3 Sep 2020 12:41:20 +0200
Message-Id: <20200903104131.21097-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Cc: Clemens Ladisch <clemens@ladisch.de>
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

here is a patch set to convert the tasklet usage in sound tree with
either the threaded irq or the dedicated work.  It's applied after the
tasket API conversion series, found in topic/tasklet-convert branch of
sound git tree (which will be included in the next pull request for
5.9-rc4).

This contains only non-ASoC changes, the changes for ASoC will
follow at next.


Takashi

===

Takashi Iwai (11):
  ALSA: pcsp: Replace tasklet with work
  ALSA: timer: Replace tasklet with work
  ALSA: usb-audio: Replace tasklet with work
  ALSA: ua101: Replace tasklet with work
  ALSA: aloop: Replace tasklet with work
  ALSA: hdsp: Replace tasklet with work
  ALSA: hdspm: Replace tasklet with work
  ALSA: riptide: Replace tasklet with threaded irq
  ALSA: asihpi: Replace tasklet with threaded irq
  ALSA: firewire: Replace tasklet with work
  ALSA: mixart: Correct comment wrt obsoleted tasklet usage

 include/sound/timer.h               |  8 +++---
 sound/core/hrtimer.c                |  2 +-
 sound/core/timer.c                  | 20 +++++++-------
 sound/drivers/aloop.c               | 23 ++++++++--------
 sound/drivers/pcsp/pcsp_lib.c       | 12 ++++----
 sound/firewire/amdtp-stream-trace.h |  2 +-
 sound/firewire/amdtp-stream.c       | 25 +++++++++--------
 sound/firewire/amdtp-stream.h       |  2 +-
 sound/pci/asihpi/asihpi.c           | 28 ++-----------------
 sound/pci/asihpi/hpioctl.c          | 16 +++++++++--
 sound/pci/mixart/mixart.h           |  2 +-
 sound/pci/riptide/riptide.c         | 20 ++++++++------
 sound/pci/rme9652/hdsp.c            | 55 ++++++++++++++++++-------------------
 sound/pci/rme9652/hdspm.c           | 13 ++++-----
 sound/usb/midi.c                    | 13 +++++----
 sound/usb/misc/ua101.c              | 16 +++++------
 16 files changed, 122 insertions(+), 135 deletions(-)

-- 
2.16.4

