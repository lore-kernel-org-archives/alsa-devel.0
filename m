From: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH v2 0/9] sound: Add sanity checks for invalid EPs
Date: Wed, 11 Oct 2017 12:36:37 +0200
Message-ID: <20171011103646.11879-1-tiwai@suse.de>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrey Konovalov <andreyknvl-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Hi,

this is a revised patch set to cover the codes that may submit URBs
containing invalid EPs without validation, which result in the kernel
warning from the USB core.  The first patch adds a new helper for
simplifying the EP check, and the rest applies it at needed places.

The original issues were spotted by syzkaller, and I put a few others
for covering more similar cases.

The only updated code in v2 is about the first patch to add
usb_urb_ep_type_check() helper (in addition to tested-by tag from
Andrey).  Typos were fixed and it's called also from usb_submit_urb()
as Greg suggested, too.

USB devs: does this look OK now?

If yes, and if I get acks, I can take the patches to sound tree.  Or I
don't mind if you take all to usb tree, too.  Or maybe better, I'll
prepare an immutable branch based on 4.4.14-rc (rc4 for now) in case
you want to pull into both trees.  Let me know your wish.


thanks,

Takashi

===

Takashi Iwai (9):
  usb: core: Add a helper function to check the validity of EP type in
    URB
  ALSA: bcd2000: Add a sanity check for invalid EPs
  ALSA: caiaq: Add a sanity check for invalid EPs
  ALSA: line6: Add a sanity check for invalid EPs
  ALSA: usb-audio: Add sanity checks for invalid EPs
  ALSA: usx2y: Add sanity checks for invalid EPs
  ALSA: hiface: Add sanity checks for invalid EPs
  ALSA: caiaq: Add yet more sanity checks for invalid EPs
  ALSA: line6: Add yet more sanity checks for invalid EPs

 drivers/usb/core/urb.c          | 30 ++++++++++++++++++++++++++----
 include/linux/usb.h             |  2 ++
 sound/usb/bcd2000/bcd2000.c     |  7 +++++++
 sound/usb/caiaq/device.c        |  7 +++++++
 sound/usb/caiaq/input.c         |  9 +++++++++
 sound/usb/hiface/pcm.c          |  9 +++++++--
 sound/usb/line6/driver.c        | 30 ++++++++++++++++++++++--------
 sound/usb/line6/midi.c          | 17 +++++++++++------
 sound/usb/midi.c                | 38 ++++++++++++++++++++++++++++++--------
 sound/usb/usx2y/usbusx2y.c      |  8 ++++++++
 sound/usb/usx2y/usbusx2yaudio.c |  3 +++
 11 files changed, 132 insertions(+), 28 deletions(-)

-- 
2.14.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
