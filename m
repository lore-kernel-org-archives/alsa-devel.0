From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v2 0/3] ALSA: usb-audio: Minor refactoring and
	UAC3 fix
Date: Wed,  4 Apr 2018 07:36:18 +0200
Message-ID: <20180404053621.32539-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id DF7EF267641
 for <alsa-devel@alsa-project.org>; Wed,  4 Apr 2018 07:36:23 +0200 (CEST)
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
Cc: Andrew Chant <achant@google.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi,

this is a v2 patchset (now with a shiny cover letter!) for refactoring
and hardening UAC2 and UAC3 clock parsers.

BTW, it'll be great if anyone can double-check that this rewrite
doesn't break things, especially with a UAC3 device.


thanks,

Takashi

===

v1->v2:	Rename the helper function to be more specific
	Make validators to check sizes more strictly

Takashi Iwai (3):
  ALSA: usb-audio: Refactor clock finder helpers
  ALSA: usb-audio: More strict sanity checks for clock parsers
  ALSA: usb-audio: Add sanity checks in UAC3 clock parsers

 sound/usb/clock.c | 128 +++++++++++++++++++++++-------------------------------
 1 file changed, 54 insertions(+), 74 deletions(-)

-- 
2.16.2
