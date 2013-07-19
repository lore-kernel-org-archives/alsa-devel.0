From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCH RFC 00/10] Refactor set_format()
Date: Fri, 19 Jul 2013 20:23:20 +0200
Message-ID: <1374258210-14486-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f54.google.com (mail-ee0-f54.google.com [74.125.83.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 3351226577F
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 20:23:36 +0200 (CEST)
Received: by mail-ee0-f54.google.com with SMTP id t10so2559985eei.13
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 11:23:36 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Daniel Mack <zonque@gmail.com>, Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, Eldad Zack <eldad@fogrefinery.com>
List-Id: alsa-devel@alsa-project.org

Hi,

This is a low-priority series (applies against current for-next).
I had the idea of refactoring set_format to make it easier to read (I
actually indended to look at the implicit feedback setup race, but
stumbled on this again).

This series is not intended to be applied as-is (it has some whitespace
issues and I wrote the commit messages quickly), but to get some
feedback - if you think it's a good idea in general, and also specific
feedback to individual patches. Assuming it makes sense, I'll fix the
whitespace issues, commit messages and anything else before resubmitting.

Cheers,
Eldad

Eldad Zack (10):
  ALSA: usb-audio: remove disabled debug code in set_format
  ALSA: usb-audio: remove assignment from if condition
  ALSA: usb-audio: separate sync endpoint setting from set_format
  ALSA: usb-audio: move implicit fb quirks to separate function
  ALSA: usb-audio: reverse condition logic in set_sync_endpoint
  ALSA: usb-audio: do not initialize and check implicit_fb
  ALSA: usb-audio: remove is_playback from implicit feedback quirks
  ALSA: usb-audio: remove implicit_fb from quirk
  ALSA: usb-audio: clarify implicit fb quirk for Roland
  ALSA: usb-audio: check alts is not NULL before adding ep

 sound/usb/pcm.c | 249 ++++++++++++++++++++++++++++++++------------------------
 1 file changed, 144 insertions(+), 105 deletions(-)

-- 
1.8.1.5
