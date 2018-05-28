From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/3] ALSA: usb-audio: trivial cleanups
Date: Mon, 28 May 2018 11:58:18 +0200
Message-ID: <20180528095821.28710-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D24F267255
 for <alsa-devel@alsa-project.org>; Mon, 28 May 2018 17:32:15 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id CF6CDAC14
 for <alsa-devel@alsa-project.org>; Mon, 28 May 2018 15:32:14 +0000 (UTC)
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

this is a series of trivial cleanups in USB-audio codes, as a wrap up
for the usb-audio code changes for 4.18.
No functional change by the series.


Takashi

===

Takashi Iwai (3):
  ALSA: usb-audio: Avoid lowlevel device object
  ALSA: usb-audio: Move autoresume call at the end of open
  ALSA: usb-audio: Follow standard coding style

 sound/usb/card.c         | 28 +++------------
 sound/usb/clock.c        | 18 +++++-----
 sound/usb/mixer.c        | 25 ++++++++-----
 sound/usb/mixer_quirks.c |  3 +-
 sound/usb/pcm.c          | 91 +++++++++++++++++++++++++-----------------------
 5 files changed, 81 insertions(+), 84 deletions(-)

-- 
2.16.3
