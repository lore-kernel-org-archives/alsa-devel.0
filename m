From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/6] usb-audio: quirks for Dell WD15 dock and
	some extensions
Date: Wed,  2 May 2018 16:11:10 +0200
Message-ID: <20180502141116.31966-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4CB4B266C1C
 for <alsa-devel@alsa-project.org>; Wed,  2 May 2018 16:11:20 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 75A61AEEF
 for <alsa-devel@alsa-project.org>; Wed,  2 May 2018 14:11:19 +0000 (UTC)
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

here is a patch set for adding quirks and some new extensions for Dell
WD15 dock.  The first patch is the resend of the previous post, and
the rest are new.

Basically it adds a new "Keep Interface" control for the card to skip
resetting the USB interface per stream manipulation.  It helps for
reducing the long pause before each start of stream on Dell WD15
dock.  OTOH, this was confirmed to be harmless on some dock early
firmware version, so we can't set it statically in the driver.
So, instead, the feature is exposed as a control element so that user
can flip dynamically.  This feature may be useful for other USB audio
devices as well.

Another extension is to allow the quirk entry to override the card
longname field.  This is needed to give a proper UCM profile.
WD15 dock provides two streams, one for the headphone and another for
the line out.  It's a good example for using a UCM profile.


Takashi

===

Takashi Iwai (6):
  ALSA: usb-audio: Initialize Dell Dock playback volumes
  ALSA: usb-audio: Avoid superfluous usb_set_interface() calls
  ALSA: usb-audio: Add keep_iface flag
  ALSA: usb-audio: Add "Keep Interface" control
  ALSA: usb-audio: Allow to override the longname string
  ALSA: usb-audio: Give proper vendor/product name for Dell WD15 Dock

 sound/usb/card.c         | 146 ++++++++++++++++++++++++++++-------------------
 sound/usb/mixer.c        |  47 +++++++++++++++
 sound/usb/mixer_quirks.c |  34 +++++++++++
 sound/usb/mixer_quirks.h |   4 ++
 sound/usb/pcm.c          |  28 ++++-----
 sound/usb/quirks-table.h |  10 ++++
 sound/usb/usbaudio.h     |   4 ++
 7 files changed, 200 insertions(+), 73 deletions(-)

-- 
2.16.3
