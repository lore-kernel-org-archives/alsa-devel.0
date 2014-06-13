From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [RFC PATCH] alsactl: Do not run udev rule before
	datadir is mounted
Date: Fri, 13 Jun 2014 11:05:52 +0200
Message-ID: <539ABEF0.7020508@canonical.com>
References: <1402647348-25604-1-git-send-email-david.henningsson@canonical.com>
 <539AB5C7.6020501@perex.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000507030500050106010205"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id DB2C7261A8C
 for <alsa-devel@alsa-project.org>; Fri, 13 Jun 2014 11:05:50 +0200 (CEST)
In-Reply-To: <539AB5C7.6020501@perex.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, tiwai@suse.de, alsa-devel@alsa-project.org
Cc: 1289730@bugs.launchpad.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------000507030500050106010205
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2014-06-13 10:26, Jaroslav Kysela wrote:
> Date 13.6.2014 10:15, David Henningsson wrote:
>> The 90-alsa-restore.rules udev rule is primarily meant to handle hotplugging,
>> but sometimes it is also run before /usr is mounted,
>> and alsactl restore depends on /usr/share/alsa being present.
>>
>> If /usr/share/alsa is not present, we're so early in the boot
>> process that alsa-restore.service (or upstart equivalent) will
>> run later on.
>>
>> BugLink: https://bugs.launchpad.net/bugs/1289730
>> Signed-off-by: David Henningsson <david.henningsson@canonical.com>
>> ---
>>
>> I'm not really sure of all quirks in the boot process, and I haven't tested the
>> patch either, hence the RFC above. Do you think it makes sense?
>
> Yes, I think that's ok. Takashi?
>
>> Should we also add @sbindir@ to the things to test for?
>
> It shouldn't harm anything. Could you prepare a new patch?

Sure, please find it attached. I was also considering adding something 
under /var as well, but I didn't do that, because I think it will fall 
back to an "alsactl init" in that case (right?), so it still makes some 
sense to run alsactl without /var.

>
>>   alsactl/90-alsa-restore.rules.in | 2 +-
>>   alsactl/Makefile.am              | 1 +
>>   configure.ac                     | 1 +
>>   3 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/alsactl/90-alsa-restore.rules.in b/alsactl/90-alsa-restore.rules.in
>> index c68119d..c83c6b5 100644
>> --- a/alsactl/90-alsa-restore.rules.in
>> +++ b/alsactl/90-alsa-restore.rules.in
>> @@ -1,4 +1,4 @@
>> -ACTION=="add", SUBSYSTEM=="sound", KERNEL=="controlC*", KERNELS!="card*", GOTO="alsa_restore_go"
>> +ACTION=="add", SUBSYSTEM=="sound", KERNEL=="controlC*", KERNELS!="card*", TEST=="@datadir@", GOTO="alsa_restore_go"
>>   GOTO="alsa_restore_end"
>>
>>   LABEL="alsa_restore_go"
>> diff --git a/alsactl/Makefile.am b/alsactl/Makefile.am
>> index b862412..afbedb3 100644
>> --- a/alsactl/Makefile.am
>> +++ b/alsactl/Makefile.am
>> @@ -44,6 +44,7 @@ endif
>>
>>   edit = \
>>   	$(SED) -r -e 's,@sbindir\@,$(sbindir),g' \
>> +		  -e 's,@datadir\@,$(mydatadir),g' \
>>   		  -e 's,@daemonswitch\@,$(ALSACTL_DAEMONSWITCH),g' \
>>   							< $< > $@ || rm $@
>>
>> diff --git a/configure.ac b/configure.ac
>> index 7e6894a..a4d2db3 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -292,6 +292,7 @@ AC_DEFINE_UNQUOTED(SOUNDSDIR, "$soundsdir", [directory containing sample data])
>>
>>   mydatadir="$dir/alsa"
>>   AC_DEFINE_UNQUOTED(DATADIR, "$mydatadir", [directory containing alsa configuration])
>> +AC_SUBST(mydatadir)
>>
>>   AC_ARG_WITH(testsound,
>>     AS_HELP_STRING([--with-testsound=file], [give the path of test sound file for alsaconf]),
>>
>
>

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic

--------------000507030500050106010205
Content-Type: text/x-patch;
 name="0001-alsactl-Do-not-run-udev-rule-before-datadir-sbindir-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-alsactl-Do-not-run-udev-rule-before-datadir-sbindir-.pa";
 filename*1="tch"

>From 09a4abb5560448eb434a33fc237d578e14666940 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Fri, 13 Jun 2014 10:04:25 +0200
Subject: [PATCH] alsactl: Do not run udev rule before datadir/sbindir are both
 mounted

Sometimes 90-alsa-restore.rules is run before /usr is mounted,
and alsactl restore depends on /usr/share/alsa being present.

If /usr/share/alsa is not present, we're so early in the boot
process that alsa-restore.service (or upstart equivalent) will
run later on.

BugLink: https://bugs.launchpad.net/bugs/1289730
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 alsactl/90-alsa-restore.rules.in | 2 +-
 alsactl/Makefile.am              | 1 +
 configure.ac                     | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/alsactl/90-alsa-restore.rules.in b/alsactl/90-alsa-restore.rules.in
index c68119d..80fc043 100644
--- a/alsactl/90-alsa-restore.rules.in
+++ b/alsactl/90-alsa-restore.rules.in
@@ -1,4 +1,4 @@
-ACTION=="add", SUBSYSTEM=="sound", KERNEL=="controlC*", KERNELS!="card*", GOTO="alsa_restore_go"
+ACTION=="add", SUBSYSTEM=="sound", KERNEL=="controlC*", KERNELS!="card*", TEST=="@sbindir@", TEST=="@datadir@", GOTO="alsa_restore_go"
 GOTO="alsa_restore_end"
 
 LABEL="alsa_restore_go"
diff --git a/alsactl/Makefile.am b/alsactl/Makefile.am
index b862412..afbedb3 100644
--- a/alsactl/Makefile.am
+++ b/alsactl/Makefile.am
@@ -44,6 +44,7 @@ endif
 
 edit = \
 	$(SED) -r -e 's,@sbindir\@,$(sbindir),g' \
+		  -e 's,@datadir\@,$(mydatadir),g' \
 		  -e 's,@daemonswitch\@,$(ALSACTL_DAEMONSWITCH),g' \
 							< $< > $@ || rm $@
 
diff --git a/configure.ac b/configure.ac
index 7e6894a..a4d2db3 100644
--- a/configure.ac
+++ b/configure.ac
@@ -292,6 +292,7 @@ AC_DEFINE_UNQUOTED(SOUNDSDIR, "$soundsdir", [directory containing sample data])
 
 mydatadir="$dir/alsa"
 AC_DEFINE_UNQUOTED(DATADIR, "$mydatadir", [directory containing alsa configuration])
+AC_SUBST(mydatadir)
 
 AC_ARG_WITH(testsound,
   AS_HELP_STRING([--with-testsound=file], [give the path of test sound file for alsaconf]),
-- 
1.9.1


--------------000507030500050106010205
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------000507030500050106010205--
