From: Daniel Mack <zonque@gmail.com>
Subject: Assorted usb-audio patches
Date: Wed, 18 May 2011 11:28:37 +0200
Message-ID: <1305710925-3857-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (unknown [212.112.241.193])
	by alsa0.perex.cz (Postfix) with ESMTP id 4436E103841
	for <alsa-devel@alsa-project.org>;
	Wed, 18 May 2011 11:29:01 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

Hi,

here are some patches I collected for the usb-audio driver. Most of them have
been discussed on this list already, and all are rather small and shouldn't
cause any problems.

FWIW, they can also be pulled from

  git://github.com/zonque/linux-2.6.git usb-audio


Daniel



Daniel Mack (8):
      MAINTAINERS: Add entry for Native Instruments sound driver
      ALSA: usb-audio: make hwc_debug a noop in case HW_CONST_DEBUG is not set
      ALSA: usb-audio: include format.h in format.c
      ALSA: usb-audio: remove invalid extra mixers for Komplete Audio 6
      ALSA: usb-audio: Add quirk for KORG PANDORA PX5D MIDI interface
      ALSA: usb-audio: add quirks for Roland GR-55
      ALSA: usb-audio: assume valid clock
      ALSA: usb-audio: handle "Fast Track Ultra" with USB_DEVICE_VENDOR_SPEC()

 MAINTAINERS              |    7 +++++++
 sound/usb/clock.c        |   11 ++++++++++-
 sound/usb/debug.h        |    2 +-
 sound/usb/format.c       |    1 +
 sound/usb/mixer_quirks.c |   17 -----------------
 sound/usb/quirks-table.h |   43 ++++++++++++++++++++++++++++++++++++++++---
 sound/usb/quirks.c       |    2 +-
 7 files changed, 60 insertions(+), 23 deletions(-)
