From: Art Haas <ahaas@airmail.net>
Subject: Re: [PATCH] Replace obsolete GCC initializers in alsa-lib [1/3]
Date: Thu, 17 Jul 2003 12:19:43 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030717171943.GA834@artsapartment.org>
References: <20030717124356.GC3788@artsapartment.org> <s5hvfu1yz00.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hvfu1yz00.wl@alsa2.suse.de>
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

On Thu, Jul 17, 2003 at 05:05:51PM +0200, Takashi Iwai wrote:
> At Thu, 17 Jul 2003 07:45:34 -0500,
> Art Haas wrote:
> > 
> > Hi.
> > 
> > This is the first of three patches.
> 
> thanks!
> 
> however, the patch looks not complete.
> i noticed that forward is missing in some places.
> 
> did you convert them manually?
> 

When I created many of these patches several months ago I used a perl
script. Then when I got 0.9.5 installed I fixed the files manually.

What I'd done when making the patches was:

$ cvs -z3 diff -u alsa_lib > alsa_lib.diff

I copied the "alsa_lib.diff" file into three separate files and then
manually removed some patches that were of other stuff (i.e. libtool
version string problems when libtool is version 1.5a. The prescence of
the "a" makes problems, but a simple sed command fixes it).

I find these old initializers with my patched GCC compiler. You can spot
them if you compile with '-pedantic', but then a bazillion warnings also
appear. I patched GCC to warn about the old syntax without needing a
command line option.

If you apply the patches I'll update my CVS copy and fix the bits I've
missed.

Thanks.

Art Haas
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
