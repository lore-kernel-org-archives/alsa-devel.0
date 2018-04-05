From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v3 0/3] ALSA: usb-audio: Minor refactoring and
	UAC3 fix
Date: Thu,  5 Apr 2018 14:11:10 +0200
Message-ID: <20180405121113.551-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A6021267674
 for <alsa-devel@alsa-project.org>; Thu,  5 Apr 2018 14:11:15 +0200 (CEST)
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

this is a v3 patchset, addressing the silly mistakes in validator
functions in the previous patchset.


Takashi

===

v1->v2:	Rename the helper function to be more specific
	Make validators to check sizes more strictly
v2->v3: Fix clock selector validator v2 and v3 as suggested by Ruslan

Takashi Iwai (3):
  ALSA: usb-audio: Refactor clock finder helpers
  ALSA: usb-audio: More strict sanity checks for clock parsers
  ALSA: usb-audio: Add sanity checks in UAC3 clock parsers

 sound/usb/clock.c | 128 +++++++++++++++++++++++-------------------------------
 1 file changed, 54 insertions(+), 74 deletions(-)

-- 
2.16.2
