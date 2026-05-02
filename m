Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B93CD342C
	for <alsa-devel@archiver.kernel.org>; Mon,  4 May 2026 11:35:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3B516601C5;
	Mon,  4 May 2026 13:35:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3B516601C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1777894552;
	bh=AJSiv4rlM1Y72yTCDwIkevBY2jyeOE4AJNNWaG9HSkA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=jyNdju1X79MjstyADEII9KaNqldRl8UkdnyyHSoTLeJVahC5JxZtT/x8XnSTsTFK3
	 qgjq4AKEGxEkRV4di560SzM5O4FdbrWyckhN5Q73cGRxYufqDwKay1+Eg60tlhU3MI
	 Mv2vo+Yl5vIqrFMGA6M9yoa7Cyjyr0ZKNKCgK3UI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4F660F80636; Mon,  4 May 2026 13:34:56 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 16A97F8062D;
	Mon,  4 May 2026 13:34:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 29825F804F2; Sun,  3 May 2026 01:31:07 +0200 (CEST)
Received: from mx.brightberry.eu (mx.brightberry.eu [185.229.55.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A02C3F8021D
	for <alsa-devel@alsa-project.org>; Sun,  3 May 2026 01:31:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A02C3F8021D
Received: from mx.brightberry.eu (localhost [127.0.0.1])
	by mx.brightberry.eu (Proxmox) with ESMTP id 601232A01;
	Sun, 03 May 2026 01:31:03 +0200 (CEST)
Received: from d3cold-bug-report.eml (YST00841.fritz.box [192.168.178.64])
	by mx.brightberry.eu (Proxmox) with ESMTP id 40E62100F;
	Sun, 03 May 2026 01:31:03 +0200 (CEST)
From: =?UTF-8?q?R=C3=A1mon_van_Raaij?= <ramon@vanraaij.eu>
To: linux-sound@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>,
 Shenghao Ding <shenghao-ding@ti.com>
Subject: [BUG] snd_hda_scodec_tas2781_i2c: parent I2C controller enters D3cold
 during idle, erasing amp register state
Date: Sun, 03 May 2026 01:30:50 +0200
Message-Id: <20260502230243.bug2-ramon@vanraaij.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MailFrom: ramon@vanraaij.eu
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: IKWE275BFSZRGPYDGLYW37YXITRXLXY6
X-Message-ID-Hash: IKWE275BFSZRGPYDGLYW37YXITRXLXY6
X-Mailman-Approved-At: Mon, 04 May 2026 11:34:51 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IKWE275BFSZRGPYDGLYW37YXITRXLXY6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Machine:  Lenovo Yoga Pro 9 16IMH9 (board name 83DN)
Kernel:   7.0.3-zen1-1-zen (linux-zen)
Amps:     2x TI TAS2781, ACPI HID TIAS2781, I2C bus i2c-4
          (I2C controller: PCI 0000:00:15.2, Intel DesignWare / Meteor Lake)
Related:  <20260501175633.bug1-ramon@vanraaij.eu>
          (DSP firmware fails at cold boot - separate issue, same hardware)

PROBLEM
-------
After approximately 5 minutes of audio inactivity the built-in speakers
drop to ~10-15% of normal volume. No dmesg message is emitted and no
driver error is reported. Audio continues to function at the low volume;
the issue is not a complete failure. The drop is not tied to display
power-off; it occurs during I2C bus inactivity regardless of display state.

ROOT CAUSE
----------
The TAS2781 amplifiers sit on a Synopsys DesignWare I2C bus whose parent
PCI device (0000:00:15.2) defaults to power/control=auto. During deep
idle the kernel runtime-suspends this controller. When the controller
enters D3cold (which ACPI can gate the power rail for), the entire I2C
bus loses power and all TAS2781 register state is erased.

This is distinct from the TAS2781 I2C device's own runtime-PM: pinning
the I2C device to power/control=on does not help because the power loss
comes from the parent PCI controller, not from the I2C device itself.

Confirmed by checking power state before and after idle:

  # Before idle (volume normal):
  $ cat /sys/bus/pci/devices/0000:00:15.2/power/runtime_status
  active
  $ cat /sys/bus/pci/devices/0000:00:15.2/power/control
  auto

  # After ~5 min audio inactivity (volume dropped to ~10-15%):
  $ cat /sys/bus/pci/devices/0000:00:15.2/power/runtime_status
  suspended

The timing (~5 min) corresponds to the system entering a deep idle
state during I2C bus inactivity, which allows the PCI controller to
runtime-suspend.

WORKAROUND
----------
Pinning the PCI controller to always-on prevents the volume drop:

  echo on > /sys/bus/pci/devices/0000:00:15.2/power/control

Persistent via udev (ACTION=="add" alone is insufficient: i2c_designware
resets power/control back to auto after driver binding, so ACTION=="bind"
is also required):

  ACTION=="add|bind", SUBSYSTEM=="pci", ENV{PCI_SLOT_NAME}=="0000:00:15.2", \
      ATTR{power/control}="on"

This is a blunt workaround that prevents any runtime PM on the entire I2C
controller, which affects all devices on that bus.

SUGGESTED FIX
-------------
snd_hda_scodec_tas2781_i2c should hold a PM runtime reference on the
parent PCI device of its I2C controller during probe, preventing D3cold
for as long as the driver is bound. Something along the lines of:

  /* In probe: */
  pci_dev = to_pci_dev(client->adapter->dev.parent->parent);
  pm_runtime_get_sync(&pci_dev->dev);

  /* In remove: */
  pm_runtime_put(&pci_dev->dev);

Alternatively a PCI quirk could set ACPI_COMPANION power flags to prevent
D3cold for PCI 8086:7e7a (the Meteor Lake DesignWare controller) on
platforms where TAS2781 amps are present.

Signed-off-by: Ramon van Raaij <ramon@vanraaij.eu>


