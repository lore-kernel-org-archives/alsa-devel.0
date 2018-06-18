From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/5] ALSA: firewire-motu: add support for MOTU
	Traveler
Date: Mon, 18 Jun 2018 21:07:50 +0900
Message-ID: <20180618120755.19880-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl0-f66.google.com (mail-pl0-f66.google.com
 [209.85.160.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 334442675E4
 for <alsa-devel@alsa-project.org>; Mon, 18 Jun 2018 14:08:24 +0200 (CEST)
Received: by mail-pl0-f66.google.com with SMTP id 31-v6so8924010plc.4
 for <alsa-devel@alsa-project.org>; Mon, 18 Jun 2018 05:08:24 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

This patchset adds support for MOTU Traveler launched in 2005. Any
transmission of PCM frames/MIDI messages is available via ALSA PCM and
RawMIDI/Sequencer interfaces to handle MOTU specific protocol version 2.

Like ALSA Dice driver, this driver can't enable target device to generate
sound properly at some sampling transmission frequency yet, due to
timestamping issue. However, at sampling transmission frequencies for
major sampling rate such as 44.1/48.0 kHz, it works well, as long as I
tested. This situation might be improved future.

Takashi Sakamoto (5):
  ALSA: firewire-motu: suppless consumption for unused element of array
    in stack
  ALSA: firewire-motu: add a flag for chunks for main 1/2 out
  ALSA: firewire-motu: add a flag for AES/EBU on XLR interface
  ALSA: firewire-motu: cancel chunk alignment for protocol version 2
  ALSA: firewire-motu: add support for Motu Traveler

 sound/firewire/motu/motu-protocol-v2.c | 64 ++++++++++++++++++++++++++--------
 sound/firewire/motu/motu-protocol-v3.c | 19 +++++++---
 sound/firewire/motu/motu.c             | 19 ++++++++++
 sound/firewire/motu/motu.h             |  5 ++-
 4 files changed, 87 insertions(+), 20 deletions(-)

-- 
2.14.1
