From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH] emu10k1: fix P16V breakage
	for	non	Audigy2 cards
Date: Thu, 17 Mar 2005 11:00:04 -0500
Message-ID: <1111075205.23171.13.camel@mindpipe>
References: <1110950511.19984.9.camel@mindpipe>
	 <1110950832.19984.13.camel@mindpipe> <4238A516.7070802@superbug.co.uk>
	 <1111074813.23171.11.camel@mindpipe>  <s5hhdja1cz1.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <s5hhdja1cz1.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: James Courtier-Dutton <James@superbug.co.uk>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 2005-03-17 at 16:58 +0100, Takashi Iwai wrote:
> At Thu, 17 Mar 2005 10:53:32 -0500,
> Lee Revell wrote:
> > 
> > On Wed, 2005-03-16 at 21:28 +0000, James Courtier-Dutton wrote:
> > > Thank you for fixing the bug.
> > > The "unhandled interrupt" should be commented out. It is used for 
> > > reverse engineering certain features.
> > > 
> > 
> > OK, updated patch attached.
> 
> Already applied the older one except but the change to printk.
> (Is that identical with the new one, right?)

Yes, that's the only change.

Thanks, I didn't see it on the CVS commit list.

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
