From: Arnaud de Bossoreille de Ribou <arnaud.debossoreille@via.ecp.fr>
Subject: [patch] set_power_state bug
Date: Fri, 28 Feb 2003 13:38:27 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030228123827.GA4457@via.ecp.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="DocE+STaALJfprDB"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

there's a bug introduced in the 1.25 revision of the file
"alsa-kernel/core/control.c" which is fixed with the attached patch.

Please apply :-)

Bye,

-- 
Arnaud

--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="power.patch"

--- alsa-kernel/core/control.c	2003-01-13 10:49:43.000000000 +0100
+++ alsa-kernel/core/control.c	2003-02-28 13:27:58.000000000 +0100
@@ -714,15 +714,16 @@
 			return -EFAULT;
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
-		err = -ENOPROTOOPT;
 #ifdef CONFIG_PM
 		if (card->set_power_state) {
 		    snd_power_lock(card);
 		    err = card->set_power_state(card, err);
 		    snd_power_unlock(card);
 		}
-#endif
 		return err;
+#else
+		return -ENOPROTOOPT;
+#endif
 	case SNDRV_CTL_IOCTL_POWER_STATE:
 #ifdef CONFIG_PM
 		return put_user(card->power_state, (int *)arg) ? -EFAULT : 0;

--DocE+STaALJfprDB--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
