From: Antonio Ospite <ospite@studenti.unina.it>
Subject: [PATCH 0/6] Misc ALSA changes, documentation, style
Date: Mon, 28 Jan 2013 23:42:26 +0100
Message-ID: <1359412952-1680-1-git-send-email-ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp205.alice.it (smtp205.alice.it [82.57.200.101])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E8FB26036E
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2013 23:43:32 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>, Michael Trimarchi <michael@amarulasolutions.com>, Antonio Ospite <ao2@amarulasolutions.com>
List-Id: alsa-devel@alsa-project.org

From: Antonio Ospite <ao2@amarulasolutions.com>

Hi,

here are some fixes for things I noticed while studying ALSA.

I'd like some feedback especially on patch 1.
Patches 2 and 3 are documentation fixes.
Patches 4, 5 and 6, are basically style fixes.

Feel free to discard patch 6 if you find it too invasive, it's just
cosmetics but some maintainers don't like big style changes even if they
are in the "right" direction. I don't know alsa devs' position about
that.

I am sending the whole series to alsa-devel and CCing topic specific
mailing lists or developers on a per-patch basis.

Thanks,
   Antonio

Antonio Ospite (6):
  Force a cast to silence a warning from "sparse"
  Documentation/DocBook/writing-an-alsa-driver.tmpl: fix some thinkos
  Documentation/DocBook/writing-an-alsa-driver.tmpl: fix some typos
  sound/usb/caiaq/device.c: fix use of MODULE_SUPPORTED_DEVICES()
  sound/usb/card.c: cosmetics, remove a leading space
  sound/core/pcm_native.c: cosmetics, fix use of spaces

 Documentation/DocBook/writing-an-alsa-driver.tmpl |   11 +-
 include/sound/memalloc.h                          |    2 +-
 sound/core/pcm_native.c                           |  120 ++++++++++-----------
 sound/usb/caiaq/device.c                          |    8 +-
 sound/usb/card.c                                  |    2 +-
 5 files changed, 71 insertions(+), 72 deletions(-)

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
