From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] unused code in rawmidi.c
Date: Thu, 07 Nov 2002 13:16:39 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0211071311490.14494-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
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


SNDRV_RAWMIDI_IOCTL_PARAMS doesn't return data, and err isn't initialized.
But the code wasn't used anyway ...


--- alsa-kernold/core/rawmidi.c	Thu Nov 07 11:56:06 2002
+++ alsa-kernel/core/rawmidi.c	Thu Nov 07 12:07:37 2002
@@ -699,7 +699,6 @@
 	case SNDRV_RAWMIDI_IOCTL_PARAMS:
 	{
 		snd_rawmidi_params_t params;
-		int err;
 		if (copy_from_user(&params, (snd_rawmidi_params_t *) arg, sizeof(snd_rawmidi_params_t)))
 			return -EFAULT;
 		switch (params.stream) {
@@ -714,9 +713,6 @@
 		default:
 			return -EINVAL;
 		}
-		if (copy_to_user((snd_rawmidi_params_t *) arg, &params, sizeof(snd_rawmidi_params_t)))
-			return -EFAULT;
-		return err;
 	}
 	case SNDRV_RAWMIDI_IOCTL_STATUS:
 	{



-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
