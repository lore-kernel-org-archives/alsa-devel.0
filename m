From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: [PATCHES] Integrate minimal systemd support in
	alsa-utils
Date: Thu, 25 Nov 2010 21:45:46 +0000
Message-ID: <4CEED90A.7020307@colin.guthr.ie>
References: <20101123021657.GA17275@tango.0pointer.de>	<icjjig$3ft$1@dough.gmane.org>
	<20101124194736.GD27878@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050704060108030906000201"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 7BC94103C6D
	for <alsa-devel@alsa-project.org>; Thu, 25 Nov 2010 22:46:05 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1PLjdh-00052H-7S
	for alsa-devel@alsa-project.org; Thu, 25 Nov 2010 22:46:01 +0100
Received: from cpc1-sgyl30-2-0-cust258.sgyl.cable.virginmedia.com
	([94.173.13.3]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 25 Nov 2010 22:46:01 +0100
Received: from gmane by cpc1-sgyl30-2-0-cust258.sgyl.cable.virginmedia.com
	with local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 25 Nov 2010 22:46:01 +0100
In-Reply-To: <20101124194736.GD27878@tango.0pointer.de>
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
--------------050704060108030906000201
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

'Twas brillig, and Lennart Poettering at 24/11/10 19:47 did gyre and gimble:
> On Wed, 24.11.10 17:55, Colin Guthrie (gmane@colin.guthr.ie) wrote:
> 
>>
>> 'Twas brillig, and Lennart Poettering at 23/11/10 02:16 did gyre and gimble:
>>> +udevrulesdir=/lib/udev/rules.d
>>> +
>>
>> This doesn't appear to be used unless I missed something?
>>
>> If it were used, I'd rather make this configurable. Obviously udev
>> pretty much mandates this path but it's a PITA when doing non-root make
>> installs to custom prefixes when it's hard coded like this. But like I
>> say, this looks unused here...
> 
> Well, it still honours $(DESTDIR) logic.

Yeah but it's still a PITA for self-builds and (I'm told from Arun) some
Gentoo stuff too.

Anyway, I've attached an entirely uncontroversial patch that fixes up
any issues for those that care. Same as an earlier commit from last year
in PulseAudio by Arun Raghavan.


> It's referenced by the dist_udevrules_DATA= stanza.

Ahh OK, I don't really grok auto* foo, but I can spot some pixie dust
there that kinda makes sense :)

Cheers

Col

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

--------------050704060108030906000201
Content-Type: text/x-patch;
 name="0001-alsactl-Add-a-with-udev-rules-dir-configure-option.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-alsactl-Add-a-with-udev-rules-dir-configure-option.patc";
 filename*1="h"

>From aee9d692defc05f2599363f0456cc837c3ef9a05 Mon Sep 17 00:00:00 2001
From: Colin Guthrie <cguthrie@mandriva.org>
Date: Thu, 25 Nov 2010 21:40:25 +0000
Subject: [PATCH] alsactl: Add a --with-udev-rules-dir configure option.

After the previous patch to install udev rules it is impossible to do a
non-root, custom-prefix make install. This is generally not a problem
when building official packages but it can be a pain for developers
and debuggers etc.

This is essentially the same patch as was already made in PulseAudio
in commit e8a5746f2fcae59bfd18d39b621509b3ef130453.
---
 alsactl/Makefile.am |    2 --
 configure.in        |    6 ++++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/alsactl/Makefile.am b/alsactl/Makefile.am
index 721b619..5cfc415 100644
--- a/alsactl/Makefile.am
+++ b/alsactl/Makefile.am
@@ -11,8 +11,6 @@ alsactl_SOURCES=alsactl.c state.c utils.c init_parse.c
 alsactl_CFLAGS=$(AM_CFLAGS) -DSYS_ASOUNDRC=\"$(ASOUND_STATE_DIR)/asound.state\"
 noinst_HEADERS=alsactl.h list.h init_sysdeps.c init_utils_string.c init_utils_run.c init_sysfs.c
 
-udevrulesdir=/lib/udev/rules.d
-
 dist_udevrules_DATA = \
 	90-alsa-restore.rules
 
diff --git a/configure.in b/configure.in
index 94a2b17..5b3491d 100644
--- a/configure.in
+++ b/configure.in
@@ -112,6 +112,12 @@ if test x"$alsaconf" = xtrue; then
 fi
 AM_CONDITIONAL(USE_XMLTO, test x"$xmlto" = xyes)
 
+AC_ARG_WITH(
+        [udev-rules-dir],
+        AS_HELP_STRING([--with-udev-rules-dir],[Directory where to install udev rules to (defaults to /lib/udev/rules.d)]),
+        [udevrulesdir=$withval], [udevrulesdir="/lib/udev/rules.d"])
+AC_SUBST(udevrulesdir)
+
 dnl Checks for header files.
 AC_HEADER_STDC
 if test x$alsamixer = xtrue; then
-- 
1.7.3.2


--------------050704060108030906000201
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------050704060108030906000201--
