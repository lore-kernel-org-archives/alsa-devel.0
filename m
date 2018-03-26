From: Kirill Marinushkin <k.marinushkin@gmail.com>
Subject: [RFC,
	alsa-utils] RFC: alsamixer: Improve description of playback switches
Date: Mon, 26 Mar 2018 07:11:44 +0200
Message-ID: <20180326051144.16672-1-k.marinushkin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 801B5266A73
 for <alsa-devel@alsa-project.org>; Mon, 26 Mar 2018 07:11:20 +0200 (CEST)
Received: by mail-wm0-f67.google.com with SMTP id i75so12830185wmf.0
 for <alsa-devel@alsa-project.org>; Sun, 25 Mar 2018 22:11:20 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Kirill Marinushkin <k.marinushkin@gmail.com>
List-Id: alsa-devel@alsa-project.org

Currently, all playback switches are described as mute. It is shown as:

[OO] == sound is on (left and right channels)
[MM] == sound is muted (left and right channels)

But cards can have different kinds of switch controls, not only mute. At
least usb-audio provides boolean controls as playback switches for:

* clock source validity (read only switch)
* processing features on/off (rw switch)
* potentially other similar use-cases

It becames confusing, because it is shown as:

[OO] == clock source is valid
[MM] == clock source is invalid

[OO] == processing feature is on
[MM] == processing feature is off

And from the help, it is not clear how to toggle such switches.

In this RFC, I suggest to show switches more generic:

[yy] == sound on    / clock source is valid   / processing feature is on
[nn] == sound muted / clock source is invalid / processing feature is off

And give a more generic description in the help.

Signed-off-by: Kirill Marinushkin <k.marinushkin@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
---
 alsamixer/mixer_display.c | 8 ++++----
 alsamixer/mixer_widget.c  | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/alsamixer/mixer_display.c b/alsamixer/mixer_display.c
index b1f79d0..f73b11a 100644
--- a/alsamixer/mixer_display.c
+++ b/alsamixer/mixer_display.c
@@ -513,13 +513,13 @@ static void display_control(unsigned int control_index)
 		mvwaddch(mixer_widget.window, base_y + 1, frame_left + 1,
 			 switches[0]
 			 /* TRANSLATORS: playback on; one character */
-			 ? _("O")[0] | (control->flags & IS_ACTIVE ? attr_ctl_nomute : 0)
+			 ? _("y")[0] | (control->flags & IS_ACTIVE ? attr_ctl_nomute : 0)
 			 /* TRANSLATORS: playback muted; one character */
-			 : _("M")[0] | (control->flags & IS_ACTIVE ? attr_ctl_mute : 0));
+			 : _("n")[0] | (control->flags & IS_ACTIVE ? attr_ctl_mute : 0));
 		waddch(mixer_widget.window,
 		       switches[1]
-		       ? _("O")[0] | (control->flags & IS_ACTIVE ? attr_ctl_nomute : 0)
-		       : _("M")[0] | (control->flags & IS_ACTIVE ? attr_ctl_mute : 0));
+		       ? _("y")[0] | (control->flags & IS_ACTIVE ? attr_ctl_nomute : 0)
+		       : _("n")[0] | (control->flags & IS_ACTIVE ? attr_ctl_mute : 0));
 	}
 
 	if (control->flags & TYPE_CSWITCH) {
diff --git a/alsamixer/mixer_widget.c b/alsamixer/mixer_widget.c
index 0c2b9e0..93d1923 100644
--- a/alsamixer/mixer_widget.c
+++ b/alsamixer/mixer_widget.c
@@ -210,9 +210,9 @@ static void show_help(void)
 		_("Z X C      Decrease left/both/right volumes"),
 		_("B          Balance left and right volumes"),
 		"",
-		_("M          Toggle mute"),
+		_("M          Toggle mute / playback switch"),
 		/* TRANSLATORS: or , . */
-		_("< >        Toggle left/right mute"),
+		_("< >        Toggle left/right mute / playback switch"),
 		"",
 		_("Space      Toggle capture"),
 		/* TRANSLATORS: or Insert Delete */
-- 
2.13.6
