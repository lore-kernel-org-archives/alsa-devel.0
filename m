From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: [PATCH 0/3] Random set of small HDA HDMI fixes
Date: Sun, 10 Nov 2013 20:56:09 +0200
Message-ID: <1384109772-7614-1-git-send-email-anssi.hannula@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tulikuusama.dnainternet.net (tulikuusama.dnainternet.net
 [83.102.40.132])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C703261B21
 for <alsa-devel@alsa-project.org>; Sun, 10 Nov 2013 19:56:24 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

Here's some random small fixes to the HDA HDMI code. First affects both
generic and ATI/AMD codecs and the last two concern ATI/AMD only.

At least 2 and 3 should go to 3.13.

No idea what caused the codec reads to fail in the first place regarding
the first patch... This was reported at:
http://forum.xbmc.org/showthread.php?tid=174854&pid=1546159#pid1546159


 sound/pci/hda/hda_eld.c    | 30 ++++++++++++++++++++++++------
 sound/pci/hda/patch_hdmi.c |  5 ++++-
 2 files changed, 28 insertions(+), 7 deletions(-)

Anssi Hannula (3):
      ALSA: hda - hdmi: Add error-checking to some codec reads
      ALSA: hda - hdmi: Skip out-of-range latency values in AMD ELD generator
      ALSA: hda - hdmi: Fix wrong baseline length in ATI/AMD generated ELD

-- 
Anssi Hannula
