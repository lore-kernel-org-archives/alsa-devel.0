From: Thierry Vignaud <tvignaud@mandrakesoft.com>
Subject: Re: [PATCH] add support for mandrake in alsaconf
Date: Mon, 24 Nov 2003 19:42:52 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <m2ad6lzh6r.fsf@vador.mandrakesoft.com>
References: <1069458051.11875.5.camel@cmn37.stanford.edu>
	<3FBF3808.1060104@gmx.de> <1069641542.7493.18.camel@cmn30.stanford.edu>
	<m27k1p24o1.fsf_-_@vador.mandrakesoft.com> <s5hbrr13iix.wl@alsa2.suse.de>
	<1069700300.2235.11.camel@cmn37.stanford.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1069700300.2235.11.camel@cmn37.stanford.edu> (Fernando Pablo
 Lopez-Lezcano's message of "24 Nov 2003 10:58:20 -0800")
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: Takashi Iwai <tiwai@suse.de>, Lars Heineken <Lars.Heineken@gmx.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--=-=-=

Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU> writes:

> > > > > I think we need a similar extension to support Mandrake,
> > > > > after installation from the sources all modules in
> > > > > modules.conf where gone, except the ones from alsa.. :-)
> > > > 
> > > > I think the patch will fix mandrake too. I have the dubious
> > > > honor of being able to claim ownership of the original bug :-(
> > > > Anything having a /etc/redhat-release file but without having
> > > > "Red Hat" inside would trigger the bug.
> > > > 
> > > > The currently result with Mandrake would be to use the SuSE
> > > > filter to try to erase the oss preferences from
> > > > modules.conf. If the RedHat filter is better then another "if"
> > > > could be added to the distro selection code to include
> > > > Mandrake.
> > > 
> > > untested:
> > 
> > shall i apply this?  let me know.
> 
> I think it does no harm but does not change the end result
> either. It creates a new option ("mandrake") but there is no code to
> handle it so the if's should just execute the SuSE (default) code as
> they do now.
> 
> Options:
> a) define 'distribution="redhat"' for the mandrake detection code
> _if_ the oss options erasure for redhat works fine under mandrake
> (mandrake users should test this).
> b) add another handler for mandrake's modules.conf oss options
> (should be written taking into account whatever mandrake uses to
> configure sound so that the proper strings are removed from
> modules.conf).

so why not doing such as threat all distros that provide
/etc/redhat-release the same way.  i don't think there's any distro
out that provide /etc/redhat-release for compatibility that would like
to have users loose their module configuration:

--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=alsaconf.diff

Index: alsaconf/alsaconf.in
===================================================================
RCS file: /cvsroot/alsa/alsa-utils/alsaconf/alsaconf.in,v
retrieving revision 1.5
diff -u -p -r1.5 alsaconf.in
--- alsaconf/alsaconf.in	24 Nov 2003 11:42:24 -0000	1.5
+++ alsaconf/alsaconf.in	24 Nov 2003 19:40:54 -0000
@@ -24,10 +24,8 @@ if [ -f /etc/SuSE-release -o -f /etc/Uni
   distribution="suse"
 elif [ -f /etc/debian_version ]; then
   distribution="debian"
-elif [ -f /etc/redhat-release -a `grep -c "Red Hat" /etc/redhat-release 2>/dev/null` != 0 ]; then
+elif [ -f /etc/redhat-release ]; then
   distribution="redhat"
-elif [ -f /etc/fedora-release -a `grep -c "Fedora" /etc/fedora-release 2>/dev/null` != 0 ]; then
-  distribution="fedora"
 else
   distribution="unknown"
 fi
@@ -548,7 +546,7 @@ Do you want to modify ${cfgfile}?" 8 50 
 	SOUND_CORE="snd"
     fi
 
-    if [ "$distribution" = "redhat" -o "$distribution" = "fedora" ] ; then
+    if [ "$distribution" = "redhat" ] ; then
         remove_ac_block < $cfgfile | remove_sndconfig_block | uniq > $TMP
     else
 	remove_ac_block < $cfgfile | remove_y2_block | uniq > $TMP

--=-=-=--



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
