From: Martin Langer <martin-langer@gmx.de>
Subject: Re: [ANN] Open Source US-X2Y firmware
Date: Fri, 30 Jul 2004 21:30:14 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040730193014.GA558@tuba.home>
References: <20040727193708.GA1085@tuba.home> <Pine.HPX.4.33n.0407280910590.25644-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.HPX.4.33n.0407280910590.25644-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net, Karsten Wiese <annabellesgarden@yahoo.de>
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 28, 2004 at 09:17:10AM +0200, Clemens Ladisch wrote:
> Martin Langer wrote:
> > I guess many users will get trouble because they haven't yet installed a new
> > version of as31 (v2.2). BTW, I haven't found any deb or rpm :(
> 
> Then it might make sense to include either the loader binary or the
> assembler into the alsa-firmware package.
> (http://www.pjrc.com/tech/8051/ says that AS31 is provided under the
> BSD license)

I've tried out some versions of as31 and the code works with the latest
versions: 2.1, 2.2 and 2.2.1

Earlier versions including 2.0-beta3 from http://www.pjrc.com/tech/8051/
fail.

Including as31 into alsa-firmware is the wrong way IMO. Fixing assembler
bugs shouldn't be the goal of alsa in the future. Also, the number of
compiler tools will grow. Each card has a different chip and need different
cross-compiling tools. And I believe in three years we have no longer cards
without firmware.... perhaps five years ;-) 

It looks like a general problem, because development tools for firmware files 
can be exotic, if they exist at all. Offering two packages firmware-bin and
firmware-source sounds much better.


martin


-- 
                                     Living on earth may be expensive,
                   but it includes an annual free trip around the sun. 


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
