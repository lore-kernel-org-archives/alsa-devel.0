From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCH v2 0/9] ALSA: usb-audio: Refactor set_format()
Date: Sat,  3 Aug 2013 10:50:14 +0200
Message-ID: <1375519823-25718-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f54.google.com (mail-bk0-f54.google.com
 [209.85.214.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 82D1A2617B3
 for <alsa-devel@alsa-project.org>; Sat,  3 Aug 2013 10:50:30 +0200 (CEST)
Received: by mail-bk0-f54.google.com with SMTP id it19so458632bkc.13
 for <alsa-devel@alsa-project.org>; Sat, 03 Aug 2013 01:50:30 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Eldad Zack <eldad@fogrefinery.com>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

This is a low-priority series (applies against current for-next).
This series refactors set_format() and moves the sync endpoint
initilization code into separate function. The quirks for
implicit feedback are moved to a separate function as well.

The intended result is code that is easier to read without
function changes.

Changes from v2:
* Cleaned up the patchset, indentations and whitespace fixes.
* Patch #2: removed early returns when subs->sync_endpoint is already set.
  This change now follows original semantics.
* Patch #9: I first corrected it thanks to Clemens Ladisch's feedback, but
  then I wasn't sure if it improves anything, so I dropped it entirely.
* Dropped patch #10. Instead, added patch (now #9) to WARN_ON and return
  NULL in snd_usb_add_endpoint. Otherwise, the check should be done at each
  call site, and it "shouldn't happen" anyway.

Cheers,
Eldad

v1:
  http://mailman.alsa-project.org/pipermail/alsa-devel/2013-July/064268.html

Eldad Zack (9):
  ALSA: usb-audio: remove disabled debug code in set_format
  ALSA: usb-audio: remove assignment from if condition
  ALSA: usb-audio: separate sync endpoint setting from set_format
  ALSA: usb-audio: move implicit fb quirks to separate function
  ALSA: usb-audio: reverse condition logic in set_sync_endpoint
  ALSA: usb-audio: do not initialize and check implicit_fb
  ALSA: usb-audio: remove is_playback from implicit feedback quirks
  ALSA: usb-audio: remove implicit_fb from quirk
  ALSA: usb-audio: WARN_ON when alts is passed as NULL

 sound/usb/endpoint.c |   3 +
 sound/usb/pcm.c      | 243 +++++++++++++++++++++++++++++----------------------
 2 files changed, 141 insertions(+), 105 deletions(-)

-- 
1.8.1.5
