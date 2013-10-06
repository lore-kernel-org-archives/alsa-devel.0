From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCH v4 00/15] ALSA: usb-audio: fix
	playback/capture	concurrent usage
Date: Sun,  6 Oct 2013 22:31:05 +0200
Message-ID: <1381091480-23636-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f54.google.com (mail-bk0-f54.google.com
 [209.85.214.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 09E47261A5B
 for <alsa-devel@alsa-project.org>; Sun,  6 Oct 2013 22:31:25 +0200 (CEST)
Received: by mail-bk0-f54.google.com with SMTP id mz12so2386995bkb.27
 for <alsa-devel@alsa-project.org>; Sun, 06 Oct 2013 13:31:25 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, Daniel Mack <zonque@gmail.com>, Nikolay Martynov <mar.kolya@gmail.com>
Cc: alsa-devel@alsa-project.org, Eldad Zack <eldad@fogrefinery.com>
List-Id: alsa-devel@alsa-project.org

Hi,

This patch series attempts to fix a long standing problem with the concurrent
usage of playback and capture on implicit feedback devices.

Now the following work properly on my system:
* Full-duplex with jack :)

* All tests I ran with my tool. Will post it in case anyone want to try it,
  it takes about 15 minutes to run all the tests.

* Starting a capture-only jackd instance, e.g.:
    jackd -n 1 -d alsa -d hw:2,0 -C
  and then playback-only:
    jackd -n 2 -d alsa -d hw:2,0 -P
  and then stop and start the playback.
  The same with playback running and restarting capture.

* Trying to start a second substream with parameter mismatch (rate or
  period bytes is all I can test with my device) will fail,
  without ill effects.

With this series applied there are now 3 usage tracking variables:
 - substream usage flag
 - endpoint param_set (to protect the parameters until the endpoint is started)
 - the existing endpoint use_count

Changes from v3:
* Added substream "used" flag, to prevent failure in some combinations of ops. (#13)
* Moved start_endpoints for capture to prepare (#14)
* Added more constraints to the endpoint_may_set_params function (#10)
* Cleanups (#12, #15)

v3:
http://mailman.alsa-project.org/pipermail/alsa-devel/2013-August/065744.html

Applies against for-next, tested on upstream 3.12-rc3 (needs Alan Stern's recent
patch "improve buffer size computations for USB PCM audio" to apply cleanly
on current mainline).

Daniel and Nikolay: if you can test again with this series I'd appreciate it.

Cheers,
Eldad

Eldad Zack (15):
  ALSA: usb-audio: remove unused parameter from sync_ep_set_params
  ALSA: usb-audio: remove deactivate_endpoints()
  ALSA: usb-audio: prevent NULL dereference on stop trigger
  ALSA: usb-audio: don't deactivate URBs on in-use EP
  ALSA: usb-audio: void return type of snd_usb_endpoint_deactivate()
  ALSA: usb-audio: clear SUBSTREAM_FLAG_SYNC_EP_STARTED on error
  ALSA: usb-audio: correct ep use_count semantics (add set_param flag)
  ALSA: usb-audio: rename alt_idx to altsetting
  ALSA: usb-audio: conditional interface altsetting
  ALSA: usb-audio: conditional concurrent usage of endpoint
  ALSA: usb-audio: remove altset_idx from snd_usb_substream
  ALSA: usb-audio: remove unused endpoint flag EP_FLAG_ACTIVATED
  ALSA: usb-audio: clear sync subs hw_params
  ALSA: usb-audio: always wait in start_endpoints
  ALSA: usb-audio: improve logging messages

 sound/usb/card.h     |   9 ++-
 sound/usb/endpoint.c | 122 ++++++++++++++++++++---------
 sound/usb/endpoint.h |  13 +++-
 sound/usb/pcm.c      | 214 ++++++++++++++++++++++++++++++++++++---------------
 sound/usb/pcm.h      |   2 +
 sound/usb/proc.c     |   4 +-
 6 files changed, 258 insertions(+), 106 deletions(-)

-- 
1.8.1.5
