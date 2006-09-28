From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: [PATCH] Reset file->f_op in snd_card_file_remove().
	Take 2
Date: Thu, 28 Sep 2006 22:28:02 +0200
Message-ID: <200609282228.02611.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Cc: mingo@elte.hu, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi

It oopses with 2.6.18-rt4 + alsa-kernel-1.0.13rc3 now.
I wrote before, 2.6.18-rt3 + alsa-driver-1.0.13rc3 would be ok,
but its not. bug showed again reliably under memory-pressure.

      Karsten

===

Reset file->f_op in snd_card_file_remove(). Take 2


i think what happens here is:

  us428control runs, kernel has allocated a struct file for /dev/hwC1D0.

  usb disconnect

  snd_usb_usx2y calls snd_card_disconnect,
  tells us428control to exit.

  snd_card_disconnect replaces /dev/hwC1D0's file->f_op
  with a kmalloc()ed version, that would only allow releases.

  us428control starts exiting

  __fput is called with struct file for /dev/hwC1D0.

  snd_card_file_remove() is called, alsa notices struct file
  for /dev/hwC1D0 is about to be closed.
  with patch below, file->f_op would be set NULL now.

  snd_usb_usx2y's free()s snd_card instance and /dev/hwC1D0's
  file->f_ops, those that would only allow releases.

  for reason I would like to know,
  __fput is called again with struct file for /dev/hwC1D0
  from us428control's do_exit().
  __fput see's file->f_op is still set.
  Without patch and under memory pressure, file->f_op can
  point to anything now.


Signed-off-by: Karsten Wiese <annabellesgarden@yahoo.de>


diff -pur ../alsa/1.0.13/alsa-driver-1.0.13rc3/alsa-kernel/core/init.c rt4-kw/sound/core/init.c
--- ../alsa/1.0.13/alsa-driver-1.0.13rc3/alsa-kernel/core/init.c	2006-09-25 15:33:19.000000000 +0200
+++ rt4-kw/sound/core/init.c	2006-09-28 18:48:15.000000000 +0200
@@ -707,6 +707,8 @@ int snd_card_file_remove(struct snd_card
 	mfile = card->files;
 	while (mfile) {
 		if (mfile->file == file) {
+			fops_put(file->f_op);
+			file->f_op = NULL;
 			if (pfile)
 				pfile->next = mfile->next;
 			else

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
