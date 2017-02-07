From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/2] Fix some corner cases in LPE Audio driver
Date: Tue,  7 Feb 2017 17:37:58 +0100
Message-ID: <20170207163800.4039-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B908266619
 for <alsa-devel@alsa-project.org>; Tue,  7 Feb 2017 17:38:02 +0100 (CET)
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

while debugging the dmix problem with S16/S32 format, I noticed a
possible race and some optimization.  Here is the updates.


Takashi

===

Takashi Iwai (2):
  ALSA: x86: Cache AUD_CONFIG register value
  ALSA: x86: Avoid unconditional call of snd_pcm_period_elapsed()

 sound/x86/intel_hdmi_audio.c | 68 +++++++++++++++++++-------------------------
 sound/x86/intel_hdmi_audio.h |  1 +
 2 files changed, 31 insertions(+), 38 deletions(-)

-- 
2.11.0
