From: Andrew Chant <achant@google.com>
Subject: [PATCH 0/2] ALSA: usb-audio: UAC2 jack detection
	patchset
Date: Thu, 22 Mar 2018 14:39:54 -0700
Message-ID: <20180322213956.217933-1-achant@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl0-f68.google.com (mail-pl0-f68.google.com
 [209.85.160.68])
 by alsa0.perex.cz (Postfix) with ESMTP id CEE63267396
 for <alsa-devel@alsa-project.org>; Thu, 22 Mar 2018 22:40:33 +0100 (CET)
Received: by mail-pl0-f68.google.com with SMTP id 9-v6so6160215ple.11
 for <alsa-devel@alsa-project.org>; Thu, 22 Mar 2018 14:40:33 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Andrew Chant <achant@google.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>
List-Id: alsa-devel@alsa-project.org

These patches implement UAC2 jack detection.

This allows USB-to-3.5mm adapters and similar USB devices
to report jack state via alsa mixers, using the reporting
provided by the UAC2 connector control.

The first patch fixes up the function used to query
UAC controls.  The long lines in the table are unfortunate
but keep the table readable.  The long lines elsewhere
in the patch were in line with existing long lines due
to current code structure.


Andrew Chant (2):
  ALSA: usb-audio: fix uac control query argument
  ALSA: usb-audio: UAC2 jack detection

 include/linux/usb/audio-v2.h |   4 +-
 sound/usb/clock.c            |   5 +-
 sound/usb/mixer.c            | 168 +++++++++++++++++++++++++++++------
 3 files changed, 146 insertions(+), 31 deletions(-)

-- 
2.17.0.rc0.231.g781580f067-goog
