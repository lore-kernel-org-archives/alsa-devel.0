From: Thierry Vignaud <tvignaud@mandrakesoft.com>
Subject: [PATCH] add support for mandrake in alsaconf
Date: Mon, 24 Nov 2003 14:59:42 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <m27k1p24o1.fsf_-_@vador.mandrakesoft.com>
References: <1069458051.11875.5.camel@cmn37.stanford.edu>
	<3FBF3808.1060104@gmx.de> <1069641542.7493.18.camel@cmn30.stanford.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1069641542.7493.18.camel@cmn30.stanford.edu> (Fernando Pablo
 Lopez-Lezcano's message of "23 Nov 2003 18:39:06 -0800")
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: Lars Heineken <Lars.Heineken@gmx.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--=-=-=

Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU> writes:

> > I think we need a similar extension to support Mandrake, after
> > installation from the sources all modules in modules.conf where
> > gone, except the ones from alsa.. :-)
> 
> I think the patch will fix mandrake too. I have the dubious honor of
> being able to claim ownership of the original bug :-( Anything
> having a /etc/redhat-release file but without having "Red Hat"
> inside would trigger the bug.
> 
> The currently result with Mandrake would be to use the SuSE filter
> to try to erase the oss preferences from modules.conf. If the RedHat
> filter is better then another "if" could be added to the distro
> selection code to include Mandrake.

untested:

--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=alsa-mdk.diff

Index: alsaconf/alsaconf.in
===================================================================
RCS file: /cvsroot/alsa/alsa-utils/alsaconf/alsaconf.in,v
retrieving revision 1.5
diff -u -p -r1.5 alsaconf.in
--- alsaconf/alsaconf.in	24 Nov 2003 11:42:24 -0000	1.5
+++ alsaconf/alsaconf.in	24 Nov 2003 14:58:43 -0000
@@ -24,6 +24,8 @@ if [ -f /etc/SuSE-release -o -f /etc/Uni
   distribution="suse"
 elif [ -f /etc/debian_version ]; then
   distribution="debian"
+elif [ -f /etc/mandrake-release ]; then
+  distribution="mandrake"
 elif [ -f /etc/redhat-release -a `grep -c "Red Hat" /etc/redhat-release 2>/dev/null` != 0 ]; then
   distribution="redhat"
 elif [ -f /etc/fedora-release -a `grep -c "Fedora" /etc/fedora-release 2>/dev/null` != 0 ]; then

--=-=-=--



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
