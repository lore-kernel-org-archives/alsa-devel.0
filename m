From: Dan Aloni <da-x@colinux.org>
Subject: Re: ALC658 rev 0 - a problem with Rear Right
Date: Mon, 7 Mar 2005 14:28:00 +0200
Message-ID: <20050307122800.GA27123@localdomain>
References: <20050305153503.GA10747@localdomain> <20050307104214.GA17817@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050307104214.GA17817@localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 07, 2005 at 12:42:14PM +0200, Dan Aloni wrote:
> On Sat, Mar 05, 2005 at 05:35:03PM +0200, Dan Aloni wrote:
> > Hello,
> > 
> > Somewhere between 2.6.8 and 2.6.11 my alc658 (rev 0) card stopped 
> > outputing audio on the Rear Right speaker. Of course I checked the
> > cables and there's nothing wrong with the speaker.
> > 
> [..]
> > Assuming that I'm a capable kernel hacker, do you have any advice 
> > about how to debug this?
> 
> I've isolated the problem to the difference between these two
> versions:
> 
>     alsa-driver-1.0.8rc1
>     alsa-driver-1.0.8rc2
>     
> By experimentation the changes between rc1 and rc2 have caused 
> the problem.    

After a more few experiments, I was able to further isolate the 
changes that caused the problem.

The problem was introduced in the following changeset, which
was supposed to cleanup things but accidently broke something.

"[ALSA] Clean up and fix stereo mutes" :

http://linus.bkbits.net:8080/linux-2.5/cset@41da4592A-ipuvcg54DHv3jB__kcaA?nav=index.html|src/|src/sound|src/sound/pci|src/sound/pci/ac97|related/sound/pci/ac97/ac97_codec.c

If you need assistance, please tell me.

-- 
Dan Aloni
da-x@colinux.org


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
