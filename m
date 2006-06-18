From: karsten wiese <annabellesgarden@yahoo.de>
Subject: [PATCH] Default to variable samplerate enabled for MSI
	K8T Neo2-FI
Date: Sun, 18 Jun 2006 14:24:51 +0200 (CEST)
Message-ID: <20060618122451.72075.qmail@web26509.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-18643206-1150633491=:72064"
Content-Transfer-Encoding: 7bit
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
To: Takashi Iwai <tiwai@suse.de>
Cc: Devel Alsa <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

--0-18643206-1150633491=:72064
Content-Type: text/plain; charset=iso-8859-1
Content-Id: 
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

please apply.

Thanks, Karsten


=09

=09
	=09
___________________________________________________________=20
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmeld=
en: http://mail.yahoo.de
--0-18643206-1150633491=:72064
Content-Type: text/x-diff; name="enable_VIA_DXS_SRC_on_MSI K8T Neo2-FI.patch"
Content-Description: 3667490657-enable_VIA_DXS_SRC_on_MSI K8T Neo2-FI.patch
Content-Disposition: inline;
	filename="enable_VIA_DXS_SRC_on_MSI K8T Neo2-FI.patch"

Default to variable samplerate enabled for MSI K8T Neo2-FI

No crackles here with 44100.

Signed-off-by: Karsten Wiese <annabellesgarden@yahoo.de>


--- /tmp/via82xx.c~	2006-06-18 14:11:59.000000000 +0200
+++ /tmp/via82xx.c	2006-06-18 14:11:59.000000000 +0200
@@ -2356,7 +2356,7 @@
 		{ .subvendor = 0x1462, .subdevice = 0x0470, .action = VIA_DXS_SRC }, /* MSI KT880 Delta-FSR */
 		{ .subvendor = 0x1462, .subdevice = 0x3800, .action = VIA_DXS_ENABLE }, /* MSI KT266 */
 		{ .subvendor = 0x1462, .subdevice = 0x5901, .action = VIA_DXS_NO_VRA }, /* MSI KT6 Delta-SR */
-		{ .subvendor = 0x1462, .subdevice = 0x7023, .action = VIA_DXS_NO_VRA }, /* MSI K8T Neo2-FI */
+		{ .subvendor = 0x1462, .subdevice = 0x7023, .action = VIA_DXS_SRC }, /* MSI K8T Neo2-FI */
 		{ .subvendor = 0x1462, .subdevice = 0x7120, .action = VIA_DXS_ENABLE }, /* MSI KT4V */
 		{ .subvendor = 0x1462, .subdevice = 0x7142, .action = VIA_DXS_ENABLE }, /* MSI K8MM-V */
 		{ .subvendor = 0x1462, .subdevice = 0xb012, .action = VIA_DXS_SRC }, /* P4M800/VIA8237R */

--0-18643206-1150633491=:72064
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0-18643206-1150633491=:72064
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--0-18643206-1150633491=:72064--
