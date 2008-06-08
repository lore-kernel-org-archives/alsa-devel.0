From: Travis Place <wishie@wishie.net>
Subject: Problems regarding alsa-info.sh
Date: Mon, 09 Jun 2008 00:19:41 +1000
Message-ID: <1212934781.554.6.camel@temp-fallen>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-+PSBh1CjrZKpqqe1WphG"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wishie.net (202-137-100-089.dial.usertools.net [202.137.100.89])
	by alsa0.perex.cz (Postfix) with ESMTP id A691F10384F
	for <alsa-devel@alsa-project.org>;
	Sun,  8 Jun 2008 16:19:33 +0200 (CEST)
Received: from [192.168.0.7] (unknown [192.168.0.200])
	by wishie.net (Postfix) with ESMTP id 10CA76AD52
	for <alsa-devel@alsa-project.org>; Sun,  8 Jun 2008 14:40:48 +1000 (EST)
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
List-Id: alsa-devel@alsa-project.org


--=-+PSBh1CjrZKpqqe1WphG
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Since the move from HG->GIT there is now a new download location for
alsa-info.sh . There are 2 current problems with this though..

1) The new URL is very ugly(and hard to post on wikis etc)
The new link is
http://git.alsa-project.org/?p=alsa-driver.git;a=blob_plain;f=utils/alsa-info.sh

2) The current script version at HG repo (which is where people
currently get it from, is an outdated version, that checks the HG repo
for updates to the script.

We need to put the new version of the script into HG (if its still
accessible), with the updated 'update' URL, or, somehow redirect from
the old URL to the new URL.

Please let me know what should be done about this, and how to go about
fixing it.

Attached is the updated alsa-info.sh with the new GIT URLS (update and
changelog) in place.



--=-+PSBh1CjrZKpqqe1WphG
Content-Disposition: attachment; filename=alsa-info-0.4.46.patch
Content-Type: text/x-patch; name=alsa-info-0.4.46.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- alsa-info.sh.git	2008-06-09 00:16:19.000000000 +1000
+++ alsa-info.sh.fixed	2008-06-09 00:18:03.000000000 +1000
@@ -1,7 +1,7 @@
 #!/bin/bash
 
-SCRIPT_VERSION=0.4.45
-CHANGELOG="http://hg.alsa-project.org/alsa/log/tip/alsa-info.sh"
+SCRIPT_VERSION=0.4.46
+CHANGELOG="http://git.alsa-project.org/?p=alsa-driver.git;a=history;f=utils/alsa-info.sh"
 
 #################################################################################
 #Copyright (C) 2007 Free Software Foundation.
@@ -37,7 +37,7 @@
 }
 
 update() {
-	wget -O /tmp/alsa-info.sh http://hg.alsa-project.org/alsa/raw-file/tip/alsa-info.sh >/dev/null 2>&1
+	wget -O /tmp/alsa-info.sh "http://git.alsa-project.org/?p=alsa-driver.git;a=blob_plain;f=utils/alsa-info.sh" >/dev/null 2>&1
 	REMOTE_VERSION=`grep SCRIPT_VERSION /tmp/alsa-info.sh |head -n1 |sed 's/.*=//'`
 	if [ "$REMOTE_VERSION" != "$SCRIPT_VERSION" ]; then
 		if [[ -n $DIALOG ]]

--=-+PSBh1CjrZKpqqe1WphG
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-+PSBh1CjrZKpqqe1WphG--
