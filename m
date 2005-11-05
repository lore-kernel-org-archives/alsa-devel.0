From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Subject: [PATCH] Add Sparc support in alsaconf
Date: Sat, 5 Nov 2005 19:53:55 +0000
Message-ID: <20051105195355.GB24273@palantir8>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I created the patch below against 1.0.10rc2 to make alsaconf work
for the Sparc and architectures.
It has been reviewed on the debian-sparc mailing list
(see http://lists.debian.org/debian-sparc/2005/10/msg00098.html).
I do not have positive confirmation it will work for the AMD7930
chip yet, but I expect it to. The other 2 chips have been tested
and work okay.

One of the feedbacks was that 'modprobe -a -l' is depreciated and
thus should be avoided (see the modprobe manpage), so I have taken
the oportunity to replace all use of this with a find equivalent.

Please excuse me if I so not reply promptly to any responses you may
have. I will temporarilly be working in Munich (Germany) for a while
from next week onwards, and will have less oportunity to read my
email.

Please apply. Best regards,
Martin

        Signed-off-by: Martin Habets <errandir_news@mph.eclipse.co.uk>
---
--- alsaconf.in.orig	2005-09-14 21:07:37.000000000 +0100
+++ alsaconf.in	2005-11-05 19:41:51.000000000 +0000
@@ -688,7 +688,8 @@
     # PowerMac
     #
     if grep -q MacRISC $PROCFS/cpuinfo; then
-	/sbin/modprobe -a -l | grep 'snd-powermac' | \
+	MODDIR=/lib/modules/`uname -r`
+	find $MODDIR -name 'snd-powermac' -print | \
 	while read i; do
 	    i=${i##*/}
 	    i=${i%%.o}
@@ -696,6 +697,43 @@
 	    echo "PowerMac $i" >> $FOUND
 	done
     fi
+
+    #
+    # Sparc
+    #
+    if grep -q Sparc $PROCFS/cpuinfo; then
+	test -r $PROCFS/openprom/name || /bin/mount -t openpromfs none $PROCFS/openprom >/dev/null 2>&1
+	# Check for an "audio" device
+	audio=
+	compat=
+	if test -r $PROCFS/openprom; then
+	    audio=`find $PROCFS/openprom -follow -type d -name "audio*" -print`
+	fi
+	if test -n "$audio"; then
+	    compat=`cat $audio/compatible`
+	    compat=${compat#\'}
+	    compat=${compat%\'}
+	    compat=${compat#SUNW,}
+	fi
+	# Go through all cards we have
+	MODDIR=/lib/modules/`uname -r`
+	find $MODDIR -name 'snd-sun-*' -print | \
+	while read i; do
+	    i=${i##*/}
+	    i=${i%%.o}
+	    i=${i%%.ko}
+	    sdev=`echo ${i#snd-sun-} | tr "[a-z]" "[A-Z]"`
+
+	    if test "$sdev" = "$compat"; then
+		echo "$sdev $i" >> $FOUND
+	    elif test -r $PROCFS/openprom; then
+		find $PROCFS/openprom -follow -type d -name "SUNW,${sdev}*" \
+		    -exec echo "$sdev $i" \; 2>/dev/null >> $FOUND
+	    else
+		echo "$sdev $i" >> $FOUND
+	    fi
+	done
+    fi
 }
 
 #
@@ -1305,7 +1343,8 @@
 
 if [ -s "$FOUND" ]; then
     while read dev card ; do
-	/sbin/modprobe -a -l | grep -q -E $card'\.(o|ko)' || continue
+	MODDIR=/lib/modules/`uname -r`
+	find $MODDIR -type f | grep -q -E $card'\.(o|ko)' || continue
 	cardname=`find_device_name $dev | cut -c 1-64`
 	if [ -z "$cardname" ]; then
 	    cardname="$card"


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
