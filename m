From: Roman Sommer <roman.sommer@fau.de>
Subject: [PATCH 0/3] sound/usb/line6: fix some styling issues
Date: Mon, 18 Jun 2018 12:29:36 +0200
Message-ID: <1529317779-15908-1-git-send-email-roman.sommer@fau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Roman Sommer <roman.sommer@fau.de>, linux-kernel@i4.cs.fau.de, Daniel Graefe <daniel.graefe@fau.de>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, =?UTF-8?q?Hans=20P=2E=20M=C3=B6ller=20Ebner?= <hmoller@uc.cl>, Kees Cook <keescook@chromium.org>, Kate Stewart <kstewart@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, =?UTF-8?q?Fabi=C3=A1n=20Inostroza?= <soulsonceonfire@gmail.com>, Bhumika Goyal <bhumirks@gmail.com>, Philippe Ombredanne <pombredanne@nexb.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

CC: Jaroslav Kysela <perex@perex.cz>
CC: Takashi Iwai <tiwai@suse.com>
CC: Takashi Sakamoto <o-takashi@sakamocchi.jp>
CC: "Hans P. Möller Ebner" <hmoller@uc.cl>
CC: Kees Cook <keescook@chromium.org>
CC: Kate Stewart <kstewart@linuxfoundation.org>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: "Fabián Inostroza" <soulsonceonfire@gmail.com>
CC: Bhumika Goyal <bhumirks@gmail.com>
CC: Philippe Ombredanne <pombredanne@nexb.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: alsa-devel@alsa-project.org
CC: linux-kernel@vger.kernel.org


This patchseries addresses some styling issues in sound/usb/line6 found by
checkpatch.

Roman Sommer (3):
  sound/line6: checkpatch: fix block comment style
  sound/line6: unsigned -> unsigned int
  sound/line6: add newline after declarations

 sound/usb/line6/capture.c  |  20 ++++-----
 sound/usb/line6/driver.c   | 110 ++++++++++++++++++++++-----------------------
 sound/usb/line6/driver.h   |  33 +++++++-------
 sound/usb/line6/midi.c     |  24 +++++-----
 sound/usb/line6/midibuf.c  |   6 +--
 sound/usb/line6/pcm.c      |  26 +++++------
 sound/usb/line6/pcm.h      |  74 +++++++++++++++---------------
 sound/usb/line6/playback.c |  36 ++++++++-------
 sound/usb/line6/pod.c      |  60 ++++++++++++-------------
 sound/usb/line6/podhd.c    |   8 ++--
 sound/usb/line6/toneport.c |  30 ++++++-------
 sound/usb/line6/variax.c   |  40 ++++++++---------
 12 files changed, 235 insertions(+), 232 deletions(-)

-- 
2.7.4
