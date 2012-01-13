From: Kusanagi Kouichi <slash@ac.auone-net.jp>
Subject: [PATCH] alsamixer: Confirm that a drastic volume
 change is intentional.
Date: Fri, 13 Jan 2012 20:14:49 +0900
Message-ID: <20120113111449.EDBE06FC039@msa105.auone-net.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from msa105.auone-net.jp (msa105.auone-net.jp [61.117.18.165])
	by alsa0.perex.cz (Postfix) with ESMTP id 6CCBA24528
	for <alsa-devel@alsa-project.org>; Fri, 13 Jan 2012 12:14:52 +0100 (CET)
Received: from ppp.dion.ne.jp (ZJ087010.ppp.dion.ne.jp [222.4.87.10])
	by msa105.auone-net.jp (au one net msa) with ESMTP id EDBE06FC039
	for <alsa-devel@alsa-project.org>; Fri, 13 Jan 2012 20:14:49 +0900 (JST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Home key has been disabled because it might at least surprise a user
unless volume is already nearly full. Not only home but 9, 8 and so
on might also surprise a user. So instead of disableing key, show
confirmation dialog for drastic volume change.

Signed-off-by: Kusanagi Kouichi <slash@ac.auone-net.jp>
---
 alsamixer/mixer_widget.c   |   52 ++++++++++++++++++++++++++++++++++++++------
 alsamixer/volume_mapping.c |    3 ++
 2 files changed, 48 insertions(+), 7 deletions(-)

diff --git a/alsamixer/mixer_widget.c b/alsamixer/mixer_widget.c
index caaf777..d01a6ec 100644
--- a/alsamixer/mixer_widget.c
+++ b/alsamixer/mixer_widget.c
@@ -207,6 +207,7 @@ static void show_help(void)
 		_("Up/Down    Change volume"),
 		_("+ -        Change volume"),
 		_("Page Up/Dn Change volume in big steps"),
+		_("Home       Set volume to 100%"),
 		_("End        Set volume to 0%"),
 		_("0-9        Set volume to 0%-90%"),
 		_("Q W E      Increase left/both/right volumes"),
@@ -305,9 +306,10 @@ static void change_enum_relative(struct control *control, int delta)
 			snd_mixer_selem_set_enum_item(control->elem, i, new_index);
 }
 
-static void change_volume_to_percent(struct control *control, int value, unsigned int channels)
+static int change_volume_to_percent(struct control *control, int value, unsigned int channels)
 {
 	int (*set_func)(snd_mixer_elem_t *, snd_mixer_selem_channel_id_t, double, int);
+	int err = 0;
 
 	if (!(control->flags & HAS_VOLUME_1))
 		channels = LEFT;
@@ -316,9 +318,10 @@ static void change_volume_to_percent(struct control *control, int value, unsigne
 	else
 		set_func = set_normalized_capture_volume;
 	if (channels & LEFT)
-		set_func(control->elem, control->volume_channels[0], value / 100.0, 0);
-	if (channels & RIGHT)
-		set_func(control->elem, control->volume_channels[1], value / 100.0, 0);
+		err = set_func(control->elem, control->volume_channels[0], value / 100.0, 0);
+	if (channels & RIGHT && err <= 0)
+		err = set_func(control->elem, control->volume_channels[1], value / 100.0, 0);
+	return err;
 }
 
 static double clamp_volume(double v)
@@ -371,7 +374,44 @@ static void change_control_to_percent(int value, unsigned int channels)
 	if (control->flags & TYPE_ENUM)
 		change_enum_to_percent(control, value);
 	else
-		change_volume_to_percent(control, value, channels);
+		if (change_volume_to_percent(control, -value, channels)) {
+			char buf[50];
+			const char * const text[] = { buf, "               (Y/n)" };
+			const struct widget *active_widget;
+
+			snprintf(buf, sizeof buf, "Do you really change volume to %d%%?", value);
+			show_text(text, 2, "");
+			active_widget = get_active_widget();
+			wtimeout(active_widget->window, -1);
+			while (1) {
+				switch (wgetch(active_widget->window)) {
+#ifdef KEY_RESIZE
+				case KEY_RESIZE:
+					window_size_changed();
+					continue;
+#endif
+				case 'Y':
+				case 'y':
+				case '\n':
+				case KEY_ENTER:
+					change_volume_to_percent(control, value, channels);
+					break;
+				case 'N':
+				case 'n':
+				case 27:
+				case KEY_CANCEL:
+				case KEY_CLOSE:
+				case KEY_EXIT:
+					break;
+				default:
+					continue;
+				}
+				break;
+			}
+			active_widget->handle_key(KEY_ENTER);
+		} else
+			change_volume_to_percent(control, value, channels);
+
 	display_controls();
 }
 
@@ -536,12 +576,10 @@ static void on_handle_key(int key)
 	case KEY_NPAGE:
 		change_control_relative(-5, LEFT | RIGHT);
 		break;
-#if 0
 	case KEY_BEG:
 	case KEY_HOME:
 		change_control_to_percent(100, LEFT | RIGHT);
 		break;
-#endif
 	case KEY_LL:
 	case KEY_END:
 		change_control_to_percent(0, LEFT | RIGHT);
diff --git a/alsamixer/volume_mapping.c b/alsamixer/volume_mapping.c
index 1c0d7c4..bd160ed 100644
--- a/alsamixer/volume_mapping.c
+++ b/alsamixer/volume_mapping.c
@@ -133,6 +133,9 @@ static int set_normalized_volume(snd_mixer_elem_t *elem,
 	double min_norm;
 	int err;
 
+	if (volume < 0)
+		return -volume - get_normalized_volume(elem, channel, ctl_dir) >= 0.5;
+
 	err = get_dB_range[ctl_dir](elem, &min, &max);
 	if (err < 0 || min >= max) {
 		err = get_raw_range[ctl_dir](elem, &min, &max);
-- 
1.7.8.3
