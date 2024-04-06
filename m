Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF5C1CD128A
	for <alsa-devel@archiver.kernel.org>; Sat,  6 Apr 2024 07:07:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 109F52D1A;
	Sat,  6 Apr 2024 09:06:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 109F52D1A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1712387225;
	bh=N0bTxMevMmBLUSV0tGAdxWcGwmSg8SMJcqX+Dczo9zw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=Lymcv53lP7RSna9lABJw9Sn+tO7U5BhSuyCR4BLS//iOqNnYKHpBLBY1/xDeZSjIF
	 TW8CYoeeRnVW7KAifmwgOZ5UtL817ghzfTZZm5WR4P38VufTKjkEus0t7svH2r2Jj9
	 xCM8bVcfnglI2XmeazOQdJ7U86Ez+LBJ5rskCgWw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 401A0F805A0; Sat,  6 Apr 2024 09:06:30 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 122ADF805A8;
	Sat,  6 Apr 2024 09:06:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BC8FCF8056F; Sat,  6 Apr 2024 08:49:22 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id ACD66F80568
	for <alsa-devel@alsa-project.org>; Sat,  6 Apr 2024 08:48:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ACD66F80568
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de
 header.a=rsa-sha256 header.s=s31663417 header.b=fIjaPdHt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1712386111; x=1712990911;
	i=oswald.buddenhagen@gmx.de;
	bh=QXdMSplDvZwNOV8wYThgcUxdrpx0xDRvIN39SPaFaZc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=fIjaPdHtJjSuRy4pUSLDBqYmzJoDZUZk/RTkL0RPNeIL0xZEzkPkcivzUG+dE7YU
	 h1P4OEkmMYHoCDkcEUw2kfaiMu6G2cnEvj1R2D9LRXwh1zO8w6ddptsLX7WdChDk7
	 TN7ABulK9POk+Tsx8laCQrEIIBEN6G9ZvktUqP5UkOGVnt20KnSUOcJhacws5cxTh
	 4X7x8cZcqmRGdywxXGWsbacAbxaERjFuYuPM1s9KTDVt7zOVk11sJtYHUte0+Xukp
	 urqasB1r39ValYKLoduzaGoGq2yF4nJaNQpqDVFGTmOGEkqb2AJmMPXwG6gTir1M1
	 n2206wHhjL3GjJ0VXQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ugly.fritz.box ([89.247.162.118]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MaJ7v-1sGFsw0Zan-00WEyC; Sat, 06
 Apr 2024 08:48:31 +0200
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
	id 1rszqo-JqR-00; Sat, 06 Apr 2024 08:48:30 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Jaroslav Kysela <perex@perex.cz>,
	Arthur Marsh <arthur.marsh@internode.on.net>
Subject: [PATCH v3 00/17] ALSA: emu10k1 & emux: fixes related to wavetable
 playback
Date: Sat,  6 Apr 2024 08:48:13 +0200
Message-ID: <20240406064830.1029573-1-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.44.0.701.g2cf7baacf3.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6rkDgGrsdFlBnWYzDFEl5zoCZ8CHlLyyBOihePWRYPVT1ERAm9g
 LbCTCHAbOQCmAnlZ95gdslPeMcXFdKMJhAxulY+cFrECBEplPFk9W0aMTitzG6pG6crOsPs
 adUaG2DQzEg93OEzxWSH3Qah3EWWYokCrWulIWTPYLnCkWKPnQs1zUfFO6l6afbrOnzSNiI
 YclnwRfjXeyJtwoQ7O9uw==
UI-OutboundReport: notjunk:1;M01:P0:gIYxt62bt5U=;PSVAvquMNzcrWhX2SmQuGoLu4+d
 FDHIbpx6xI/x2Q4+SGptIBMi+DoZkHcrPZVrBqpCx/aaav2XHqpDG0N1DUGbvqvIjJbSy/zUt
 M2/vkBcUhIZ5dzWxblXkCTeEU8K+QOvY+ZlIunLCj4uhJRIovnt3lhEfZOWqeSPyc+Dwiy92D
 f8MCGFdiwMuRiSuL4CucWckR9hsvGQY2E6bhrq/zh+GvGZB0bMM71gVr4uEu7HQvJfO3tZVEQ
 +Su3IpLksUArLecTmclZEOTMOFJ7xU3s7W/StzBs+/ejtR/1gHAd3ti2SCSoRXWCGhLOEBNFV
 i61fCRfoCs+z33OiOxRq+C3loRezdBMvTOm5etZkJouibKLAohumgEjZxzrRq92R3OZ7qYGAy
 +4eDTDbzkJv78d9lm5nueGtjp4LXz7GWY1NPXM4qLtnlW4IcVpdjVsSaK1padvDJouAZv1Blx
 z+LGRscPReJ1iBqoI3I9/+cuZRPIUdBi21AlVoMXIvGRD16kCic+42Q5H45wG+++AqiHlx5Oz
 6tfXcYvHKSyQ7QjvWNzP71+qbx4iChcc680J3h3TYRIHaD48vBSvlnAGHfh2rmUbceJtuWmfT
 t6/QMtL0xkMn5mXOt/9kXgY8lF/OBOtemOXhzNJbuHDKNxg6hRxPc8XSXJeOA1u/MAlnshkIC
 +jdEUN3Z6dNmr+tvrUDZWdb932sPmfTaCnrcps4Mo+fP6HWnqCfpCdqtyR/cWvUzo5upnHMLM
 v9pVcQuPJLyRCRNfVSI1YpCr2XRepa5VSCwSIfAxXfnrgbSAanmZJQTCuwp9kbvq5ItFRvElB
 bkMx367OyDundsRLwVxwqautYu09uRJeBApJQpCOECX7M=
Message-ID-Hash: SXPWNHCYJSZRMDE7ZCNIPNNSW2H4KGGY
X-Message-ID-Hash: SXPWNHCYJSZRMDE7ZCNIPNNSW2H4KGGY
X-MailFrom: oswald.buddenhagen@gmx.de
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SXPWNHCYJSZRMDE7ZCNIPNNSW2H4KGGY/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

---
v3:
- re-send with safer transfer encoding
v2:
- rebased on top of reverting problematic commit first

Oswald Buddenhagen (17):
  ALSA: emux: fix /proc teardown at module unload
  ALSA: emux: prune unused parameter from snd_soundfont_load_guspatch()
  ALSA: emux: fix validation of snd_emux.num_ports
  ALSA: emux: fix init of patch_info.truesize in load_data()
  ALSA: emu10k1: prune vestiges of
    SNDRV_SFNT_SAMPLE_{BIDIR,REVERSE}_LOOP support
  ALSA: emux: centralize & improve patch info validation
  ALSA: emux: improve patch ioctl data validation
  ALSA: emu10k1: move patch loader assertions into low-level functions
  ALSA: emu10k1: fix sample signedness issues in wavetable loader
  ALSA: emu10k1: fix playback of 8-bit wavetable samples
  ALSA: emu10k1: merge conditions in patch loader
  ALSA: emu10k1: fix wavetable offset recalculation
  ALSA: emu10k1: de-duplicate size calculations for 16-bit samples
  ALSA: emu10k1: improve cache behavior documentation
  ALSA: emu10k1: fix wavetable playback position and caching, take 2
  ALSA: emu10k1: shrink blank space in front of wavetable samples
  ALSA: emux: simplify snd_sf_list.callback handling

 include/sound/emu10k1.h              |  32 +++--
 include/sound/soundfont.h            |   2 +-
 sound/isa/sb/emu8000_patch.c         |  13 --
 sound/pci/emu10k1/emu10k1_callback.c |  13 +-
 sound/pci/emu10k1/emu10k1_patch.c    | 207 +++++++++++----------------
 sound/pci/emu10k1/memory.c           |  55 +++++--
 sound/synth/emux/emux.c              |   6 +-
 sound/synth/emux/emux_hwdep.c        |   3 +-
 sound/synth/emux/emux_oss.c          |   3 +-
 sound/synth/emux/emux_proc.c         |   1 +
 sound/synth/emux/emux_seq.c          |   6 +-
 sound/synth/emux/soundfont.c         |  73 +++++++---
 12 files changed, 219 insertions(+), 195 deletions(-)

--=20
2.44.0.701.g2cf7baacf3.dirty

