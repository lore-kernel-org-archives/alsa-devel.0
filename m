From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/3] ALSA: usb-audio: Fix NULL dereferences via
	invalid EP accesses
Date: Wed, 16 Mar 2016 12:50:13 +0100
Message-ID: <1458129016-27188-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C9C7265E33
 for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2016 12:50:19 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 08D77ACEA
 for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2016 11:50:17 +0000 (UTC)
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
List-Id: alsa-devel@alsa-project.org

Hi,

this is a small patchset to address the possible Oops by accessing the
invalid EP that was borked by a malformed firmware.  One patch is a
clean up while two are fixes.


Takashi

===

Takashi Iwai (3):
  ALSA: usb-audio: Fix NULL dereference in create_fixed_stream_quirk()
  ALSA: usb-audio: Minor code cleanup in create_fixed_stream_quirk()
  ALSA: usb-audio: Add sanity checks for endpoint accesses

 sound/usb/clock.c        |  2 ++
 sound/usb/endpoint.c     |  3 +++
 sound/usb/mixer_quirks.c |  4 ++++
 sound/usb/pcm.c          |  2 ++
 sound/usb/quirks.c       | 22 ++++++++++++++--------
 5 files changed, 25 insertions(+), 8 deletions(-)

-- 
2.7.3
