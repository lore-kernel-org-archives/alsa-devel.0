From: Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 0/3] ALSA: USB-descriptor endianness fixes
Date: Fri, 12 May 2017 14:34:36 +0200
Message-ID: <20170512123439.14994-1-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f66.google.com (mail-lf0-f66.google.com
 [209.85.215.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 650D4266A38
 for <alsa-devel@alsa-project.org>; Fri, 12 May 2017 14:34:57 +0200 (CEST)
Received: by mail-lf0-f66.google.com with SMTP id 99so57316lfu.2
 for <alsa-devel@alsa-project.org>; Fri, 12 May 2017 05:34:57 -0700 (PDT)
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

The final patch enables compile testing for us122l which currently
depends on x86 but compiles just fine for arm.

Note that these patches have only been compile tested.

Johan


v2
 - enable compile testing rather than drop the us122l x86-dependency


Johan Hovold (3):
  ALSA: usb-audio: fix Amanero Combo384 quirk on big-endian hosts
  ALSA: us122l: clean up US144 handling
  ALSA: us122l: enable compile testing

 sound/usb/Kconfig        |  2 +-
 sound/usb/quirks.c       |  2 +-
 sound/usb/usx2y/us122l.c | 36 ++++++++++++++++++------------------
 sound/usb/usx2y/us122l.h |  2 ++
 4 files changed, 22 insertions(+), 20 deletions(-)

-- 
2.13.0
