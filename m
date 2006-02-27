From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: hda-intel and Acer TravelMate 4062 LMi
Date: Mon, 27 Feb 2006 11:42:43 +1030 (CST)
Message-ID: <200602270112.k1R1Ch6K016385@auster.physics.adelaide.edu.au>
References: <20060226040618.0D13E184F98@sc8-sf-spam1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20060226040618.0D13E184F98@sc8-sf-spam1.sourceforge.net> from "alsa-devel-request@lists.sourceforge.net" at Feb 25, 2006 08:05:54 PM
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
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, contact@gilouweb.com
List-Id: alsa-devel@alsa-project.org

Hi Gilou

> I've been reading about the CVS version of the hda-intel allowing to use a
> "test" model. ... Using the CVS version, using the test model, I'm able to
> make some sound getting out through the "Line out" jack, identified in
> alsamixer by "LOUT1". LOUT1 acts also on the microphone jack : I can hear
> the sound in mono by the mic jack when it's active ! However, I can't hear
> anything from the headphone jack, and the same goes for the internal
> speakers, whatever strange things I try with the mixer. I haven't tried to
> input anything, as I would like the output to work first.

Over the weekend there have been major developments in this regard, to the
point that at least some Acers can make noise from the internal speaker and
the headphone jack.  I am preparing a series of ALC260 consolidation patches
now which will include the initial implementation of an "acer" model.  This
should be posted tomorrow.  It would be good if you could test these patches
with your Acer and let us know how it goes.

If it *does* help, it would be good to know the make/model of your laptop
and the PCI IDs of your laptop's sound system.  The latter are reported via
lspci. Refer to a post against bug 1618 by me earlier today for the full
details on getting these numbers.

Regards
  jonathan


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
