From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: [PATCH] alsa-driver git repo: Build problems when
 copying symlink to itself
Date: Sat, 12 Mar 2011 10:30:48 +0000
Message-ID: <ilfi0p$7hr$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060405030201020509050606"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id B6DF11037EA
	for <alsa-devel@alsa-project.org>; Sat, 12 Mar 2011 11:31:05 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1PyM6A-0006AE-QM
	for alsa-devel@alsa-project.org; Sat, 12 Mar 2011 11:31:02 +0100
Received: from cpc1-sgyl30-2-0-cust258.sgyl.cable.virginmedia.com
	([94.173.13.3]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sat, 12 Mar 2011 11:31:02 +0100
Received: from gmane by cpc1-sgyl30-2-0-cust258.sgyl.cable.virginmedia.com
	with local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sat, 12 Mar 2011 11:31:02 +0100
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

This is a multi-part message in MIME format.
--------------060405030201020509050606
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

After doing a "simple":
git clone alsa-driver
git clone alsa-kernel
cd alsa-driver
./gitcompile --with-debug=full --with-isapnp=yes --with-sequencer=yes
--with-moddir=updates/alsa:

The build bombed out pretty quickly with the following error.

The attached patch fixes it.

Hacking autoconf.h...
make[1]: Entering directory
`/home/colin/Development/Personal/ALSA/alsa-driver/include'
make -C sound prepare
make[2]: Entering directory
`/home/colin/Development/Personal/ALSA/alsa-driver/include/sound'
make prepare2
make[3]: Entering directory
`/home/colin/Development/Personal/ALSA/alsa-driver/include/sound'
cp ../../alsa-kernel/include/ac97_codec.h .
patch -p0 -i ac97_codec.patch ac97_codec.h
patching file ac97_codec.h
Hunk #1 succeeded at 650 (offset 5 lines).
cp ../../alsa-kernel/include/core.h .
patch -p0 -i core.patch core.h
patching file core.h
cp ../../alsa-kernel/include/info.h .
cp: `../../alsa-kernel/include/info.h' and `./info.h' are the same file
make[3]: *** [info.h] Error 1
make[3]: Leaving directory
`/home/colin/Development/Personal/ALSA/alsa-driver/include/sound'
make[2]: *** [prepare] Error 2
make[2]: Leaving directory
`/home/colin/Development/Personal/ALSA/alsa-driver/include/sound'
make[1]: *** [prepare] Error 2
make[1]: Leaving directory
`/home/colin/Development/Personal/ALSA/alsa-driver/include'
make: *** [dep] Error 1

-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited [http://www.tribalogic.net/]
Open Source:
  Mageia Contributor [http://www.mageia.org/]
  PulseAudio Hacker [http://www.pulseaudio.org/]
  Trac Hacker [http://trac.edgewall.org/]

--------------060405030201020509050606
Content-Type: text/x-patch;
 name="0001-Fix-broken-build-due-to-cp-symlink-behaviour.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-Fix-broken-build-due-to-cp-symlink-behaviour.patch"

>From c8d828633824d1dc9eb1739c676fb1a8b961c523 Mon Sep 17 00:00:00 2001
From: Colin Guthrie <cguthrie@mandriva.org>
Date: Sat, 12 Mar 2011 10:28:38 +0000
Subject: [PATCH] Fix broken build due to cp+symlink behaviour

Sometimes the destination file is a symlink to the source file.
If this happens cp may complain:
 cp: ./info.h' are the same file

This patch just adds a safety rm -f before hand which wont do any harm.
---
 include/sound/Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/sound/Makefile b/include/sound/Makefile
index 4f3c782..f992c01 100644
--- a/include/sound/Makefile
+++ b/include/sound/Makefile
@@ -27,6 +27,7 @@ version.h: ../version.h
 		b=$$(basename $$s .h); \
 		if test -f $$b.patch; then \
 			echo "$$s: $$i $$b.patch" >> $@; \
+			echo "	rm -f \$$@" >> $@; \
 			echo "	cp \$$(INCSRC)/\$$@ ." >> $@; \
 			echo "	patch -p0 -i $$b.patch \$$@" >> $@; \
 			echo >> $@; \
-- 
1.7.4.1


--------------060405030201020509050606
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------060405030201020509050606--
