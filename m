From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/3] ALSA: USB-descriptor endianess fixes
Date: Fri, 12 May 2017 12:28:18 +0200
Message-ID: <20170512102821.2630-1-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f196.google.com (mail-wr0-f196.google.com
 [209.85.128.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 72899266E87
 for <alsa-devel@alsa-project.org>; Fri, 12 May 2017 12:28:44 +0200 (CEST)
Received: by mail-wr0-f196.google.com with SMTP id g12so7058376wrg.2
 for <alsa-devel@alsa-project.org>; Fri, 12 May 2017 03:28:44 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, Johan Hovold <johan@kernel.org>
List-Id: alsa-devel@alsa-project.org

These patches add missing endianness conversions when accessing the USB
device-descriptor fields. In the process, clean up the us122l driver
which had product-id conditionals sprinkled throughout.

The final patch drops the Kconfig dependency on x86 since it's a USB
driver that compiles just fine on non-x86. Perhaps this should be a
(X86 || COMPILE_TEST) dependency instead in case there are external
dependencies that warrants this limitation.

Note that these patches have only been compile-tested.

Johan


Johan Hovold (3):
  ALSA: usb-audio: fix Amanero Combo384 quirk on big-endian hosts
  ALSA: us122l: clean up US144 handling
  ALSA: us122l: drop x86 dependency

 sound/usb/Kconfig        |  1 -
 sound/usb/quirks.c       |  2 +-
 sound/usb/usx2y/us122l.c | 36 ++++++++++++++++++------------------
 sound/usb/usx2y/us122l.h |  2 ++
 4 files changed, 21 insertions(+), 20 deletions(-)

-- 
2.13.0
