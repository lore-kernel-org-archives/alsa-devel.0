From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH] emu10k1: fix P16V breakage
	for	non	Audigy2 cards
Date: Fri, 18 Mar 2005 14:56:43 -0500
Message-ID: <1111175803.11341.8.camel@mindpipe>
References: <1110950511.19984.9.camel@mindpipe>
	 <1110950832.19984.13.camel@mindpipe>  <4238A516.7070802@superbug.co.uk>
	 <1111074813.23171.11.camel@mindpipe>  <423B319A.8080306@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <423B319A.8080306@superbug.co.uk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 2005-03-18 at 19:52 +0000, James Courtier-Dutton wrote:
> Lee Revell wrote:
> > On Wed, 2005-03-16 at 21:28 +0000, James Courtier-Dutton wrote:
> > 
> >>Thank you for fixing the bug.
> >>The "unhandled interrupt" should be commented out. It is used for 
> >>reverse engineering certain features.
> >>
> > 
> > 
> > OK, updated patch attached.
> > 
> > Please apply to CVS ASAP, this is a bad bug!
> > 
> > Lee
> > 
> > 
> 
> I think that this "bad bug" will also effect Audigy 1 cards.
> Does that new if statement in the irq handler correctly exclude Audigy 1 
> cards ?
> 

Also pzad once said he suspected the Audigy1 card also has a P16V.
Might be worth a try.  But I have no Audigy1 hardware.

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
