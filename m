From: =?iso-8859-1?q?karsten=20wiese?= <annabellesgarden@yahoo.de>
Subject: small enhancement to es1968.c
Date: Mon, 20 May 2002 22:38:17 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020520203817.10461.qmail@web12206.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

hallo,

this one lets the volume reach maximum on both
channels also by using the extra volume-control-knobs
found on some laptops. 
the diff was run against the cvs - version of today.

>>>>
--- es1968.c_cvs        Mon May 20 22:09:37 2002
+++ es1968.c    Mon May 20 22:12:11 2002
@@ -1981,7 +1981,7 @@
                        /* volume up */
                        if ((val & 0xff) > 0)
                                val--;
-                       if ((val & 0xff00) > 0x100)
+                       if ((val & 0xff00) > 0)
                                val -= 0x0100;
                } else {
                        /* volume down */
<<<<

best regards, karsten


__________________________________________________________________

Gesendet von Yahoo! Mail - http://mail.yahoo.de
Sie brauchen mehr Speicher für Ihre E-Mails? - http://premiummail.yahoo.de

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
