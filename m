From: Martin Langer <martin-langer@gmx.de>
Subject: Re: [RFC] re-queuing usx2y-fw
Date: Tue, 29 Mar 2005 18:58:16 +0200
Message-ID: <20050329165816.GA2696@tuba>
References: <20050328155151.GA3552@tuba> <s5hfyyeijh8.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.net (pop.gmx.net [213.165.64.20])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id 457841B5
	for <alsa-devel@alsa-project.org>; Tue, 29 Mar 2005 18:58:01 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <s5hfyyeijh8.wl@alsa2.suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 29, 2005 at 05:01:55PM +0200, Takashi Iwai wrote:
> At Mon, 28 Mar 2005 17:51:51 +0200,
> Martin Langer wrote:
> > 
> > What about a second attempt of merging it into alsa-firmware? Any new 
> > strategies for this step?
> 
> No, I prefer the traditional one:  Send a patch :)

Ok. Do we have any CodingStyle for assembler files? FreeStyle?

> > The code still depends on as31 (8031/8051 
> > crosss-assembler) which still isn't available as .rpm or .deb, at least 
> > newer versions since 2.1. Should we care about it?
> 
> For convenience, we may include both the firmware source and binary in
> the CVS repository, so that one can install even without as31.

Yep. I will try to introduce a new configure option like 
'--enable-buildfw' for it, or any similar solution.

> > I use it on my US-122 since several months without problems and we have 
> > positive results from us224 and us428 owners. Even the size has only 20 
> > percent of the size of the original tascam file. Aren't these good 
> > reasons for deleting the original closed source file?
> 
> Open-source version is _always_ good (if it provides the same
> functionality).

Full ACK. And it does provide the same functionality here (loading the 
main fw).


martin


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
