From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: [PATCH] Reset file->f_op in snd_card_file_remove()
Date: Wed, 27 Sep 2006 21:27:51 +0200
Message-ID: <200609272127.51980.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0101093944=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>, mingo@elte.hu
Cc: alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

--===============0101093944==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi

This patch helps prevent an oops on 2.6.18-rt3,
when my usb usx2y soundcard disconnects.
Physically disconnects or "rmmod uhci_hc" both oops 1in7.

With this patch still no oops after > 1000 disconnects.

Please apply/comment.

      thanks,
      Karsten

===

Reset file->f_op in snd_card_file_remove()

When passing here in response to an usb disconnect,
file->f_op has been replaced with a kmalloc()ed version,
that would only allow releases.

It will be free()ed later on in snd_card_free().
Here it happened sometimes, that the free()ed, not NULLed file->f_op
caused an oops in module_put() called by fops_put() still later on.

Signed-off-by: Karsten Wiese <annabellesgarden@yahoo.de>



--- rt3/sound/core/init.c	2006-09-23 20:03:18.000000000 +0200
+++ rt3-kw/sound/core/init.c	2006-09-27 20:44:54.000000000 +0200
@@ -722,6 +722,7 @@ int snd_card_file_remove(struct snd_card
 	mfile = card->files;
 	while (mfile) {
 		if (mfile->file == file) {
+			file->f_op = NULL;
 			if (pfile)
 				pfile->next = mfile->next;
 			else

	

	
		
___________________________________________________________ 
Der frühe Vogel fängt den Wurm. Hier gelangen Sie zum neuen Yahoo! Mail: http://mail.yahoo.de



--===============0101093944==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0101093944==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0101093944==--
