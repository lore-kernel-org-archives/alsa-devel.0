From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: Re: [PATCH] Add support for Acer TravelMate and similar laptops
Date: Wed, 1 Mar 2006 09:03:18 +1030 (CST)
Message-ID: <200602282233.k1SMXI8M015360@auster.physics.adelaide.edu.au>
References: <s5hhd6jr27t.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hhd6jr27t.wl%tiwai@suse.de> from "Takashi Iwai" at Feb 28, 2006 03:24:06 PM
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
Cc: Rimas Kudelis <rq@akl.lt>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, alsa-devel@lists.sourceforge.net, Paulo Matias <syscoder@gmail.com>
List-Id: alsa-devel@alsa-project.org

> > > There is now a single ADC NID list which can be used by any model which
> > > utilises the "dual ADC" functionality.  The fujitsu model was the only
> > > model using this up to this point; now the newly added acer model does
> > > as well.
> > >   
> > Now another question - is there a reason to list ADC's in reversed order
> > for HP model? If there's none, I think HP model could simply use the
> > same list that Fujitsu and Acer now use.
> 
> It's just a historical reason.  The original realtek driver did it so,
> and I didn't want a possible breakage.  Once after we confirm that it
> works regardless of the order, we can reuse the same list. 

One thing worth noting is that the different ADCs do have slightly different
input selector maps.  Given the inputs which do differ I doubt the order
makes a great deal of difference, but this would be one thing worth checking
before making a change to the HP model.

The reason why the "dual_adc" NID list is ordered with 0x4 first is because
the capture mixer seems to treat 0x4 as the first ADC, so I figured I'd 
keep things consistent.

Regards
  jonathan


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
