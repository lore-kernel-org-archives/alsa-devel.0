From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [RFC PATCH] alsactl: Do not run udev rule before
	datadir is mounted
Date: Fri, 13 Jun 2014 11:33:00 +0200
Message-ID: <539AC54C.60504@canonical.com>
References: <1402647348-25604-1-git-send-email-david.henningsson@canonical.com>	<539AB5C7.6020501@perex.cz>	<539ABEF0.7020508@canonical.com>
 <s5hfvj9go7w.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060700020709040408080500"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B0DB2619D7
 for <alsa-devel@alsa-project.org>; Fri, 13 Jun 2014 11:32:59 +0200 (CEST)
In-Reply-To: <s5hfvj9go7w.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: 1289730@bugs.launchpad.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------060700020709040408080500
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



On 2014-06-13 11:20, Takashi Iwai wrote:

>> +++ b/alsactl/90-alsa-restore.rules.in
>> @@ -1,4 +1,4 @@
>> -ACTION=="add", SUBSYSTEM=="sound", KERNEL=="controlC*", KERNELS!="card*", GOTO="alsa_restore_go"
>> +ACTION=="add", SUBSYSTEM=="sound", KERNEL=="controlC*", KERNELS!="card*", TEST=="@sbindir@", TEST=="@datadir@", GOTO="alsa_restore_go"
>>   GOTO="alsa_restore_end"
>
> IMO, it's better to use @mydatadir@ instead of @datadir@ here and...

Oops, sorry about that. Thanks for the review!

Attaching a fixup patch.

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic

--------------060700020709040408080500
Content-Type: text/x-patch;
 name="0001-alsactl-Fixup-test-for-mydatadir-sbindir.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-alsactl-Fixup-test-for-mydatadir-sbindir.patch"

>From 7402d0421df6782dd7af9a30f3bc1223057cd9f3 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Fri, 13 Jun 2014 11:31:44 +0200
Subject: [PATCH] alsactl: Fixup test for mydatadir/sbindir

Use the "mydatadir" name consistently.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 alsactl/90-alsa-restore.rules.in | 2 +-
 alsactl/Makefile.am              | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/alsactl/90-alsa-restore.rules.in b/alsactl/90-alsa-restore.rules.in
index 80fc043..c0c1b23 100644
--- a/alsactl/90-alsa-restore.rules.in
+++ b/alsactl/90-alsa-restore.rules.in
@@ -1,4 +1,4 @@
-ACTION=="add", SUBSYSTEM=="sound", KERNEL=="controlC*", KERNELS!="card*", TEST=="@sbindir@", TEST=="@datadir@", GOTO="alsa_restore_go"
+ACTION=="add", SUBSYSTEM=="sound", KERNEL=="controlC*", KERNELS!="card*", TEST=="@sbindir@", TEST=="@mydatadir@", GOTO="alsa_restore_go"
 GOTO="alsa_restore_end"
 
 LABEL="alsa_restore_go"
diff --git a/alsactl/Makefile.am b/alsactl/Makefile.am
index afbedb3..47f06e9 100644
--- a/alsactl/Makefile.am
+++ b/alsactl/Makefile.am
@@ -44,7 +44,7 @@ endif
 
 edit = \
 	$(SED) -r -e 's,@sbindir\@,$(sbindir),g' \
-		  -e 's,@datadir\@,$(mydatadir),g' \
+		  -e 's,@mydatadir\@,$(mydatadir),g' \
 		  -e 's,@daemonswitch\@,$(ALSACTL_DAEMONSWITCH),g' \
 							< $< > $@ || rm $@
 
-- 
1.9.1


--------------060700020709040408080500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------060700020709040408080500--
