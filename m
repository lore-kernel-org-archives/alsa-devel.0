From: Travis Place <wishie@wishie.net>
Subject: [PATCH] alsa-info.sh - added extra checks - FIXED
Date: Wed, 31 Dec 2008 01:25:14 +1000
Message-ID: <7284C74B-26CE-45A6-94E3-338BB6017C68@wishie.net>
References: <B0844058-1529-4AE6-802E-821BF8428444@wishie.net>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: multipart/mixed; boundary=Apple-Mail-3--1059555614
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www.wishie.net (202-137-99-242.dial.usertools.net
	[202.137.99.242])
	by alsa0.perex.cz (Postfix) with ESMTP id 89E171037EC
	for <alsa-devel@alsa-project.org>; Tue, 30 Dec 2008 16:25:20 +0100 (CET)
Received: from [192.168.0.9] (unknown [192.168.0.200])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by www.wishie.net (Postfix) with ESMTP id 291A6EC57A
	for <alsa-devel@alsa-project.org>; Tue, 30 Dec 2008 15:48:07 +1000 (EST)
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


--Apple-Mail-3--1059555614
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit




> Since this patch hasnt been applied yet, i made a few small edits to  
> it, so ill resubmit now..
>
> Same Changelog stands..
>
>

--Apple-Mail-3--1059555614
Content-Disposition: attachment;
	filename=alsa-info-0.4.53.patch
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="alsa-info-0.4.53.patch"
Content-Transfer-Encoding: 7bit

--- alsa-info.sh	2008-12-29 00:58:09.000000000 +1000
+++ alsa-info-0.4.53.sh	2008-12-29 02:21:07.000000000 +1000
@@ -1,6 +1,6 @@
 #!/bin/bash
 
-SCRIPT_VERSION=0.4.52
+SCRIPT_VERSION=0.4.53
 CHANGELOG="http://www.alsa-project.org/alsa-info.sh.changelog"
 
 #################################################################################
@@ -26,6 +26,9 @@
 # 1. Remove the need for the devs/helpers to ask several questions before we can easily help the user.
 # 2. Allow newer/inexperienced ALSA users to give us all the info we need to help them.
 
+#Set the locale (this may or may not be a good idea.. let me know)
+export LC_ALL=C
+
 #Change the PATH variable, so we can run lspci (needed for some distros)
 PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin
 BGTITLE="ALSA-Info v $SCRIPT_VERSION"
@@ -309,6 +312,11 @@
 VENDOR_ID=`lspci -vn |grep 040[1-3] | awk -F':' '{print $3}'|awk {'print substr($0, 2);}' >/tmp/alsainfo/vendor_id.tmp`
 DEVICE_ID=`lspci -vn |grep 040[1-3] | awk -F':' '{print $4}'|awk {'print $1'} >/tmp/alsainfo/device_id.tmp`
 LAST_CARD=$((`grep "]: " /proc/asound/cards | wc -l` - 1 ))
+
+ESDINST=$(which esd 2>/dev/null| sed 's|^[^/]*||' 2>/dev/null)
+PAINST=$(which pulseaudio 2>/dev/null| sed 's|^[^/]*||' 2>/dev/null)
+ARTSINST=$(which artsd 2>/dev/null| sed 's|^[^/]*||' 2>/dev/null)
+
 cat /proc/asound/modules 2>/dev/null|awk {'print $2'}>/tmp/alsainfo/alsamodules.tmp
 cat /proc/asound/cards >/tmp/alsainfo/alsacards.tmp
 lspci |grep -i "multi\|audio">/tmp/alsainfo/lspci.tmp
@@ -330,7 +338,7 @@
 echo "!!ALSA Information Script v $SCRIPT_VERSION" >> $FILE
 echo "!!################################" >> $FILE
 echo "" >> $FILE
-echo "!!Script ran on: `LANG=C date`" >> $FILE
+echo "!!Script ran on: `LANG=C TZ=UTC date`" >> $FILE
 echo "" >> $FILE
 echo "" >> $FILE
 echo "!!Linux Distribution" >> $FILE
@@ -363,6 +371,35 @@
 cat /tmp/alsainfo/alsamodules.tmp >> $FILE
 echo "" >> $FILE
 echo "" >> $FILE
+echo "!!Sound Servers on this system" >> $FILE
+echo "!!----------------------------" >> $FILE
+echo "" >> $FILE
+if [[ -n $PAINST ]];then
+[[ `pgrep $PAINST` ]] && PARUNNING="Yes" || PARUNNING="No"
+echo "Pulseaudio:" >> $FILE
+echo "      Installed - Yes ($PAINST)" >> $FILE
+echo "      Running - $PARUNNING" >> $FILE
+echo "" >> $FILE
+fi
+if [[ -n $ESDINST ]];then
+[[ `pgrep $ESDINST` ]] && ESDRUNNING="Yes" || ESDRUNNING="No"
+echo "ESound Daemon:" >> $FILE
+echo "      Installed - Yes ($ESDINST)" >> $FILE
+echo "      Running - $ESDRUNNING" >> $FILE
+echo "" >> $FILE
+fi
+if [[ -n $ARTSINST ]];then
+[[ `pgrep $ARTSINST` ]] && ARTSRUNNING="Yes" || ARTSRUNNING="No"
+echo "aRts:" >> $FILE
+echo "      Installed - Yes ($ARTSINST)" >> $FILE
+echo "      Running - $ARTSRUNNING" >> $FILE
+echo "" >> $FILE
+fi
+if [[ -z "$PAINST" && -z "$ESDINST" && -z "$ARTSINST" ]];then
+echo "No sound servers found." >> $FILE
+echo "" >> $FILE
+fi
+echo "" >> $FILE
 echo "!!Soundcards recognised by ALSA" >> $FILE
 echo "!!-----------------------------" >> $FILE
 echo "" >> $FILE

--Apple-Mail-3--1059555614
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

>
>
>
> On 29/12/2008, at 2:25 AM, Travis Place wrote:
>
>> Changelog:
>>
>> Added checks for Pulseaudio/Esound/aRts 'sound servers', Check if  
>> they are 1) installed 2) running
>> A few small changes for the locale, and timezone - keep things more  
>> uniform.
>> Bumped version to 0.4.53
>>
>> Signed-off-by: Travis Place <wishie@wishie.net>
>>
>>
>> <alsa-info-0.4.53.patch>
>>
>>
>>
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>


--Apple-Mail-3--1059555614
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Apple-Mail-3--1059555614--
