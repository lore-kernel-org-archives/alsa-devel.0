From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/8] Yet more fixes for LPE HDMI audio
Date: Wed, 15 Feb 2017 22:29:28 +0100
Message-ID: <20170215212936.697-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id ED67F266E52
 for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2017 22:29:42 +0100 (CET)
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
Cc: Ian W MORRISON <ianwmorrison@gmail.com>, Rakesh A Ughreja <rakesh.a.ughreja@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, Jerome Anand <jerome.anand@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi,

here is yet another round of LPE HDMI audio driver updates.
After reading the report from Pierre, I tested the monitor connection
and xrandr, and confirmed that it sucks.  Here is an attempt to
improve the handling.

The patches are found in topic/intel-lpe-audio branch as usual, too.


Takashi

===

Takashi Iwai (8):
  ALSA: x86: Implement jack control
  ALSA: x86: Use snd_pcm_stop_xrun() for connection / disconnection
    paths
  ALSA: x86: Fix memory leak in had_build_channel_allocation_map()
  ALSA: x86: Don't return an error from chmap ctl at disconnected
  ALSA: x86: Avoid register accesses during disconnection
  ALSA: x86: Stop the stream when buffer is processed after
    disconnection
  ALSA: x86: Minor code rearrangement
  ALSA: x86: Don't bail out from PCM ops when disconnected

 sound/x86/intel_hdmi_audio.c | 118 +++++++++++++++++++++----------------------
 sound/x86/intel_hdmi_audio.h |   1 +
 2 files changed, 59 insertions(+), 60 deletions(-)

-- 
2.11.1
