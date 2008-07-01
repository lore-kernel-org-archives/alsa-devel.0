From: Travis Place <wishie@wishie.net>
Subject: [PATCH] Add better checks for pastebin.ca availability
Date: Wed, 02 Jul 2008 00:52:14 +1000
Message-ID: <1214923934.16862.4.camel@temp-fallen>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-S0Npg3OnYWITWj5K+qqS"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www.wishie.net (202-137-100-135.dial.usertools.net
	[202.137.100.135])
	by alsa0.perex.cz (Postfix) with ESMTP id D4E9A243E2
	for <alsa-devel@alsa-project.org>;
	Tue,  1 Jul 2008 16:52:13 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


--=-S0Npg3OnYWITWj5K+qqS
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

At the moment, it seems that a) pastebin.ca (the host) is UP, and b) the
WEB SERVER on it is DOWN.

So ive implemented (even if messy) an extra check for this scenario.
I would consider using another pastebin service, but we have it pretty
good with slepp (the pastebin.ca owner) as he has allowed us to have our
own paste 'type' (which enables the areas to collapse, highlighting of
certain things, etc).

Changelog: Added an extra check to see if the Web Server is functioning
on our pastebin service. Now we check that the host is up, and the
webserver itself is alive.

Patch Attached.

Signed-off-by: Travis Place <wishie@wishie.net>

--=-S0Npg3OnYWITWj5K+qqS
Content-Disposition: attachment; filename=alsa-info.patch-0.4.49
Content-Type: text/x-patch; name=alsa-info.patch-0.4.49; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- alsa-info.sh	2008-07-02 00:43:36.000000000 +1000
+++ alsa-info.sh.wishie	2008-07-02 00:44:10.000000000 +1000
@@ -1,6 +1,6 @@
 #!/bin/bash
 
-SCRIPT_VERSION=0.4.48
+SCRIPT_VERSION=0.4.49
 CHANGELOG="http://www.alsa-project.org/alsa-info.sh.changelog"
 
 #################################################################################
@@ -32,8 +32,17 @@
 PASTEBINKEY="C9cRIO8m/9y8Cs0nVs0FraRx7U0pHsuc"
 #Define some simple functions
 
+pbweb(){
+[[ $(wget http://pastebin.ca/index.php &> /dev/null) ]] || KEEP_FILES="yes" NOUPLOAD="yes" PBERROR="yes" 
+}
+
 pbcheck(){
-	[[ $(ping -c1 www.pastebin.ca) ]] || KEEP_FILES="yes" NOUPLOAD="yes" PBERROR="yes"
+if [[ $(ping -c1 www.pastebin.ca) ]]
+then
+pbweb
+else
+KEEP_FILES="yes" NOUPLOAD="yes" PBERROR="yes"
+fi
 }
 
 update() {

--=-S0Npg3OnYWITWj5K+qqS
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-S0Npg3OnYWITWj5K+qqS--
