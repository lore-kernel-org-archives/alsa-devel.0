From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/4] ALSA: usb-audio: More strict validation
	and cleanups
Date: Thu, 22 Aug 2019 09:32:02 +0200
Message-ID: <20190822073207.8696-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CB720F80391
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2019 09:32:10 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 00799AFA9
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2019 07:32:08 +0000 (UTC)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

this patchset introduces a more comprehensive validation code for
USB-audio descriptor units, mainly for mixer stuff, for yet more
hardening against the malformed descriptors.  The rest are rather
cleanups.


Takashi

===

Takashi Iwai (4):
  ALSA: usb-audio: More validations of descriptor units
  ALSA: usb-audio: Simplify parse_audio_unit()
  ALSA: usb-audio: Unify the release of usb_mixer_elem_info objects
  ALSA: usb-audio: Remove superfluous bLength checks

 sound/usb/Makefile   |   3 +-
 sound/usb/clock.c    |  14 +--
 sound/usb/helper.h   |   4 +
 sound/usb/mixer.c    | 237 ++++++++++++------------------------
 sound/usb/power.c    |   2 +
 sound/usb/quirks.c   |   3 +
 sound/usb/stream.c   |  25 ++--
 sound/usb/validate.c | 332 +++++++++++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 439 insertions(+), 181 deletions(-)
 create mode 100644 sound/usb/validate.c

-- 
2.16.4
