From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCH RFC 0/9] ALSA: usb-audio: fix playback/capture
	concurrent usage
Date: Sun, 18 Aug 2013 22:22:34 +0200
Message-ID: <1376857363-1116-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f52.google.com (mail-bk0-f52.google.com
 [209.85.214.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 868F3261605
 for <alsa-devel@alsa-project.org>; Sun, 18 Aug 2013 22:22:56 +0200 (CEST)
Received: by mail-bk0-f52.google.com with SMTP id e11so1162234bkh.39
 for <alsa-devel@alsa-project.org>; Sun, 18 Aug 2013 13:22:56 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, Daniel Mack <zonque@gmail.com>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Eldad Zack <eldad@fogrefinery.com>
List-Id: alsa-devel@alsa-project.org

Hi,

This patch series attempts to fix a long starting problem with the concurrent
usage of playback and capture on implicit feedback devices.

As Clemens found out, when implicit feedback is used, playback and capture
cannot be used in the same time - unless started at the same time (e.g., with
jack).
While a substream is active, attempting to start a substream in the opposite
direction will fail and also (on some devices?) cause the currently active stream
to stop.

There are multiple issues that contribute to this:

 1. URBs are unconditionally deactivated in hw_free. On implicit feedback devices,
    the sync_endpoint (= data_endpoint of the capture) will be deactivated here.
    Fixed in patch #4.

 2. Changing the alternate settings of an interface might break currently running
    streams. This happens on my device, but I suspect other devices too.
    Fixed in patch #7.

 3. The endpoint use_count has a subtle issue (see patch #9). This causes jack
    to work fine, while using two separate programs (most probably) fails.
    In short: set_format is called from hw_params, but use_count is incremented
    only later (prepare or trigger).

 4. Concurrent usage should be allowed but only if the hw_params match up (patch #8)

One problem with this series is that I query the device for the altsettting.
This might not be reliable for all devices, so do I plan to remove this.
Of course, I've only tested this on my device, but it seems to work good and
I couldn't break it so far, so hopefully I got this right.

Can someone give it a try on other devices (also on non-implicit-feedback)?

Cheers,
Eldad


Eldad Zack (9):
  ALSA: usb-audio: remove unused parameter from sync_ep_set_params
  ALSA: usb-audio: remove deactivate_endpoints()
  ALSA: usb-audio: prevent NULL dereference on stop trigger
  ALSA: usb-audio: don't deactivate URBs on in-use EP
  ALSA: usb-audio: void return type of snd_usb_endpoint_deactivate()
  ALSA: usb-audio: clear SUBSTREAM_FLAG_SYNC_EP_STARTED on error
  ALSA: usb-audio: conditional interface altsetting
  ALSA: usb-audio: conditional concurrent usage of endpoint
  ALSA: usb-audio: correct ep use_count semantics (add set_param flag)

 sound/usb/card.h     |   1 +
 sound/usb/endpoint.c |  65 +++++++++++++++------
 sound/usb/endpoint.h |  11 +++-
 sound/usb/pcm.c      | 155 +++++++++++++++++++++++++++++++++++++++------------
 4 files changed, 176 insertions(+), 56 deletions(-)

-- 
1.8.1.5
