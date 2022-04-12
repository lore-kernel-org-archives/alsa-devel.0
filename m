Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA71C433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Apr 2022 10:30:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6E668189F;
	Tue, 12 Apr 2022 12:29:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6E668189F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1649759418;
	bh=IiK2Y5Ty+aQiUmnhd9R90q798LCOLIpA3vy9ovLFmKk=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=SVzBcIqNJBeARqQhqhjvykxl9o8hyjhop/TaxqAtj6Z5aPu+U7BS9b7Xznbj+0F4/
	 2ABCyMXdvEB4rWlrevqPRaWPRxE6yuiEh/mk1UdCwthWwtsCEt6XK2VGLH458me/52
	 Iba8606V6zwQMpt3m/QMk2oLYSlZ7rdgleH+JyyY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C6826F80579;
	Tue, 12 Apr 2022 12:27:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0728EF80570; Tue, 12 Apr 2022 12:27:07 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 96C50F8032B
 for <alsa-devel@alsa-project.org>; Tue, 12 Apr 2022 12:26:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 96C50F8032B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="1nO91n0U"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="m9woTois"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 3F09F1F858
 for <alsa-devel@alsa-project.org>; Tue, 12 Apr 2022 10:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1649759204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5s2EZZkRuOXAt3/XGB7O4hhaekHx96pPf4ZsY6o1erA=;
 b=1nO91n0U6QDUW7/lI5uxy34c8gRuwWloAxim4KARETQdRkpoql3fdUdf0A8vm15y1eMZhq
 z+oaY0DDwDkeRn9925Lpdh4OcFyhBJ5S76rYcC1K10778vXhzd5MQSnPBOqAxOjjZL6lLC
 Km8lfruY7Pro9ING0+9MBVHYQVeG0lI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1649759204;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5s2EZZkRuOXAt3/XGB7O4hhaekHx96pPf4ZsY6o1erA=;
 b=m9woToisn0U96/MX65bTAqq8aGS0o2TskpMiysGOx7IyNFqlCDl0G91kLEu2N1Vm3w9xlZ
 Q8JJ2y0KJSdwYtCw==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id 2DE97A3B82;
 Tue, 12 Apr 2022 10:26:44 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 00/39] ALSA: Fix error handling order at probe error
Date: Tue, 12 Apr 2022 12:25:57 +0200
Message-Id: <20220412102636.16000-1-tiwai@suse.de>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

this is a bunch of additional fixes that are similar like the previous
patch set for echoaudio but applied to other drivers that suffer from
the very same issue -- the incorrect error handling order at the
probe error.

Most of patches just follow the same strategy, the use of the new
snd_card_free_on_error() helper while some few took just the manual
snd_card_free() call and some with shuffling the private_free setup
for avoiding the problem.


Takashi

===

Takashi Iwai (39):
  ALSA: galaxy: Fix the missing snd_card_free() call at probe error
  ALSA: sc6000: Fix the missing snd_card_free() call at probe error
  ALSA: ad1889: Fix the missing snd_card_free() call at probe error
  ALSA: ali5451: Fix the missing snd_card_free() call at probe error
  ALSA: als4000: Fix the missing snd_card_free() call at probe error
  ALSA: atiixp: Fix the missing snd_card_free() call at probe error
  ALSA: au88x0: Fix the missing snd_card_free() call at probe error
  ALSA: azt3328: Fix the missing snd_card_free() call at probe error
  ALSA: ca0106: Fix the missing snd_card_free() call at probe error
  ALSA: cs4281: Fix the missing snd_card_free() call at probe error
  ALSA: cs5535audio: Fix the missing snd_card_free() call at probe error
  ALSA: emu10k1x: Fix the missing snd_card_free() call at probe error
  ALSA: ens137x: Fix the missing snd_card_free() call at probe error
  ALSA: es1938: Fix the missing snd_card_free() call at probe error
  ALSA: es1968: Fix the missing snd_card_free() call at probe error
  ALSA: fm801: Fix the missing snd_card_free() call at probe error
  ALSA: ice1724: Fix the missing snd_card_free() call at probe error
  ALSA: intel8x0: Fix the missing snd_card_free() call at probe  error
  ALSA: korg1212: Fix the missing snd_card_free() call at probe  error
  ALSA: maestro3: Fix the missing snd_card_free() call at probe error
  ALSA: riptide: Fix the missing snd_card_free() call at probe error
  ALSA: rme32: Fix the missing snd_card_free() call at probe error
  ALSA: rme96: Fix the missing snd_card_free() call at probe error
  ALSA: sonicvibes: Fix the missing snd_card_free() call at probe error
  ALSA: via82xx: Fix the missing snd_card_free() call at probe error
  ALSA: intel_hdmi: Fix the missing snd_card_free() call at probe error
  ALSA: sis7019: Fix the missing error handling
  ALSA: bt87x: Fix the missing snd_card_free() call at probe error
  ALSA: lola: Fix the missing snd_card_free() call at probe error
  ALSA: als300: Fix the missing snd_card_free() call at probe error
  ALSA: aw2: Fix the missing snd_card_free() call at probe error
  ALSA: cmipci: Fix the missing snd_card_free() call at probe error
  ALSA: lx6464es: Fix the missing snd_card_free() call at probe error
  ALSA: oxygen: Fix the missing snd_card_free() call at probe error
  ALSA: hdsp: Fix the missing snd_card_free() call at probe error
  ALSA: hdspm: Fix the missing snd_card_free() call at probe error
  ALSA: rme9652: Fix the missing snd_card_free() call at probe error
  ALSA: mtpav: Don't call card private_free at probe error path
  ALSA: nm256: Don't call card private_free at probe error path

 sound/drivers/mtpav.c               |  4 ++--
 sound/isa/galaxy/galaxy.c           |  7 ++++++-
 sound/isa/sc6000.c                  |  7 ++++++-
 sound/pci/ad1889.c                  | 10 ++++++++--
 sound/pci/ali5451/ali5451.c         | 10 ++++++++--
 sound/pci/als300.c                  |  8 ++++++--
 sound/pci/als4000.c                 | 10 ++++++++--
 sound/pci/atiixp.c                  | 10 ++++++++--
 sound/pci/atiixp_modem.c            | 10 ++++++++--
 sound/pci/au88x0/au88x0.c           |  8 +++++++-
 sound/pci/aw2/aw2-alsa.c            |  8 ++++++--
 sound/pci/azt3328.c                 |  8 +++++++-
 sound/pci/bt87x.c                   | 10 ++++++++--
 sound/pci/ca0106/ca0106_main.c      | 10 ++++++++--
 sound/pci/cmipci.c                  |  8 ++++++--
 sound/pci/cs4281.c                  | 10 ++++++++--
 sound/pci/cs5535audio/cs5535audio.c | 10 ++++++++--
 sound/pci/emu10k1/emu10k1x.c        | 10 ++++++++--
 sound/pci/ens1370.c                 | 10 ++++++++--
 sound/pci/es1938.c                  | 10 ++++++++--
 sound/pci/es1968.c                  | 10 ++++++++--
 sound/pci/fm801.c                   | 10 ++++++++--
 sound/pci/ice1712/ice1724.c         | 10 ++++++++--
 sound/pci/intel8x0.c                | 10 ++++++++--
 sound/pci/intel8x0m.c               | 10 ++++++++--
 sound/pci/korg1212/korg1212.c       |  8 ++++++--
 sound/pci/lola/lola.c               | 10 ++++++++--
 sound/pci/lx6464es/lx6464es.c       |  8 ++++++--
 sound/pci/maestro3.c                |  8 +++++++-
 sound/pci/nm256/nm256.c             |  2 +-
 sound/pci/oxygen/oxygen_lib.c       | 12 +++++++++++-
 sound/pci/riptide/riptide.c         |  8 +++++++-
 sound/pci/rme32.c                   |  8 +++++++-
 sound/pci/rme96.c                   | 10 ++++++++--
 sound/pci/rme9652/hdsp.c            |  8 ++++++--
 sound/pci/rme9652/hdspm.c           |  8 ++++++--
 sound/pci/rme9652/rme9652.c         |  8 ++++++--
 sound/pci/sis7019.c                 | 14 ++++++++++----
 sound/pci/sonicvibes.c              | 10 ++++++++--
 sound/pci/via82xx.c                 | 10 ++++++++--
 sound/pci/via82xx_modem.c           | 10 ++++++++--
 sound/x86/intel_hdmi_audio.c        |  7 ++++++-
 42 files changed, 301 insertions(+), 76 deletions(-)

-- 
2.31.1

