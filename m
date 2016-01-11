From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH RFC 0/3] Add USB-audio quirk alias option
Date: Mon, 11 Jan 2016 17:59:13 +0100
Message-ID: <1452531556-32622-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id ECA01265065
 for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2016 17:59:22 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 871CCAD66
 for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2016 16:59:21 +0000 (UTC)
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

this is an experimental patchset to add a new option, quirk_alias, to
snd-usb-audio driver.  It allows to use the existing quirk for the
given vendor:product id pair matching with the new device.  Passing
like:
  quirk_alias=1234abcd:5678beef
will make the driver applying the quirk for 5678:beef against to the
new device 1234:abcd.

Obviously, this is for helping to find a workaround for a new device
that may need the same / similar quirk for the previous models.  Then
you can apply the quirk without recompiling the kernel driver with a
manual patch.


Takashi

===

Takashi Iwai (3):
  ALSA: usb-audio: Refer to chip->usb_id for quirks and MIDI creation
  ALSA: usb-audio: Add quirk_alias option
  ALSA: doc: Update option descriptions for snd-usb-audio

 Documentation/sound/alsa/ALSA-Configuration.txt |  9 ++++
 sound/usb/card.c                                | 56 +++++++++++++++++++++++--
 sound/usb/midi.c                                | 15 ++++---
 sound/usb/midi.h                                | 14 ++++++-
 sound/usb/quirks.c                              | 34 ++++++++-------
 sound/usb/quirks.h                              |  3 +-
 6 files changed, 105 insertions(+), 26 deletions(-)

-- 
2.7.0
