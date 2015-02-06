From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH 0/4] More Line 6 cleanup
Date: Fri,  6 Feb 2015 08:51:08 -0600
Message-ID: <1423234272-7348-1-git-send-email-chris@rorvick.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yh0-f52.google.com (mail-yh0-f52.google.com
 [209.85.213.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C1D12605DC
 for <alsa-devel@alsa-project.org>; Fri,  6 Feb 2015 15:51:26 +0100 (CET)
Received: by mail-yh0-f52.google.com with SMTP id f10so6359297yha.11
 for <alsa-devel@alsa-project.org>; Fri, 06 Feb 2015 06:51:25 -0800 (PST)
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, alsa-devel@alsa-project.org, Chris Rorvick <chris@rorvick.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Not much to say about these other than what's in the commit log.

I was looking into what appeared to be a regression that was only
reproducible outside of QEMU, but it turned out to be me pulling in the
test/snd-device changes but testing against vanilla v3.19-rc7 ALSA
modules.  Fixing my process.   :-)

Regards,

Chris

Chris Rorvick (4):
  ALSA: line6: Add toneport_has_source_select()
  ALSA: line6: Pass toneport pointer to toneport_has_led()
  ALSA: line6: Pass driver name to line6_probe()
  ALSA: line6: Remove `usb_' prefix from structs

 sound/usb/line6/capture.c  |  2 +-
 sound/usb/line6/driver.c   | 45 +++++++++++-----------
 sound/usb/line6/driver.h   | 25 ++++++------
 sound/usb/line6/midi.c     | 24 +++++-------
 sound/usb/line6/midi.h     |  6 +--
 sound/usb/line6/pcm.c      |  5 +--
 sound/usb/line6/pcm.h      |  4 +-
 sound/usb/line6/playback.c |  2 +-
 sound/usb/line6/pod.c      | 52 ++++++++++++-------------
 sound/usb/line6/podhd.c    |  7 ++--
 sound/usb/line6/toneport.c | 94 ++++++++++++++++++++++++----------------------
 sound/usb/line6/variax.c   | 41 ++++++++++----------
 12 files changed, 151 insertions(+), 156 deletions(-)

-- 
2.1.0
