From: Art Haas <ahaas@airmail.net>
Subject: Re: Patches for replacing obsolete GCC initializers
Date: Thu, 17 Jul 2003 07:37:31 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030717123731.GB3788@artsapartment.org>
References: <20030716185713.GG671@artsapartment.org> <s5hvfu1zg5j.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hvfu1zg5j.wl@alsa2.suse.de>
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

On Thu, Jul 17, 2003 at 10:55:20AM +0200, Takashi Iwai wrote:
> At Wed, 16 Jul 2003 13:57:13 -0500,
> Art Haas wrote:
> > 
> > Hi.
> > 
> > I have a large set of patches removing the obsolete GCC structure
> > initializers and replacing them with C99 initializers. The total patch
> > set is around 70K and affects 34 files. Would it be acceptable to post
> > the patch in compressed form to the list, or would posting the patches
> > in say two or three sets be better?
> 
> i vote for the latter one.
> the binary attachment might be rejected by the spam filter.
> 

I'll split up the patches into a number of files and mail them today.

> btw, i'm surprised that there are still so many files.  i thought most
> of them have been already replaced.  is it really to the latest ALSA
> 0.9.5?

Yes - CVS from a day or two ago. There are lots of files in
alsa-lib/src/pcm that use the old GCC syntax.

I'd sent a set of patches before, but I think the moderator Dave Null
(ha-ha-ha!) must have rejected them. I was not subscribed to the list at
the time.

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
