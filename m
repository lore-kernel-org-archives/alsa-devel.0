From: Juergen Kreileder <jk@blackdown.de>
Subject: [patch] Fix snd-usb-audio in 32-bit compat environemt
Date: Sat, 18 Feb 2006 19:50:37 +0100
Message-ID: <878xs85wn6.fsf@blackdown.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi,

I'm getting oopses with snd-usb-audio in 32-bit compat environments:
control_compat.c:get_ctl_type() doesn't initialize 'info', so
'itemlist[uinfo->value.enumerated.item]' in
usbmixer.c:mixer_ctl_selector_info() might access random memory
(The 'if ((int)uinfo->value.enumerated.item >= cval->max)' doesn't fix
all problems because of the unsigned -> signed conversion.)

Here's a fix:

Signed-off-by: Juergen Kreileder <jk@blackdown.de>

--- linux-mm-vanilla/sound/core/control_compat.c	2006-02-18 17:00:17.000000000 +0100
+++ linux-mm/sound/core/control_compat.c	2006-02-18 19:17:45.000000000 +0100
@@ -167,7 +167,7 @@ static int get_ctl_type(struct snd_card 
 			int *countp)
 {
 	struct snd_kcontrol *kctl;
-	struct snd_ctl_elem_info info;
+	struct snd_ctl_elem_info *info;
 	int err;
 
 	down_read(&card->controls_rwsem);
@@ -176,13 +176,19 @@ static int get_ctl_type(struct snd_card 
 		up_read(&card->controls_rwsem);
 		return -ENXIO;
 	}
-	info.id = *id;
-	err = kctl->info(kctl, &info);
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (info == NULL) {
+		up_read(&card->controls_rwsem);
+		return -ENOMEM;
+	}
+	info->id = *id;
+	err = kctl->info(kctl, info);
 	up_read(&card->controls_rwsem);
 	if (err >= 0) {
-		err = info.type;
-		*countp = info.count;
+		err = info->type;
+		*countp = info->count;
 	}
+	kfree(info);
 	return err;
 }
 
=

Tested on ppc64.


        Juergen

-- 
Juergen Kreileder, Blackdown Java-Linux Team
http://blog.blackdown.de/


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
