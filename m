From: Wang Xingchao <xingchao.wang@linux.intel.com>
Subject: [PATCH 2/4] ALSA: hda - Return error when open empty
	hdmi device
Date: Fri, 14 Jun 2013 23:20:27 +0800
Message-ID: <1371223229-8236-3-git-send-email-xingchao.wang@linux.intel.com>
References: <1371223229-8236-1-git-send-email-xingchao.wang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A3BF26030E
 for <alsa-devel@alsa-project.org>; Fri, 14 Jun 2013 17:48:40 +0200 (CEST)
In-Reply-To: <1371223229-8236-1-git-send-email-xingchao.wang@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, daniel.vetter@ffwll.ch
Cc: alsa-devel@alsa-project.org, xingchao.wang@intel.com, Wang Xingchao <xingchao.wang@linux.intel.com>, intel-gfx@lists.freedesktop.org, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

when user open HDMI device 3/7/8, if it has no physical device
connected, return error.
The bug is from Haswell platform, All pins choose converter 0 by default
in hardware level, maybe only pin 1 had valid monitor connected. if user
play audio on pin 0/2, pin 1 can get audio data too.

Signed-off-by: Wang Xingchao <xingchao.wang@linux.intel.com>
---
 sound/pci/hda/patch_hdmi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 8db5eb6..d766f40 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1139,6 +1139,9 @@ static int hdmi_pcm_open(struct hda_pcm_stream *hinfo,
 	per_pin = get_pin(spec, pin_idx);
 	eld = &per_pin->sink_eld;
 
+	if (!eld->monitor_present || !eld->eld_valid)
+		return -EIO;
+
 	if (codec->vendor_id == 0x80862807)
 		hsw_verify_cvt_D0(spec, codec);
 		
-- 
1.8.1.2
