From: Andrej Krutak <dev@andree.sk>
Subject: [PATCH v2 0/9] Line6 POD X3/X3Live suport
Date: Fri, 19 Aug 2016 00:20:30 +0200
Message-ID: <1471558839-14120-1-git-send-email-dev@andree.sk>
References: <1470942147-19848-1-git-send-email-dev@andree.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 4CA1B2661B5
 for <alsa-devel@alsa-project.org>; Fri, 19 Aug 2016 00:21:27 +0200 (CEST)
Received: by mail-wm0-f67.google.com with SMTP id i138so1270295wmf.3
 for <alsa-devel@alsa-project.org>; Thu, 18 Aug 2016 15:21:27 -0700 (PDT)
In-Reply-To: <1470942147-19848-1-git-send-email-dev@andree.sk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.com, perex@perex.cz, stefanha@gmail.com, grabner@icg.tugraz.at, alsa-devel@alsa-project.org
Cc: Andrej Krutak <dev@andree.sk>
List-Id: alsa-devel@alsa-project.org

Hi,


I reworked the patches acc. to Takashi's feedback, I think I was able
to fix all the "objections". Two of the previous patches were sent in a
separate batch.

About first patch below - I just added some more commit notes there. I tried
to split it, but it's kind of interconnected and in the end, they are mostly
sed-like operations.. If it's a no-go, I can do it, but I'd prefer not to :-)

Some commits were merged to "Add hwdep IF" commit, as suggested. Also,
I dropped manual implementation of the FIFO buffer in favor of KFIFO.
In addition, mutex is used for read() - as required by the kfifo lib. The
code now looks a lot less scary, I'd say...


Andrej Krutak (9):
  ALSA: line6: Make driver configuration more generic.
  ALSA: line6: Add LINE6_CAP_IN_NEEDS_OUT, a void playback stream during
    capture
  ALSA: line6: Distinguish device init (ctrl EP) and MIDI data transfer
    (int EP)
  ALSA: line6: Add support for POD X3
  ALSA: line6: Add support for POD X3 Live (only USB ID differs from POD
    X3)
  ALSA: line6: Allow bulk endpoints instead of interrupt endpoints
  ALSA: line6: Allow processing of raw incoming messages
  ALSA: line6: Cleanup initialization
  ALSA: line6: Add hwdep interface to access the POD control messages

 include/uapi/sound/asound.h |   3 +-
 sound/usb/line6/Kconfig     |   4 +-
 sound/usb/line6/capture.c   |  50 +++++---
 sound/usb/line6/driver.c    | 269 +++++++++++++++++++++++++++++++++------
 sound/usb/line6/driver.h    |  58 +++++++--
 sound/usb/line6/midi.c      |   2 +-
 sound/usb/line6/pcm.c       |  84 +++++++++----
 sound/usb/line6/pcm.h       |  19 +--
 sound/usb/line6/playback.c  |  37 ++++--
 sound/usb/line6/pod.c       |  12 +-
 sound/usb/line6/podhd.c     | 300 ++++++++++++++++++++++++++++++++++++++++----
 sound/usb/line6/toneport.c  |   6 +-
 sound/usb/line6/variax.c    |   6 +-
 13 files changed, 704 insertions(+), 146 deletions(-)

-- 
1.9.1
