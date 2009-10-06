From: pavel.hofman@ivitera.com
Subject: [PATCH 1/1] Changing the Multi Track Peak control from
	MIXER to PCM type
Date: Tue,  6 Oct 2009 16:00:16 +0200
Message-ID: <1254837616-18530-1-git-send-email-pavel.hofman@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
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

* The "Multi Track Peak" control is now of PCM type, to avoid
  confusing users in other alsa mixers.

Signed-off-by: Pavel Hofman <pavel.hofman@ivitera.com>

diff --git a/envy24control/levelmeters.c b/envy24control/levelmeters.c
index 3bf1a94..fa44979 100644
--- a/envy24control/levelmeters.c
+++ b/envy24control/levelmeters.c
@@ -261,9 +261,15 @@ void level_meters_reset_peaks(GtkButton *button, gpointer data)
 
 void level_meters_init(void)
 {
+	int err;
+
 	snd_ctl_elem_value_malloc(&peaks);
-	snd_ctl_elem_value_set_interface(peaks, SND_CTL_ELEM_IFACE_MIXER);
+	snd_ctl_elem_value_set_interface(peaks, SND_CTL_ELEM_IFACE_PCM);
 	snd_ctl_elem_value_set_name(peaks, "Multi Track Peak");
+	if ((err = snd_ctl_elem_read(ctl, peaks)) < 0)
+		/* older ALSA driver, using MIXER type */
+		snd_ctl_elem_value_set_interface(peaks,
+			SND_CTL_ELEM_IFACE_MIXER);
 }
 
 void level_meters_postinit(void)
-- 
1.5.4.3
