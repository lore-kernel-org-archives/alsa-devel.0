From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/4] Yet another patchset for LPE audio
	refactoring
Date: Fri,  3 Feb 2017 17:43:56 +0100
Message-ID: <20170203164400.12983-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B796F266B1C
 for <alsa-devel@alsa-project.org>; Fri,  3 Feb 2017 17:44:03 +0100 (CET)
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
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jerome Anand <jerome.anand@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi,

this is the final part of my cleanup / refactoring patchsets for Intel
LPE audio.  Now the PCM stream engine has been rewritten.  It supports
more flexible configuration, not only fixed 4 periods, for example,
yet with a lot of code reduction.

As usual, the patches are found in topic/intel-lpe-audio-cleanup
branch.


thanks,

Takashi

===

Takashi Iwai (4):
  ALSA: x86: Don't pass SNDRV_PCM_INFO_BATCH flag
  ALSA: x86: Explicit specify 32bit DMA
  ALSA: x86: Don't check connection in lowlevel accessors
  ALSA: x86: Refactor PCM process engine

 sound/x86/intel_hdmi_audio.c     | 613 ++++++++++++++-------------------------
 sound/x86/intel_hdmi_audio.h     |  23 +-
 sound/x86/intel_hdmi_lpe_audio.h |  26 +-
 3 files changed, 236 insertions(+), 426 deletions(-)

-- 
2.11.0
