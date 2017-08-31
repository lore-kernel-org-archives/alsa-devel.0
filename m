From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/6] Put missing KERN_* prefix
Date: Thu, 31 Aug 2017 11:33:28 +0200
Message-ID: <20170831093334.9050-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B8F72672B3
 for <alsa-devel@alsa-project.org>; Thu, 31 Aug 2017 11:33:37 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 27650AC54
 for <alsa-devel@alsa-project.org>; Thu, 31 Aug 2017 09:33:37 +0000 (UTC)
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
List-Id: alsa-devel@alsa-project.org

Hi,

it's a trivial fix patch set for missing KERN_* prefix to some debug
codes found in various drivers.


Takashi

===

Takashi Iwai (6):
  ALSA: opl3: Put missing KERN_CONT prefix
  ALSA: vx: Put missing KERN_CONT prefix
  ALSA: asihpi: Put missing KERN_CONT prefix
  ALSA: usb-audio: Put missing KERN_CONT prefix
  ALSA: usx2y: Put missing KERN_CONT prefix
  ALSA: sh: Put missing KERN_* prefix

 sound/drivers/opl3/opl3_midi.c | 4 ++--
 sound/drivers/vx/vx_core.c     | 4 ++--
 sound/pci/asihpi/hpidebug.c    | 4 ++--
 sound/sh/sh_dac_audio.c        | 2 +-
 sound/usb/midi.c               | 4 ++--
 sound/usb/usx2y/usb_stream.c   | 4 ++--
 6 files changed, 11 insertions(+), 11 deletions(-)

-- 
2.14.1
