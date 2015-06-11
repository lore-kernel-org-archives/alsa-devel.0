From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Fix link power unbalance at device
	removal
Date: Thu, 11 Jun 2015 14:20:49 +0200
Message-ID: <1434025249-12216-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B0EF7261A84
 for <alsa-devel@alsa-project.org>; Thu, 11 Jun 2015 14:20:52 +0200 (CEST)
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
Cc: Libin Yang <libin.yang@intel.com>, Mengdong Lin <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

snd_hdac_link_power() has to be called after unregistering the codec
device.  Otherwise the device might be already runtime-suspended, thus
the refcount goes under zero, triggering a warning like:

  WARNING: CPU: 7 PID: 2014 at sound/hda/hdac_i915.c:63 snd_hdac_display_power+0x106/0x120 [snd_hda_core]()
  CPU: 7 PID: 2014 Comm: modprobe Not tainted 4.1.0-rc7-test+ #1
  Call Trace:
   [<ffffffff81697fe3>] dump_stack+0x4c/0x6e
   [<ffffffff810696da>] warn_slowpath_common+0x8a/0xc0
   [<ffffffff810697ca>] warn_slowpath_null+0x1a/0x20
   [<ffffffffa02dd526>] snd_hdac_display_power+0x106/0x120 [snd_hda_core]
   [<ffffffffa030b422>] azx_intel_link_power+0x12/0x20 [snd_hda_intel]
   [<ffffffffa037139f>] azx_link_power+0x1f/0x30 [snd_hda_codec]
   [<ffffffffa02d89fe>] snd_hdac_link_power+0x2e/0x40 [snd_hda_core]
   [<ffffffffa0368524>] snd_hda_codec_dev_free+0x34/0x50 [snd_hda_codec]
   [<ffffffffa0252061>] __snd_device_free+0x51/0xa0 [snd]
   .....

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index d70229841156..497bd0f9dcda 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -886,8 +886,8 @@ static int snd_hda_codec_dev_free(struct snd_device *device)
 	struct hda_codec *codec = device->device_data;
 
 	codec->in_freeing = 1;
-	snd_hdac_link_power(&codec->core, false);
 	snd_hdac_device_unregister(&codec->core);
+	snd_hdac_link_power(&codec->core, false);
 	put_device(hda_codec_dev(codec));
 	return 0;
 }
-- 
2.4.3
