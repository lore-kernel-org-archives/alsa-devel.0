From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCH v2 00/10] ALSA: usb-audio: fix
	playback/capture	concurrent usage
Date: Wed, 21 Aug 2013 23:37:55 +0200
Message-ID: <1377121085-20563-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f44.google.com (mail-bk0-f44.google.com
 [209.85.214.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D8EE264F13
 for <alsa-devel@alsa-project.org>; Wed, 21 Aug 2013 23:38:18 +0200 (CEST)
Received: by mail-bk0-f44.google.com with SMTP id mz10so389328bkb.17
 for <alsa-devel@alsa-project.org>; Wed, 21 Aug 2013 14:38:18 -0700 (PDT)
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

This patch series attempts to fix a long starting problem with the concurrent
usage of playback and capture on implicit feedback devices.

Applies against current for-next (HEAD b43dd416be21bc8ad60984e13def032f01aaaa18 ).

v1:
 http://mailman.alsa-project.org/pipermail/alsa-devel/2013-August/065517.html

Thanks to Clemens I was able to get rid of the get_interface workaround, so I
believe it's ready now, unless there's any other issues.

Other changes:
* Cleaned up and moved the set_param flag patch to #7.
* Fixed a NULL dereference in patch #8 for explicit feedback.
* Fixed a logic error in patch #9.
* Added patch #10.

Cheers,
Eldad

Eldad Zack (10):
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

 sound/usb/card.h     |   2 +-
 sound/usb/endpoint.c |  76 +++++++++++++++++-------
 sound/usb/endpoint.h |  11 +++-
 sound/usb/pcm.c      | 161 ++++++++++++++++++++++++++++++++++++++-------------
 sound/usb/pcm.h      |   2 +
 sound/usb/proc.c     |   4 +-
 6 files changed, 192 insertions(+), 64 deletions(-)

-- 
1.8.1.5
