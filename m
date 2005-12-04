From: Andreas Schwab <schwab@suse.de>
Subject: Fix missing declarations
Date: Sun, 04 Dec 2005 14:19:43 +0100
Message-ID: <jepsodyp74.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mx2.suse.de (ns2.suse.de [195.135.220.15])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E185516D
	for <alsa-devel@alsa-project.org>; Sun,  4 Dec 2005 14:19:51 +0100 (MET)
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 4AC241CC33
	for <alsa-devel@alsa-project.org>; Sun,  4 Dec 2005 14:19:45 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

sound/pci/emu10k1/emufx.c: In function 'snd_emu10k1_efx_alloc_pm_buffer':
sound/pci/emu10k1/emufx.c:2402: error: implicit declaration of function '=
vmalloc'
sound/pci/emu10k1/emufx.c:2402: warning: assignment makes pointer from in=
teger without a cast
sound/pci/emu10k1/emufx.c: In function 'snd_emu10k1_efx_free_pm_buffer':
sound/pci/emu10k1/emufx.c:2413: error: implicit declaration of function '=
vfree'

Signed-off-by: Andreas Schwab <schwab@suse.de>

Index: linux/sound/pci/emu10k1/emufx.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux/sound/pci/emu10k1/emufx.c	2005-12-04 13:29:12.247722913 +0100
+++ linux/sound/pci/emu10k1/emufx.c	2005-12-04 13:35:03.971435580 +0100
@@ -29,6 +29,7 @@
 #include <linux/pci.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
+#include <linux/vmalloc.h>
 #include <linux/init.h>
 #include <sound/core.h>
 #include <sound/emu10k1.h>
Index: linux/sound/pci/emu10k1/p16v.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux/sound/pci/emu10k1/p16v.c	2005-12-04 13:29:12.271722893 +0100
+++ linux/sound/pci/emu10k1/p16v.c	2005-12-04 13:34:52.671444672 +0100
@@ -93,6 +93,7 @@
 #include <linux/interrupt.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
+#include <linux/vmalloc.h>
 #include <linux/moduleparam.h>
 #include <sound/core.h>
 #include <sound/initval.h>

Andreas.

--=20
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstra=DFe 5, 90409 N=FCrnberg, Germany
PGP key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED=
5
"And now for something completely different."


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
