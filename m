From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] sound/isa/cs423x/cs4236.c: PnP ids for Netfinity 3000
Date: Fri, 20 Jan 2006 23:29:15 +0100
Message-ID: <20060120222914.GD31803__40334.898493211$1137796223$gmane$org@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailout.stusta.mhn.de (mailout.stusta.mhn.de [141.84.69.5])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 192BF183
	for <alsa-devel@alsa-project.org>; Fri, 20 Jan 2006 23:29:15 +0100 (MET)
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Lukasz Stemach <stelmacl@ee.pw.edu.pl>
List-Id: alsa-devel@alsa-project.org

From: Lukasz Stemach <stelmacl@ee.pw.edu.pl>


PnP ids for Netfinity 3000 builtin soundcard.

This one works for me.


This patch was submitted through kernel Bugzilla #4214.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- l/sound/isa/cs423x/cs4236.c.orig	2004-10-23 10:54:33.000000000 +0200
+++ l/sound/isa/cs423x/cs4236.c	2004-12-27 01:01:31.000000000 +0100
@@ -174,6 +173,8 @@
 	{ .id = "CSC7632", .devs = { { "CSC0000" }, { "CSC0010" }, { "PNPb006" } } },
 	/* SIC CrystalWave 32 (CS4232) */
 	{ .id = "CSCf032", .devs = { { "CSC0000" }, { "CSC0010" }, { "CSC0003" } } },
+	/* Netfinity 3000 on-board soundcard */
+	{ .id = "CSCe825", .devs = { { "CSC0100" }, { "CSC0110" }, { "CSC010f" } } },
 	/* --- */
 	{ .id = "" }	/* end */
 };



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
