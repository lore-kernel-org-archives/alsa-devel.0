From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: [PATCH] HDA/ALC260: switch pin buffers when pin mode changed
Date: Mon, 27 Feb 2006 11:26:03 +1030 (CST)
Message-ID: <200602270056.k1R0u38w014770@auster.physics.adelaide.edu.au>
References: <s5hwtfktsjd.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hwtfktsjd.wl%tiwai@suse.de> from "Takashi Iwai" at Feb 24, 2006 09:23:34 PM
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
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Takashi

> > The following patch (against CVS from 20060223) makes ALSA switch ALC260 pin
> > input/output buffers in tandem with pin mode changes.  This means that a
> > given pin only ever has a single buffer enabled and there's no need to
> > statically enable both input and output for pins which can be retasked by
> > the user as inputs and outputs.  Although there is little obvervable benefit
> > from doing the dynamic switching, it is arguably a neater solution from the
> > engineering point of view, an will probably also result in a slightly lower
> > noise floor when recording from such pins.
> > 
> > The initverbs for the test and fujitsu models have been adjusted to take
> > this new functionality into account.
> 
> The patch looks fine.
> 
> Could you send me a series of pending patches for ALC260 so that I can
> merge them all without missing?

No worries.  I'll collect them all up tonight, do diffs vs current CVS and
send them on tomorrow.  I'll also forward some other minor patches which
have been in development over the last few days, including:

 * add GPIO controls to ALC260 test model
 * make some structures more generically applicable
 * integrate the new "acer" model recently posted in draft form (using some
   features in the above patches)

Regards
  jonathan


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
