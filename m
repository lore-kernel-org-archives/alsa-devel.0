From: "Timofei V. Bondarenko" <tim@ipi.ac.ru>
Subject: [Patch] _snd_cmipci_uswitch_put doesn't set zero flags
Date: Wed, 20 Dec 2006 19:09:24 +0300
Message-ID: <45896034.8030705@ipi.ac.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030009010607070303090901"
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------030009010607070303090901
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi.

Playing with spdif output on cmipci i've noticed the SPDO5V option does 
not change appropriate bits the register.

The _snd_cmipci_uswitch_put checks the change in flags in wrong way.
If 'active' state of an option corresponds to a _zero_ bits in a hw 
register then function fails. The SPDO5V is the sample.
In the most cases 'active' state of option is set through an non-zerio 
bits in a register. This case works fine.

The fix attached.
Unfortunately i was unable to change spdif output voltage anyway.
Although the register changes right at least.

Regards.
	Tim.

--------------030009010607070303090901
Content-Type: text/x-patch;
 name="cmipci.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cmipci.diff"

--- pci/cmipci.c.old	2006-12-07 17:07:25.000000000 +0300
+++ pci/cmipci.c	2006-12-20 18:18:01.000000000 +0300
@@ -2198,7 +2198,8 @@ static int _snd_cmipci_uswitch_put(struc
 		val = inb(cm->iobase + args->reg);
 	else
 		val = snd_cmipci_read(cm, args->reg);
-	change = (val & args->mask) != (ucontrol->value.integer.value[0] ? args->mask : 0);
+	change = (val & args->mask) != (ucontrol->value.integer.value[0] ? 
+			args->mask_on : (args->mask & ~args->mask_on));
 	if (change) {
 		val &= ~args->mask;
 		if (ucontrol->value.integer.value[0])

--------------030009010607070303090901
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------030009010607070303090901
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--------------030009010607070303090901--
