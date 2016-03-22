From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/7] Intel HD-audio HDMI codec driver rewrites
Date: Tue, 22 Mar 2016 12:29:26 +0100
Message-ID: <1458646173-14520-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id F405C261A40
 for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2016 12:29:35 +0100 (CET)
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
Cc: libin.yang@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Hi,

here is a patch series for rewrite / cleanup of Intel HD-audio codec
driver.  The main purpose of this patchset is to re-add the support of
i915 ELD notification for old chipsets.  For that, it starts from the
cleanup of the HDMI codec driver code to get rid of excessive usages
of is_*() macros.  Then the fixes for supporting the old chips in HDA
core side and HDMI codec driver side.

Although this could be included for 4.6, my current plan is to
postpone this for 4.7.


Takashi

===

Takashi Iwai (7):
  ALSA: hda - Split out Intel-specific codes from patch_generic_hdmi()
  ALSA: hda - Apply AMP fix in hdmi_setup_audio_infoframe() generically
  ALSA: hda - Override HDMI setup_stream ops for Intel HSW+
  ALSA: hda - Introduce pin_cvt_fixup() ops to hdmi parser
  ALSA: hda - Use eld notifier for Intel SandyBridge and IvyBridge
    HDMI/DP
  ALSA: hda - Add the pin / port mapping on Intel ILK and VLV
  ALSA: hda - Enable i915 ELD notifier for Intel IronLake and Baytrail

 include/sound/hda_i915.h   |  10 +-
 sound/hda/hdac_i915.c      |  45 ++++--
 sound/pci/hda/patch_hdmi.c | 373 ++++++++++++++++++++++++++++++---------------
 3 files changed, 293 insertions(+), 135 deletions(-)

-- 
2.7.4
