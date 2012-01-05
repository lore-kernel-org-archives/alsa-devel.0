From: pavel.hofman@ivitera.com
Subject: [PATCH - ice1724 2/4] ALSA: ice1724 - External clock
	item only for cards with SPDIF_IN
Date: Thu,  5 Jan 2012 22:01:56 +0100
Message-ID: <1325797318-16333-2-git-send-email-pavel.hofman@ivitera.com>
References: <1325797318-16333-1-git-send-email-pavel.hofman@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1325797318-16333-1-git-send-email-pavel.hofman@ivitera.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Pavel Hofman <pavel.hofman@ivitera.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Pavel Hofman <pavel.hofman@ivitera.com>

Append the external clock item to the clock list only if
the SPDIF_IN capability is defined in the SPDIF register.

Signed-off-by: Pavel Hofman <pavel.hofman@ivitera.com>

diff --git a/pci/ice1712/ice1724.c b/pci/ice1712/ice1724.c
index 2a0be2c..a671377 100644
--- a/pci/ice1712/ice1724.c
+++ b/pci/ice1712/ice1724.c
@@ -1829,7 +1829,12 @@ static int snd_vt1724_pro_internal_clock_info(struct snd_kcontrol *kcontrol,
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = 1;
 
-	uinfo->value.enumerated.items = hw_rates_count + ice->ext_clock_count;
+	/* internal clocks */
+	uinfo->value.enumerated.items = hw_rates_count;
+	/* external clocks */
+	if (ice->force_rdma1 ||
+	    (ice->eeprom.data[ICE_EEP2_SPDIF] & VT1724_CFG_SPDIF_IN))
+		uinfo->value.enumerated.items += ice->ext_clock_count;
 	/* upper limit - keep at top */
 	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
 		uinfo->value.enumerated.item = uinfo->value.enumerated.items - 1;
-- 
1.7.0.4
