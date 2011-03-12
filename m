From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: [PATCH] alsa-driver git repo: Build problems when
 copying symlink to itself
Date: Sat, 12 Mar 2011 10:47:55 +0000
Message-ID: <ilfj0r$bls$1@dough.gmane.org>
References: <ilfi0p$7hr$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020400050902000603050300"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id D73A0103806
	for <alsa-devel@alsa-project.org>; Sat, 12 Mar 2011 11:48:15 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1PyMMm-0003kn-85
	for alsa-devel@alsa-project.org; Sat, 12 Mar 2011 11:48:12 +0100
Received: from cpc1-sgyl30-2-0-cust258.sgyl.cable.virginmedia.com
	([94.173.13.3]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sat, 12 Mar 2011 11:48:12 +0100
Received: from gmane by cpc1-sgyl30-2-0-cust258.sgyl.cable.virginmedia.com
	with local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sat, 12 Mar 2011 11:48:12 +0100
In-Reply-To: <ilfi0p$7hr$1@dough.gmane.org>
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
--------------020400050902000603050300
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

'Twas brillig, and Colin Guthrie at 12/03/11 10:30 did gyre and gimble:
> Hi,
> 
> After doing a "simple":
> git clone alsa-driver
> git clone alsa-kernel
> cd alsa-driver
> ./gitcompile --with-debug=full --with-isapnp=yes --with-sequencer=yes
> --with-moddir=updates/alsa:
> 
> The build bombed out pretty quickly with the following error.
> 
> The attached patch fixes it.

And here is another error I stumbled on. The attached patch fixes this.

Hacking autoconf.h...
make[1]: Entering directory
`/home/colin/Development/Personal/ALSA/alsa-driver/include'
make -C sound prepare
make[2]: Entering directory
`/home/colin/Development/Personal/ALSA/alsa-driver/include/sound'
make prepare2
make[3]: Entering directory
`/home/colin/Development/Personal/ALSA/alsa-driver/include/sound'
ln -s ../../alsa-kernel/include/alc5623.h
ln: failed to create symbolic link `./alc5623.h': File exists
make[3]: *** [alc5623.h] Error 1
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

--------------020400050902000603050300
Content-Type: text/x-patch;
 name="0001-Ensure-the-destination-of-the-symlink-doesn-t-yet-ex.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Ensure-the-destination-of-the-symlink-doesn-t-yet-ex.pa";
 filename*1="tch"

>From d7b95b81a62faeab1e565946d91e4771b8128ce0 Mon Sep 17 00:00:00 2001
From: Colin Guthrie <cguthrie@mandriva.org>
Date: Sat, 12 Mar 2011 10:46:39 +0000
Subject: [PATCH] Ensure the destination of the symlink doesn't yet exists.

Similar to my last patch, the symlinking process can also fail due to the
destination file already being present. This ensures we wipe the file first.
---
 include/sound/Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/sound/Makefile b/include/sound/Makefile
index f992c01..0e09df4 100644
--- a/include/sound/Makefile
+++ b/include/sound/Makefile
@@ -16,6 +16,7 @@ version.h: ../version.h
 	patch -p0 -i $< $@
 
 %.h:
+	rm -f $@
 	ln -s $(INCSRC)/$@
 
 .includes.tmp:
-- 
1.7.4.1


--------------020400050902000603050300
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------020400050902000603050300--
