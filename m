From: Frank Barknecht <fbar@footils.org>
Subject: Re: no sound with 1.0.0 release
Date: Sun, 14 Dec 2003 15:01:55 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031214140154.GA7381@fliwatut.scifi>
References: <1071201843.1980.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1071201843.1980.9.camel@localhost.localdomain>
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

Hallo,
Noel Bush hat gesagt: // Noel Bush wrote:

> I am using the planetccrma-core distribution.  Recently I tried
> upgrading, via that distro, to the alsa 1.0.0 packages.  I found that
> after this upgrade, I was unable to hear any sound when using any app
> (simplest test, using aplay on a wav file). 

I have no real idea why this is so, but here often it helped to remove the
file /etc/asound.state while ALSA isn't running and then start ALSA
again.

ciao
-- 
 Frank Barknecht                               _ ______footils.org__


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
