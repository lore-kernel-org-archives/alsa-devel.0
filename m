From: Pavel Roskin <proski@gnu.org>
Subject: Minor fix for the build script
Date: Fri, 6 Sep 2002 12:33:26 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0209061226330.10883-100000@marabou.research.att.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello!

The top-level build script says "test: too many arguments" if 
EXTRA_ALSA_DRIVER_CONFIG_FLAGS is already defined to a string that 
contains spaces.

Also, since that string can contain options beginning with "-", it's 
better that we play safe and prepend "x" to it to avoid the possibility of 
confusing "test" by those options.

Fix:

=========================
--- build
+++ build
@@ -6,7 +6,7 @@
 
 # Comment this out if you don't want isapnp support in ALSA driver RPM
 #
-test -z $EXTRA_ALSA_DRIVER_CONFIG_FLAGS &&
+test x"$EXTRA_ALSA_DRIVER_CONFIG_FLAGS" = x &&
     EXTRA_ALSA_DRIVER_CONFIG_FLAGS="--with-isapnp=yes --with-sequencer=yes"
 export EXTRA_ALSA_DRIVER_CONFIG_FLAGS
 
=========================

-- 
Regards,
Pavel Roskin



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
