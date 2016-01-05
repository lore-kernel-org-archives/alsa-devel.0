From: Mark Brown <broonie@kernel.org>
Subject: Applied "drm/i915: increase the tries for HDMI hotplug
	live status checking" to the asoc tree
Date: Tue, 05 Jan 2016 12:33:13 +0000
Message-ID: <E1aGQnZ-0007Vo-7l@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D2C92612AE
 for <alsa-devel@alsa-project.org>; Tue,  5 Jan 2016 13:33:22 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Gary Wang <gary.c.wang@intel.com>, Gavin Hindman <gavin.hindman@intel.com>, Sonika Jindal <sonika.jindal@intel.com>, Shashank Sharma <shashank.sharma@intel.com>, Shobhit Kumar <shobhit.kumar@intel.com>Gary Wang <gary.c.wang@intel.com>Shobhit Kumar <shobhit.kumar@intel.com>, drm-intel-fixes@lists.freedesktop.org, Daniel Vetter <daniel.vetter@ffwll.ch>, Jani Nikula <jani.nikula@intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   drm/i915: increase the tries for HDMI hotplug live status checking

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 3d8acd1f667b45c531401c8f0c2033072e32a05d Mon Sep 17 00:00:00 2001
From: Gary Wang <gary.c.wang@intel.com>
Date: Wed, 23 Dec 2015 16:11:35 +0800
Subject: [PATCH] drm/i915: increase the tries for HDMI hotplug live status
 checking

The total delay of HDMI hotplug detecting with 30ms is sometimes not
enoughtfor HDMI live status up with specific HDMI monitors in BSW platform.

After doing experiments for following monitors, it needs 80ms at least
for those worst cases.

Lenovo L246 1xwA (4 failed, necessary hot-plug delay: 58/40/60/40ms)
Philips HH2AP (9 failed, necessary hot-plug delay: 80/50/50/60/46/40/58/58/39ms)
BENQ ET-0035-N (6 failed, necessary hot-plug delay: 60/50/50/80/80/40ms)
DELL U2713HM (2 failed, necessary hot-plug delay: 58/59ms)
HP HP-LP2475w (5 failed, necessary hot-plug delay: 70/50/40/60/40ms)

It looks like 70-80 ms is BSW platform needs in some bad cases of the
monitors at this end (8 times delay at most). Keep less than 100ms for
HDCP pulse HPD low (with at least 100ms) to respond a plug out.

Reviewed-by: Cooper Chiou <cooper.chiou@intel.com>
Tested-by: Gary Wang <gary.c.wang@intel.com>
Cc: Gavin Hindman <gavin.hindman@intel.com>
Cc: Sonika Jindal <sonika.jindal@intel.com>
Cc: Shashank Sharma <shashank.sharma@intel.com>
Cc: Shobhit Kumar <shobhit.kumar@intel.com>
Signed-off-by: Gary Wang <gary.c.wang@intel.com>
Link: http://patchwork.freedesktop.org/patch/msgid/1450858295-12804-1-git-send-email-gary.c.wang@intel.com
Tested-by: Shobhit Kumar <shobhit.kumar@intel.com>
Cc: drm-intel-fixes@lists.freedesktop.org
Fixes: 237ed86c693d ("drm/i915: Check live status before reading edid")
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
(cherry picked from commit f8d03ea0053b23de42c828d559016eabe0b91523)
[Jani: undo the file mode change of the original commit]
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/i915/intel_hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/intel_hdmi.c b/drivers/gpu/drm/i915/intel_hdmi.c
index 64086f2d4e26..e6c035b0fc1c 100644
--- a/drivers/gpu/drm/i915/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/intel_hdmi.c
@@ -1381,7 +1381,7 @@ intel_hdmi_detect(struct drm_connector *connector, bool force)
 
 	intel_display_power_get(dev_priv, POWER_DOMAIN_GMBUS);
 
-	for (try = 0; !live_status && try < 4; try++) {
+	for (try = 0; !live_status && try < 9; try++) {
 		if (try)
 			msleep(10);
 		live_status = intel_digital_port_connected(dev_priv,
-- 
2.6.2
