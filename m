From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: [PATCH] Add support for Acer TravelMate and similar laptops
Date: Tue, 28 Feb 2006 11:55:48 +1030 (CST)
Message-ID: <200602280125.k1S1Pmlb021588@auster.physics.adelaide.edu.au>
References: <44023C36.2040404@akl.lt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <44023C36.2040404@akl.lt> from "Rimas Kudelis" at Feb 27, 2006 01:39:34 AM
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Rimas Kudelis <rq@akl.lt>
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, alsa-devel@lists.sourceforge.net, Paulo Matias <syscoder@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Rimas

As you might have noticed, the consolidation patch eluded to yesterday has
now been posted to alsa-devel.  One of these adds the "acer" model.  Look
for messages with a subject of the form 

  [PATCH] HDA/ALC260: x/7 - ...

where x=1-7.

> >> Jonathan, how about your idea to add GPIO controls to the test model? 
> > Hopefully coming early this week.

This is part of the 7-patch series, along with SPDIF enable switches.

> >> * is there any reason in defining ADC NIDs for every model separately? 
> >> They seem to be the same anyways, and not to get in anyones way. Or do 
> >> they?
> > 
> > Up to this point the reason for the differing definitions has been
> > due to the different ways things needed to use the ADC NIDs.  As part of
> > a consolidation patch I'm preparing for Takashi I hope to clean this
> > stuff up a bit.
> 
> Very good. I'm eagerly waiting for that. I hope, ALSA 1.0.11 won't 
> come out until we're done with ALC260.

There is now a single ADC NID list which can be used by any model which
utilises the "dual ADC" functionality.  The fujitsu model was the only
model using this up to this point; now the newly added acer model does
as well.

> >> * If the jack is called "Line In", should I leave it as "Line" in 
> >> mixer, or should I name it "Line In"?
> > What do you think is less confusing?
> I don't actually know. It doesn't make significant difference for me, 
> so it's hard to tell. I'm just asking about the policy - is "Line" a 
> conventional name in ALSA, or is it a convention to name controls like 
> jacks?..

I've left it as "Line" since in this context it's more consistent with the
rest of ALSA.

> Of course I don't mind. You may consider my patch being a sketch which 
> you can transform into whatever seems best for you. Of course, I'll 
> want to test the results too. :)

Feel free to grab the 7 patches and give them a whirl.  Note that they
are against a recent CVS version of alsa.  Hopefully though it won't be
too long before they show up in CVS.

Regards
  jonathan


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
