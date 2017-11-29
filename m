From: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
Subject: [PATCH 0/6] ALSA: usb: UAC3. Add support for Basic
	Audio Device (BADD)
Date: Wed, 29 Nov 2017 10:55:26 +0000
Message-ID: <20171129105532.15420-1-jorge.sanjuan@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from imap1.codethink.co.uk (imap1.codethink.co.uk [176.9.8.82])
 by alsa0.perex.cz (Postfix) with ESMTP id 92E9F266E30
 for <alsa-devel@alsa-project.org>; Wed, 29 Nov 2017 11:55:35 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@lists.codethink.co.uk, Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
List-Id: alsa-devel@alsa-project.org

This adds functionality for the Basic Audio Device (BADD) subset that is
defined in the USB Audio Class 3 (UAC3). The new class requires the device to 
have 3 usb configurations as follows:

    1: Legacy Mode: UAC1 or UAC2.
    2: BADD device with a prefined topology. (Minimum).
    3: UAC3 device for more detailed description or more complex
       devices that can't be covered by the BADD profile.

This patch series also includes some minor fixes to the usb card driver.

Also, this has been implemented on top of the the patch which adds UAC3 support
to the usb sound card driver: 

	commit ddd452d7b04b86fb5f9285a19ac54deca9264ac1
	Author: Ruslan Bilovol <ruslan.bilovol@gmail.com>
	Date:   Tue Nov 7 04:01:20 2017 +0200

Jorge Sanjuan (6):
  ALSA: usb: ADC3: Add initial BADD spec support
  ALSA: usb: ADC3. BADD specification: fixed 48KHz sample rate.
  ALSA: usb: ADC3. Do not set sample rate for BADD configuration.
  usb: audio: Fix variable length field to be variable.
  ALSA: usb: Use Class Specific EP for UAC3 devices.
  ALSA: usb: Only get control header for UAC1 class.

 include/linux/usb/audio-v3.h |   2 +-
 sound/usb/Makefile           |   3 +-
 sound/usb/badd.c             | 495 +++++++++++++++++++++++++++++++++++++++++++
 sound/usb/badd.h             |  30 +++
 sound/usb/card.c             |  22 +-
 sound/usb/clock.c            |   6 +-
 sound/usb/format.c           |   7 +-
 sound/usb/stream.c           | 175 +++++++++------
 sound/usb/usbaudio.h         |   1 +
 9 files changed, 670 insertions(+), 71 deletions(-)
 create mode 100644 sound/usb/badd.c
 create mode 100644 sound/usb/badd.h

-- 
2.11.0
