From: "Clemens Ladisch" <clemens@ladisch.de>
Subject: Re: [alsa-cvslog] alsa-kernel: fm801: move
 CONFIG_VIDEO_DEV dependency to CONFIG_SND_FM801_TEA575X_BOOL
Date: Mon, 21 Aug 2006 09:52:05 +0200
Message-ID: <1156146725.19545.269017711@webmail.messagingengine.com>
References: <ALOGGER1155885865.57@alsa-project.org>
	<s5hveoqzcz6.wl%tiwai@suse.de>
	<1155891382.17094.268669006@webmail.messagingengine.com>
	<s5hr6zez9xb.wl%tiwai@suse.de>
	<1155893106.18755.268671127@webmail.messagingengine.com>
	<s5hoduiz8j3.wl%tiwai@suse.de>
	<1155911750.14091.268690972@webmail.messagingengine.com>
	<s5h4pwa14xu.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5h4pwa14xu.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> [...]
> I meant CONFIG_SND_FM801_TEA575X in the external alsa-driver tree is
> never set to y or m.  It's always n.  This is because
> CONFIG_SND_FM801_TEA575X is evaluated before *_TEA575X_BOOL.

Okay, I reverted my Kconfig change.

I tried to use this patch to manually evaluate the TEA575X symbols:

--- alsa.orig/alsa-driver/configure.in	2006-08-20 11:38:22.000000000 +0200
+++ alsa/alsa-driver/configure.in	2006-08-21 01:04:13.000000000 +0200
@@ -2548,6 +2548,14 @@
 CONFIG_SOUND=m
 ALSA_TOPLEVEL_SELECT
 
+dnl Workaround for module->option dependency
+if ( test "$CONFIG_SND_FM801_TEA575X_BOOL" = "y" ) &&
+   ( test "$CONFIG_VIDEO_DEV" = "y" ); then
+  CONFIG_SND_FM801_TEA575X="m"
+else
+  CONFIG_SND_FM801_TEA575X_BOOL=""
+fi
+
 dnl OSS emulations
 if test "$CONFIG_SND_OSSEMUL" = "y"; then
   CONFIG_SND_MIXER_OSS="$CONFIG_SND"


However, this results in include/config1.h and toplevel.config being
inconsistent.  Apparently, autoconf writes the symbols to config1.h when
AC_DEFINE is called, but writes to toplevel.config when AC_SUBST is
called.  This means that the above workaround gets applied after
config1.h was written.

The obvious solution would be to move the AC_DEFINE()s out of
ALSA_TOPLEVEL_SELECT into a new macro or into ALSA_TOPLEVEL_OUTPUT.
However, this may also change the values of the OSS symbols that are
written to config1.h (which is done before the assignments under "OSS
emulations"), and I'm not sure if this change might break anything.


Regards,
Clemens

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
