From: Dylan Reid <dgreid@chromium.org>
Subject: [PATCH 0/3] Allow suspend/resume with USB audio.
Date: Mon, 17 Sep 2012 13:11:36 -0700
Message-ID: <1347912699-9969-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lpp01m010-f73.google.com (mail-lpp01m010-f73.google.com
 [209.85.215.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C9AB2616D2
 for <alsa-devel@alsa-project.org>; Mon, 17 Sep 2012 22:11:58 +0200 (CEST)
Received: by lahi5 with SMTP id i5so391123lah.2
 for <alsa-devel@alsa-project.org>; Mon, 17 Sep 2012 13:11:57 -0700 (PDT)
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
Cc: tiwai@suse.de, Dylan Reid <dgreid@chromium.org>, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

Problem being addressed:
shell one$ aplay -Dhw:<usbcard> file.wav
shell two$ echo mem > /sys/power/state
After resume, aplay attempts resume, then restart, then after a timeout
gets a write error and no audio will be played until it is restarted.

During suspend/resume, if the USB port remains powered the audio device
will still be present upon resume.  The interface and endpoint have to
be reconfigured however.  These patches move the configuration from
hw_params to prepare causing re-configuration during resume.

Is this the right way to fix this?  Or is there an easier way I am
missing?

Thanks for looking.

Dylan Reid (3):
  ALSA: usb-audio: set period_bytes in substream.
  ALSA: usb-audio: Don't require hw_params in endpoint.
  ALSA: usb-audio: Move configuration to prepare.

 sound/usb/card.h     |   2 +
 sound/usb/endpoint.c |  29 +++++++-----
 sound/usb/endpoint.h |   5 ++-
 sound/usb/pcm.c      | 121 +++++++++++++++++++++++++++++++--------------------
 4 files changed, 97 insertions(+), 60 deletions(-)

-- 
1.7.12.146.g16d26b1
