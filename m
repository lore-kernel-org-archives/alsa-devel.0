From: Mark Brown <broonie@kernel.org>
Subject: Applied "drm/i915: Unbreak
	check_digital_port_conflicts()" to the asoc tree
Date: Tue, 05 Jan 2016 12:33:14 +0000
Message-ID: <E1aGQna-0007Wu-N5@debutante>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4167174696140882182=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 170DD2610A3
 for <alsa-devel@alsa-project.org>; Tue,  5 Jan 2016 13:33:21 +0100 (CET)
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
To: stable@vger.kernel.org, Ander Conselvan de Oliveira <ander.conselvan.de.oliveira@intel.com>, Jani Nikula <jani.nikula@intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============4167174696140882182==
Content-Type: text/plain

The patch

   drm/i915: Unbreak check_digital_port_conflicts()

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

>From ae35b56e367b9fef7f5de701cf8c1c3dd954dded Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>
Date: Thu, 10 Dec 2015 18:22:31 +0200
Subject: [PATCH] drm/i915: Unbreak check_digital_port_conflicts()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Atomic changes broke check_digital_port_conflicts(). It needs to look
at the global situation instead of just trying to find a conflict
within the current atomic state.

This bug made my HSW explode spectacularly after I had split the DDI
encoders into separate DP and HDMI encoders. With the fix, things
seem much more solid.

I hope holding the connection_mutex is enough protection that we can
actually walk the connectors even if they're not part of the current
atomic state...

v2: Regenerate the patch so that it actually applies (Jani)

Cc: stable@vger.kernel.org
Cc: Ander Conselvan de Oliveira <ander.conselvan.de.oliveira@intel.com>
Fixes: 5448a00d3f06 ("drm/i915: Don't use staged config in check_digital_port_conflicts()")
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: http://patchwork.freedesktop.org/patch/msgid/1449764551-12466-1-git-send-email-ville.syrjala@linux.intel.com
(cherry picked from commit 0bff4858653312a10c83709e0009c3adb87e6f1e)
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/i915/intel_display.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_display.c b/drivers/gpu/drm/i915/intel_display.c
index beb0374a19f1..32cf97346978 100644
--- a/drivers/gpu/drm/i915/intel_display.c
+++ b/drivers/gpu/drm/i915/intel_display.c
@@ -12123,18 +12123,22 @@ static void intel_dump_pipe_config(struct intel_crtc *crtc,
 static bool check_digital_port_conflicts(struct drm_atomic_state *state)
 {
 	struct drm_device *dev = state->dev;
-	struct intel_encoder *encoder;
 	struct drm_connector *connector;
-	struct drm_connector_state *connector_state;
 	unsigned int used_ports = 0;
-	int i;
 
 	/*
 	 * Walk the connector list instead of the encoder
 	 * list to detect the problem on ddi platforms
 	 * where there's just one encoder per digital port.
 	 */
-	for_each_connector_in_state(state, connector, connector_state, i) {
+	drm_for_each_connector(connector, dev) {
+		struct drm_connector_state *connector_state;
+		struct intel_encoder *encoder;
+
+		connector_state = drm_atomic_get_existing_connector_state(state, connector);
+		if (!connector_state)
+			connector_state = connector->state;
+
 		if (!connector_state->best_encoder)
 			continue;
 
-- 
2.6.2


--===============4167174696140882182==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4167174696140882182==--
