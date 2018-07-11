From: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
Subject: [PATCH 0/5] UAC3: Add Selectors and Processing Units.
Date: Wed, 11 Jul 2018 13:37:50 +0100
Message-ID: <20180711123755.27182-1-jorge.sanjuan@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from imap1.codethink.co.uk (imap1.codethink.co.uk [176.9.8.82])
 by alsa0.perex.cz (Postfix) with ESMTP id 2432E2676FE
 for <alsa-devel@alsa-project.org>; Wed, 11 Jul 2018 14:38:02 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patchset is motivated by the addition of Multi Function
Processing Units (MFPU) to an UAC3 topology where there could be
signal processing algorithims applied to the audio signal.

The MFPUs themself don't provide any useful control, they offer a 
description of what algorithims it supports and it is for Selector Units
to take the bypass control of the dry (unprocessed) signal and the modified
one. Moreover, Up/Down mixers may be needed in this topologies to control
which outputs of the logical output cluster from the MFPU are to be passed 
as the final modified audio signal.

These patches add support for Selector Units and Processing units for UAC3
and adds a couple fixes that I found while implemeting them:

 1) Defualt naming of the virtual terminals was not accurate due to codes
    overlap between the three UAC standards.
 2) UAC2 parsing of processing units was using UAC1 controls bitmap.

Based on: next-20180711

Jorge Sanjuan (5):
  ALSA: usb-audio: Add support for Selector Units in UAC3
  ALSA: usb-audio: Processing Unit controls parsing in UAC2
  ALSA: usb-audio: Add support for Processing Units in UAC3
  ALSA: usb-audio: Unify virtual type units type to UAC3 values
  ALSA: usb-audio: Tidy up logic for Processing Unit min/max values

 include/linux/usb/audio-v3.h   |  15 +++
 include/uapi/linux/usb/audio.h |  49 ++++++++--
 sound/usb/mixer.c              | 212 +++++++++++++++++++++++++++++++++--------
 3 files changed, 225 insertions(+), 51 deletions(-)

-- 
2.11.0
