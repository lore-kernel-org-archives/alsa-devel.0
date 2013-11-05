From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 0/3] ALSA: usb channel map fixes
Date: Tue,  5 Nov 2013 04:41:05 +0100
Message-ID: <1383622868-2596-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 73753261A3B
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2013 04:41:12 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Ok, so I actually tested my patch, and it turned out things were slightly
more complex than expected - the original patch is still needed, but in addition,
we also need to build the channel map after the format parse, because the format
of the descriptor is not always the same as the format of the input terminal.
These two fixes made the mono chmap show up on my logitech USB headset, on both
output and input side.

I also tested my patches with another USB device. This device is UAC2, and when
looking at lsusb I found that in UAC2 the streaming descriptor has a channel config too.
Given what I found on the headset, it seems reasonable to use this channel config
instead of the input terminal's channel config, although in my case it made no
practical difference.

David Henningsson (3):
  ALSA: usb: supply channel maps even when wChannelConfig is
    unspecified
  ALSA: usb - For class 2 devices, use channel map from altsettings
  ALSA: usb - Don't trust the channel config if the channel count
    changed

 sound/usb/stream.c |   29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

-- 
1.7.9.5
