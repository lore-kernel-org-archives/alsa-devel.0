From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: [PATCH] add support for mandrake in alsaconf
Date: 24 Nov 2003 12:03:09 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1069704189.2234.30.camel@cmn37.stanford.edu>
References: <1069458051.11875.5.camel@cmn37.stanford.edu>
	 <3FBF3808.1060104@gmx.de> <1069641542.7493.18.camel@cmn30.stanford.edu>
	 <m27k1p24o1.fsf_-_@vador.mandrakesoft.com> <s5hbrr13iix.wl@alsa2.suse.de>
	 <1069700300.2235.11.camel@cmn37.stanford.edu>
	 <m2ad6lzh6r.fsf@vador.mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <m2ad6lzh6r.fsf@vador.mandrakesoft.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Thierry Vignaud <tvignaud@mandrakesoft.com>
Cc: Takashi Iwai <tiwai@suse.de>, Lars Heineken <Lars.Heineken@gmx.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> > > > > > I think we need a similar extension to support Mandrake,
> > > > > > after installation from the sources all modules in
> > > > > > modules.conf where gone, except the ones from alsa.. :-)
> > > > > 
> > > > > I think the patch will fix mandrake too. I have the dubious
> > > > > honor of being able to claim ownership of the original bug :-(
> > > > > Anything having a /etc/redhat-release file but without having
> > > > > "Red Hat" inside would trigger the bug.
> > > > > 
> > > > > The currently result with Mandrake would be to use the SuSE
> > > > > filter to try to erase the oss preferences from
> > > > > modules.conf. If the RedHat filter is better then another "if"
> > > > > could be added to the distro selection code to include
> > > > > Mandrake.
> > > > 
> > > > untested:
> > > 
> > > shall i apply this?  let me know.
> > 
> > I think it does no harm but does not change the end result
> > either. It creates a new option ("mandrake") but there is no code to
> > handle it so the if's should just execute the SuSE (default) code as
> > they do now.
> > 
> > Options:
> > a) define 'distribution="redhat"' for the mandrake detection code
> > _if_ the oss options erasure for redhat works fine under mandrake
> > (mandrake users should test this).
> > b) add another handler for mandrake's modules.conf oss options
> > (should be written taking into account whatever mandrake uses to
> > configure sound so that the proper strings are removed from
> > modules.conf).
> 
> so why not doing such as threat all distros that provide
> /etc/redhat-release the same way.  i don't think there's any distro
> out that provide /etc/redhat-release for compatibility that would like
> to have users loose their module configuration:

With the patch I supplied no distros that user /etc/redhat-release will
lose their configuration (I hope, at least not due to the bug I
introduced a long time ago which is fixed by the patch). Distros that
are not RedHat or Fedora will execute the SuSE code path. 

Your patch is fine, I would say. But it has an assumption I don't quite
like. I wrote "remove_sndconfig_block" (basing it on "remove_y2_block")
by looking at all the strings that the sndconfig utility was adding to
modules.conf (sndconfig was the way RedHat was doing sound configuration
quite a while ago, I think this has changed). I assume the same happened
when "remove_y2_block" was written (in this case with SuSE's yast2). I
don't know what sound configurators are being used by other releases
that use /etc/redhat-release (mandrake is one, probably others?), they
may be creating other strings in modules.conf that will not be removed
by "remove_sndconfig_block" so they may need custom "remove_xx_block"
functions that deal with what they add to modules.conf. 

Just being picky :-)
-- Fernando




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
