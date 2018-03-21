From: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Subject: [PATCH v3] USB Audio Device Class 3.0 support
Date: Wed, 21 Mar 2018 02:03:58 +0200
Message-ID: <1521590639-31383-1-git-send-email-ruslan.bilovol@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f48.google.com (mail-lf0-f48.google.com
 [209.85.215.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 0BF7F267219
 for <alsa-devel@alsa-project.org>; Wed, 21 Mar 2018 01:04:04 +0100 (CET)
Received: by mail-lf0-f48.google.com with SMTP id c78-v6so572665lfh.1
 for <alsa-devel@alsa-project.org>; Tue, 20 Mar 2018 17:04:04 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.com>
Cc: Jorge <jorge.sanjuan@codethink.co.uk>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

This patch adds initial USB Audio Device Class 3.0 [1]
support to the ALSA that we discussed at ELCE.

The patch was tested with UAC3 gadget [2] that I posted
to USB mailing list before. It is good for working with
BADD device which implements such topologies like
BAIF (Basic Audio Input Functions), BAOF (Basic Audio
Output Functions) or compbination of both.

UAC3 spec has changed descriptors laout and many other
codes comparing to UAC2 spec, thus making reuse of existing
sources impossible or quite complex.

There are still many areas of improvement, as this patch
doesn't have UAC3 Mixer Unit support nor some new features
like Power Management

I tested this with BeagleBone Black as UAC3 gadget device.

[1] http://www.usb.org/developers/docs/devclass_docs/USB_Audio_v3.0.zip
[2] http://www.spinics.net/lists/linux-usb/msg162482.html

v3 changes:
 - dropped audioformat quirks patch (already accepted)
 - addressed coding style requested changes

v2 changes:
 - moved audioformat quirks to quirks.c
 - addressed many comments from Pierre-Louis Bossart
 - reorganized audio-v3.h
 - added more UAC3 channel relationship definitions


Ruslan Bilovol (1):
  ALSA: usb: initial USB Audio Device Class 3.0 support

 include/linux/usb/audio-v2.h   |   4 +-
 include/linux/usb/audio-v3.h   | 395 +++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/usb/audio.h |   1 +
 sound/usb/card.c               |   7 +-
 sound/usb/card.h               |   2 +-
 sound/usb/clock.c              | 228 +++++++++++++++++++++---
 sound/usb/clock.h              |   4 +-
 sound/usb/format.c             |  91 ++++++++--
 sound/usb/format.h             |   6 +-
 sound/usb/mixer.c              | 337 +++++++++++++++++++++++------------
 sound/usb/stream.c             | 365 +++++++++++++++++++++++++++++++++----
 11 files changed, 1246 insertions(+), 194 deletions(-)
 create mode 100644 include/linux/usb/audio-v3.h

-- 
1.9.1
