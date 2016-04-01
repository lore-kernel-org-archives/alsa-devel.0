From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH 0/3] ASoC: hdac_hdmi: Fix codec power state in
	S3
Date: Fri,  1 Apr 2016 13:36:24 +0530
Message-ID: <1459497987-28979-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 78D572651BE
 for <alsa-devel@alsa-project.org>; Fri,  1 Apr 2016 10:07:04 +0200 (CEST)
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
Cc: tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

With this series, the codec power is turned OFF when entering
suspend if the playback is already in progress. And during resume
the power is restored. Codec driver registers the S3 callbacks
with prepare/complete to synchronize with Jack notification from
display driver. Codec driver takes care of putting the AFG node
to proper power state during S3 and controller driver takes care
of managing the codec power.

Also setting the power state for AFG node is optimized by
removing the timeout loop. The driver instead uses a codec_read,
which sets the power state and waits for response before the
codec power is turned OFF.

Subhransu S. Prusty (3):
  ASoC: hdac_hdmi: Fix to use dev_pm ops instead soc pm
  ASoC: hdac_hdmi: Fix codec power state in S3 during playback
  ASoC: Intel: Skylake: Fix to turn OFF codec power when entering S3

 sound/soc/codecs/hdac_hdmi.c  | 94 +++++++++++++++++++------------------------
 sound/soc/intel/skylake/skl.c | 15 ++++++-
 2 files changed, 55 insertions(+), 54 deletions(-)

-- 
1.9.1
