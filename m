From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: fedora core alsaconf patch
Date: 23 Nov 2003 18:39:06 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1069641542.7493.18.camel@cmn30.stanford.edu>
References: <1069458051.11875.5.camel@cmn37.stanford.edu>
	 <3FBF3808.1060104@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3FBF3808.1060104@gmx.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lars Heineken <Lars.Heineken@gmx.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> I think we need a similar extension to support Mandrake, after 
> installation from the sources all modules in modules.conf where gone, 
> except the ones from alsa.. :-)

I think the patch will fix mandrake too. I have the dubious honor of
being able to claim ownership of the original bug :-( Anything having a
/etc/redhat-release file but without having "Red Hat" inside would
trigger the bug. 

The currently result with Mandrake would be to use the SuSE filter to
try to erase the oss preferences from modules.conf. If the RedHat filter
is better then another "if" could be added to the distro selection code
to include Mandrake. 

-- Fernando

> >Included is a patch that fixes alsaconf to work correctly under fedora
> >core 1. Otherwise alsaconf happily creates a modules.conf file that only
> >contains the alsa configuration and nothing else (a path in the if's
> >that does not create a $TMP file before the alsa configuration process
> >starts). 




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
