Return-Path: <SRS0=nH8J=HR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EEDBC433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Feb 2021 17:25:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A02964DDA
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Feb 2021 17:25:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A02964DDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E68191664;
	Mon, 15 Feb 2021 18:24:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E68191664
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1613409927;
	bh=k46tMy/KO6aVASZ2NZEzvdDeZnea4vqmLTDT73hUv3I=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Lmp3MypMM0qCqupcfApKqF7Qxps9CWseIp1/im5WLLvfEhi8qT5RzsQOA03G+CueY
	 WQJ5nwTJ5nHCG/ZuQGYobzhg7iGesgneE1D3RBVs8UNhSsibgq/uj4xh5uv2ev3WWL
	 IF3ltg4YSylIZf0Tuf9bP5XeosNpNOZuPNB3qFms=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2B028F80258;
	Mon, 15 Feb 2021 18:24:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1CB2DF80258; Mon, 15 Feb 2021 18:24:34 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CC8A9F800AE
 for <alsa-devel@alsa-project.org>; Mon, 15 Feb 2021 18:24:29 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 1A459A003F;
 Mon, 15 Feb 2021 18:24:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 1A459A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1613409869; bh=ezuL+S0oagQWNa+MVzQi1GCzv+QYneJPK7wJP/3lQt8=;
 h=From:To:Cc:Subject:Date:From;
 b=IqxP3eoqJqwtqsbM9D9ZQueGWGRt/IZiAuPCP9ObsPITBbgYkW0dfH8SahrcNHHS9
 xGyZlA1qbeePW5SdTJNcUuG+QANYhwH3/KMoZhPsQXpiOaXU7mT5KoVWW8o+5bSlz7
 o39ivbMRb/e3wCQkhp7ZitHottqjs3x5ZY9kk2hI=
Received: from p1gen2.perex-int.cz (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Mon, 15 Feb 2021 18:24:23 +0100 (CET)
From: Jaroslav Kysela <perex@perex.cz>
To: ALSA development <alsa-devel@alsa-project.org>
Subject: [PATCH v2 0/5] ALSA: control - add generic LED API
Date: Mon, 15 Feb 2021 18:24:13 +0100
Message-Id: <20210215172418.1322825-1-perex@perex.cz>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>, Hans de Goede <hdegoede@redhat.com>,
 Perry Yuan <Perry.Yuan@dell.com>
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

This patchset tries to resolve the diversity in the audio LED
control among the ALSA drivers. A new control layer registration
is introduced which allows to run additional operations on
top of the elementary ALSA sound controls.

A new control access group (three bits in the access flags)
was introduced to carry the LED group information for
the sound controls. The low-level sound drivers can just
mark those controls using this access group. This information
is exported to the user space and eventually the user space
can create sound controls which can belong to a LED group.

The actual state ('route') evaluation is really easy
(the minimal value check for all channels / controls / cards).
If there's more complicated logic for a given hardware,
the card driver may eventually export a new read-only
sound control for the LED group and do the logic itself.

The new LED trigger control code is completely separated
and possibly optional (there's no symbol dependency).
The full code separation allows eventually to move this
LED trigger control to the user space in future.
Actually it replaces the already present functionality
in the kernel space (HDA drivers) and allows a quick adoption
for the recent hardware (SoundWire / ASoC codecs).

# lsmod | grep snd_ctl_led
snd_ctl_led            16384  0

The sound driver implementation is really easy:

1) call snd_ctl_led_request() when control LED layer should be
   automatically activated
   / it calls module_request("snd-ctl-led") on demand /
2) mark all related kcontrols with
	SNDRV_CTL_ELEM_ACCESS_SPK_LED or
	SNDRV_CTL_ELEM_ACCESS_MIC_LED

v2 changes:
  - fix the locking - remove the controls_rwsem read lock
    in the element get (the consistency is already protected
    with the global snd_ctl_led_mutex and possible partial
    value writes are catched with the next value change
    notification callback)
  - rename state to brightness and show the brightness
    unsigned integer value instead the text on/off string
    (sync with the LED core routines)
  - remove snd_ctl_led_hello() function (CI warning)
  - make snd_ctl_led_get_by_access() function static (CI warning)
  - move snd_ctl_layer_rwsem lock before the registraction
    callback call in snd_ctl_register_layer() - optimization
v1:
  - https://lore.kernel.org/alsa-devel/20210211111400.1131020-1-perex@perex.cz/
Original RFC:
  - https://lore.kernel.org/alsa-devel/20210207201157.869972-1-perex@perex.cz/

Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Perry Yuan <Perry.Yuan@dell.com>

Jaroslav Kysela (5):
  ALSA: control - introduce snd_ctl_notify_one() helper
  ALSA: control - add layer registration routines
  ALSA: control - add generic LED trigger module as the new control
    layer
  ALSA: HDA - remove the custom implementation for the audio LED trigger
  ALSA: control - add sysfs support to the LED trigger module

 include/sound/control.h         |  27 ++-
 include/uapi/sound/asound.h     |   6 +-
 sound/core/Kconfig              |   6 +
 sound/core/Makefile             |   2 +
 sound/core/control.c            | 173 ++++++++++++---
 sound/core/control_led.c        | 378 ++++++++++++++++++++++++++++++++
 sound/pci/hda/Kconfig           |   4 +-
 sound/pci/hda/hda_codec.c       |  69 +-----
 sound/pci/hda/hda_generic.c     | 162 +++-----------
 sound/pci/hda/hda_generic.h     |  15 +-
 sound/pci/hda/hda_local.h       |  16 +-
 sound/pci/hda/patch_ca0132.c    |   4 +-
 sound/pci/hda/patch_realtek.c   |   2 +-
 sound/pci/hda/patch_sigmatel.c  |   6 +-
 sound/pci/hda/thinkpad_helper.c |   2 +-
 15 files changed, 609 insertions(+), 263 deletions(-)
 create mode 100644 sound/core/control_led.c

-- 
2.29.2
