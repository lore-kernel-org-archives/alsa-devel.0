From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: hda-intel and Acer TravelMate 4062 LMi
Date: Tue, 28 Feb 2006 12:02:30 +1030 (CST)
Message-ID: <200602280132.k1S1WUNu021958@auster.physics.adelaide.edu.au>
References: <1141047723.8504.4.camel@lepetit.gilouweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1141047723.8504.4.camel@lepetit.gilouweb.com> from "Gilles =?ISO-8859-1?Q?PI=C9TRI?=" at Feb 27, 2006 02:42:03 PM
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Gilles =?ISO-8859-1?Q?PI=C9TRI?= <contact@gilouweb.com>
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Gilou

> > Over the weekend there have been major developments in this regard, to the
> > point that at least some Acers can make noise from the internal speaker and
> > the headphone jack.  I am preparing a series of ALC260 consolidation patches
> > now which will include the initial implementation of an "acer" model.  This
> > should be posted tomorrow.  It would be good if you could test these patches
> > with your Acer and let us know how it goes.
> > 
> > If it *does* help, it would be good to know the make/model of your laptop
> > and the PCI IDs of your laptop's sound system.  The latter are reported via
> > lspci. Refer to a post against bug 1618 by me earlier today for the full
> > details on getting these numbers.
> 
> Hi, and thanks for your answer !
> 
> I followed Rimas Kudelis' advice, and I applied the patch on the bug
> report about the ALC260, and it just works smoothly.

That's good to know.  If you can get us the subsystem IDs from your laptop
as described by myself in a post under bug 1618 that would be good.

Note that the patch as ultimately submitted to alsa (as part of a 7-patch
series earlier today) has evolved slightly since the one posted to bug
report 1618.  Once the latest ALC260 patches have been merged to CVS it
would be good if you could test the result to make sure nothing's been
broken for you in the transition.

Regards
  jonathan


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
