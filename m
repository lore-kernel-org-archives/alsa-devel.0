From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: fedora core alsaconf patch
Date: 21 Nov 2003 15:40:51 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1069458051.11875.5.camel@cmn37.stanford.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-nAVKmAiEy63tX0+Xv4mc"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-nAVKmAiEy63tX0+Xv4mc
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Included is a patch that fixes alsaconf to work correctly under fedora
core 1. Otherwise alsaconf happily creates a modules.conf file that only
contains the alsa configuration and nothing else (a path in the if's
that does not create a $TMP file before the alsa configuration process
starts). 

Please apply!
Thanks...
-- Fernando


--=-nAVKmAiEy63tX0+Xv4mc
Content-Disposition: attachment; filename=alsa-utils-0.9.8-alsaconf.patch
Content-Type: text/plain; name=alsa-utils-0.9.8-alsaconf.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- alsa-utils-0.9.8/alsaconf/alsaconf.in~	2003-10-30 04:00:38.000000000 -0800
+++ alsa-utils-0.9.8/alsaconf/alsaconf.in	2003-11-21 15:28:35.000000000 -0800
@@ -30,8 +30,10 @@
   distribution="suse"
 elif [ -f /etc/debian_version ]; then
   distribution="debian"
-elif [ -f /etc/redhat-release ]; then
+elif [ -f /etc/redhat-release -a `grep -c "Red Hat" /etc/redhat-release 2>/dev/null` != 0 ]; then
   distribution="redhat"
+elif [ -f /etc/fedora-release -a `grep -c "Fedora" /etc/fedora-release 2>/dev/null` != 0 ]; then
+  distribution="fedora"
 else
   distribution="unknown"
 fi
@@ -532,10 +534,8 @@
 	SOUND_CORE="snd"
     fi
 
-    if [ "$distribution" = "redhat" ] ; then
-        if grep -q "Red Hat" /etc/redhat-release >/dev/null 2>&1 ; then
-	    remove_ac_block < $cfgfile | remove_sndconfig_block | uniq > $TMP
-        fi
+    if [ "$distribution" = "redhat" -o "$distribution" = "fedora" ] ; then
+        remove_ac_block < $cfgfile | remove_sndconfig_block | uniq > $TMP
     else
 	remove_ac_block < $cfgfile | remove_y2_block | uniq > $TMP
     fi

--=-nAVKmAiEy63tX0+Xv4mc--



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
