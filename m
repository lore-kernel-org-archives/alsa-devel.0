From: ross@lug.udel.edu
Subject: Re: RE: ice1712 Card ID problem
Date: Thu, 9 Sep 2004 14:14:21 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040909181421.GA24152@jose.lug.udel.edu>
References: <E3DC5887246ABD48BFE0B3CA0183FC25010164CB@SLBENF.ebdmail.alcatel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <E3DC5887246ABD48BFE0B3CA0183FC25010164CB@SLBENF.ebdmail.alcatel.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Dirk.Kalis@nextiraone.de
Cc: alsa-devel@lists.sourceforge.net, bkaney@gmail.com
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 09, 2004 at 10:28:02AM +0200, Dirk.Kalis@nextiraone.de wrote:
> first the 8 outputs are pcm channels only. the analog inputs/outputs are set to 0 because in the driver the values for
> num_total_dacs and num_total_adcs are set to 0 if the Card ID is not known.
> Try this 2 patches recompile the driver and envy24control.
> the patch for envy24control is not necessary because no special handling for delta44 in envy24control

Yea, that's exactly what happened - the patches totally fix the problem.
The card is properly recognized, envy24control finds the right number of
input and output channels, and I can hear output.  Thanks so much!

Now, my questions is: why did this change?  Things worked fine for a
long time.  Was this logic added to the ice1712 driver at some point, or
did the subdevice ID on my card change?  The second is kind of scary -
seems to indicate possibly flaky hardware, though it's odd Brian is
seeing the same thing...

Anyhow, I'm good now - thanks a ton!

Ross



-- 
Ross Vandegrift
ross@lug.udel.edu

"The good Christian should beware of mathematicians, and all those who
make empty prophecies. The danger already exists that the mathematicians
have made a covenant with the devil to darken the spirit and to confine
man in the bonds of Hell."
	--St. Augustine, De Genesi ad Litteram, Book II, xviii, 37


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
