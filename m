From: Travis Place <wishie@wishie.net>
Subject: [PATCH] Problem with latest alsa-info.sh patch
Date: Mon, 18 Aug 2008 05:13:10 +1000
Message-ID: <200808180513.10599.wishie@wishie.net>
References: <200808170538.59670.wishie@wishie.net>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_GhHqIxbKhVlCh0W"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www.wishie.net (202-137-100-224.dial.usertools.net
	[202.137.100.224])
	by alsa0.perex.cz (Postfix) with ESMTP id 85FF72438E
	for <alsa-devel@alsa-project.org>;
	Sun, 17 Aug 2008 21:13:16 +0200 (CEST)
Received: from laptop.local (unknown [192.168.0.200])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.wishie.net (Postfix) with ESMTP id 590445B6EB
	for <alsa-devel@alsa-project.org>; Sun, 17 Aug 2008 19:37:23 +1000 (EST)
In-Reply-To: <200808170538.59670.wishie@wishie.net>
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

--Boundary-00=_GhHqIxbKhVlCh0W
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Ok, so the deal is, with the new --pastebin argument, the script wasnt running 
as if '--with-all' was specified. Ive included a quick patch to remedy this 
situation, and make the pastebin output work as it should.

Bumped the version number up, so existing users get the update.

Changelog: Fixed the output uploaded to pastebin.ca (when using --pastebin).

Signed-Off-By: Travis Place <wishie@wishie.net>


On Sunday 17 August 2008 5:38:59 am Travis Place wrote:
> The latest patch to allow the uploading to alsa-project.org seems to work
> fine, for the most part, unless you want to use the --pastebin option for
> the legacy upload to pastebin.ca . It seems that the uploaded data gets
> truncated. Not sure if this is the script, or the pastebin having problems.
> Ill look into it a bit more when i have time (its 5:30am here, and i need
> sleep).
>
> Just thought id point this out. I realise the 'default' behaviour is to use
> alsa-project.org for uploading, but i feel the other pastebin.ca mode
> should still function(I personally get people to upload there first, and
> then 'submit' card details to alsa-project.org/db/ afterwards.
>
> Thanks,
> Travis Place (wishie)
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel



--Boundary-00=_GhHqIxbKhVlCh0W
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="alsa-info.sh_0.4.50.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="alsa-info.sh_0.4.50.patch"

--- alsa-info.sh	2008-08-18 05:08:50.000000000 +1000
+++ alsa-info.sh.fixed	2008-08-18 05:09:17.000000000 +1000
@@ -1,6 +1,6 @@
 #!/bin/bash
 
-SCRIPT_VERSION=0.4.49
+SCRIPT_VERSION=0.4.50
 CHANGELOG="http://www.alsa-project.org/alsa-info.sh.changelog"
 
 #################################################################################
@@ -434,6 +434,14 @@
 	do
 	case "$1" in
 		--pastebin)
+		        update
+        		withdevices
+        		withconfigs
+        		withaplay
+        		withamixer
+        		withalsactl
+        		withlsmod
+        		pbcheck
 			;;
 		--update)
 			update

--Boundary-00=_GhHqIxbKhVlCh0W
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_GhHqIxbKhVlCh0W--
