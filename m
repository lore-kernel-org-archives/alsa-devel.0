From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCH v3 00/11] ALSA: usb-audio: fix playback/capture
	concurrent usage
Date: Sun, 25 Aug 2013 17:43:08 +0200
Message-ID: <1377445399-5678-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f54.google.com (mail-bk0-f54.google.com
 [209.85.214.54])
 by alsa0.perex.cz (Postfix) with ESMTP id AFA3A2618EE
 for <alsa-devel@alsa-project.org>; Sun, 25 Aug 2013 17:43:30 +0200 (CEST)
Received: by mail-bk0-f54.google.com with SMTP id mz12so830250bkb.27
 for <alsa-devel@alsa-project.org>; Sun, 25 Aug 2013 08:43:27 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, Eldad Zack <eldad@fogrefinery.com>
List-Id: alsa-devel@alsa-project.org

Hi,

This patch series attempts to fix a long standing problem with the concurrent
usage of playback and capture on implicit feedback devices.

Applies against current for-next (HEAD 68538bf2bce557c3b5fe8c59b034d45352500db1 ).

v2:
 http://mailman.alsa-project.org/pipermail/alsa-devel/2013-August/065649.html
v1:
 http://mailman.alsa-project.org/pipermail/alsa-devel/2013-August/065517.html

 * Changed "altset_idx" to "altsetting" thanks to Clemens' clarification.

 #3: Thanks to Daniel's test, fixed a NULL dereference caused by userspace calling
     snd_pcm_open() and then snd_pcm_close() immediately.
 #8: subs->altset_idx was left intact, since it corresponds to the array index.
 #10: this patch now removed subs->altset_idx, but also changes the check to be
      performed against fmt->altsetting.
 #11: New. This changes the name of snd_usb_endpoint member alt_idx to altsetting
      for the same reason Clemens described.

Clemens and Daniel - thank you very much for your help!

Cheers,
Eldad

Eldad Zack (11):
  ALSA: usb-audio: remove unused parameter from sync_ep_set_params
  ALSA: usb-audio: remove deactivate_endpoints()
  ALSA: usb-audio: prevent NULL dereference on stop trigger
  ALSA: usb-audio: don't deactivate URBs on in-use EP
  ALSA: usb-audio: void return type of snd_usb_endpoint_deactivate()
  ALSA: usb-audio: clear SUBSTREAM_FLAG_SYNC_EP_STARTED on error
  ALSA: usb-audio: correct ep use_count semantics (add set_param flag)
  ALSA: usb-audio: conditional interface altsetting
  ALSA: usb-audio: conditional concurrent usage of endpoint
  ALSA: usb-audio: remove altset_idx from snd_usb_substream
  ALSA: usb-audio: rename alt_idx to altsetting

 sound/usb/card.h     |   4 +-
 sound/usb/endpoint.c |  82 ++++++++++++++++++-------
 sound/usb/endpoint.h |  11 +++-
 sound/usb/pcm.c      | 168 ++++++++++++++++++++++++++++++++++++++-------------
 sound/usb/pcm.h      |   2 +
 sound/usb/proc.c     |   4 +-
 6 files changed, 201 insertions(+), 70 deletions(-)

-- 
1.8.1.5
