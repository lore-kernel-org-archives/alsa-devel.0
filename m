From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCH 0/3] M-Audio C400 corrections
Date: Sun, 13 Jan 2013 23:02:01 +0100
Message-ID: <1358114524-5152-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id C285D265113
 for <alsa-devel@alsa-project.org>; Sun, 13 Jan 2013 23:02:12 +0100 (CET)
Received: by mail-bk0-f51.google.com with SMTP id ik5so1675486bkc.10
 for <alsa-devel@alsa-project.org>; Sun, 13 Jan 2013 14:02:12 -0800 (PST)
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
Cc: alsa-devel@alsa-project.org, Eldad Zack <eldad@fogrefinery.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

The following are specific fixes for the M-Audio FT C400.

* Use the clock selector instead of the internal clock
  and add names for the clocks instead of Unit 129 and
  Unit 130.

* Fix an issue where the latency would change every time
  the stream is started. Uses skip_packets.

I think they could go in current mainline, since it is
only for this device, but I also checked that they apply
cleanly against for-next.

Cheers,
Eldad


Eldad Zack (3):
  ALSA: usb-audio: correct M-Audio C400 clock source quirk
  ALSA: usb-audio: M-Audio FT C400 skip packet quirk
  ALSA: usb-audio: selector map for M-Audio FT C400

 sound/usb/mixer_maps.c   | 13 +++++++++++++
 sound/usb/quirks-table.h |  4 ++--
 sound/usb/quirks.c       | 11 +++++++++++
 3 files changed, 26 insertions(+), 2 deletions(-)

-- 
1.7.12.4
