From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/4] Internal PCM fixes / cleanups
Date: Fri, 20 Feb 2015 17:23:24 +0100
Message-ID: <1424449408-22376-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id F120A260592
 for <alsa-devel@alsa-project.org>; Fri, 20 Feb 2015 17:23:31 +0100 (CET)
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi,

while reading the internal PCM (BE) handling code again, I noticed a
few potential bugs.  Here are fix and cleanup patches.


Takashi

===

Takashi Iwai (4):
  ALSA: pcm: Minor refactoring in snd_pcm_attach_substream()
  ALSA: pcm: Don't add internal PCMs to PCM device list
  ALSA: pcm: Don't notify internal PCMs
  ALSA: pcm: Don't ignore internal PCMs in snd_pcm_dev_disconnect()

 sound/core/pcm.c | 92 +++++++++++++++++++++++++-------------------------------
 1 file changed, 41 insertions(+), 51 deletions(-)

-- 
2.3.0
