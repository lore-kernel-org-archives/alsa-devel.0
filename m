From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] fix SB crash
Date: Mon, 13 Jan 2003 09:25:01 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0301130921540.3084-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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


snd_ctl_new1() is called from snd_sbmixer_add_ctl() with ncontrol->name
set to NULL.


Index: core/control.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/core/control.c,v
retrieving revision 1.26
diff -u -r1.26 control.c
--- core/control.c	7 Jan 2003 12:27:45 -0000	1.26
+++ core/control.c	13 Jan 2003 08:19:27 -0000
@@ -211,7 +211,8 @@
 	kctl.id.iface = ncontrol->iface;
 	kctl.id.device = ncontrol->device;
 	kctl.id.subdevice = ncontrol->subdevice;
-	strncpy(kctl.id.name, ncontrol->name, sizeof(kctl.id.name)-1);
+	if (ncontrol->name)
+		strncpy(kctl.id.name, ncontrol->name, sizeof(kctl.id.name)-1);
 	kctl.id.index = ncontrol->index;
 	kctl.access = ncontrol->access == 0 ? SNDRV_CTL_ELEM_ACCESS_READWRITE :
 		      (ncontrol->access & (SNDRV_CTL_ELEM_ACCESS_READWRITE|SNDRV_CTL_ELEM_ACCESS_INACTIVE|SNDRV_CTL_ELEM_ACCESS_INDIRECT));



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
