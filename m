From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/4] Harden USB-audio parsers
Date: Tue, 21 Nov 2017 17:33:50 +0100
Message-ID: <20171121163354.2665-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E4A626768E
 for <alsa-devel@alsa-project.org>; Tue, 21 Nov 2017 17:33:58 +0100 (CET)
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
Cc: Andrey Konovalov <andreyknvl@google.com>, Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>
List-Id: alsa-devel@alsa-project.org

Hi,

as recently spotted by syzkaller, the parser codes in USB audio driver
don't check the length of the descriptor unit before actually
accessing the extra field, which may lead to out-of-bound access
error.  This patchset tries to address these by adding proper sanity
checks.


Takashi

===

Takashi Iwai (4):
  ALSA: usb-audio: Add sanity checks to FE parser
  ALSA: usb-audio: Fix potential out-of-bound access at parsing SU
  ALSA: usb-audio: Fix potential zero-division at parsing FU
  ALSA: usb-audio: Add sanity checks in v2 clock parsers

 sound/usb/clock.c |  9 ++++++---
 sound/usb/mixer.c | 19 ++++++++++++++++---
 2 files changed, 22 insertions(+), 6 deletions(-)

-- 
2.15.0
