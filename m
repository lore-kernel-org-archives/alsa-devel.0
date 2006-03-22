From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: Any missing patches?
Date: Thu, 23 Mar 2006 09:38:57 +1030 (CST)
Message-ID: <200603222308.k2MN8v5T019968@auster.physics.adelaide.edu.au>
References: <s5hu09qycgo.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hu09qycgo.wl%tiwai@suse.de> from "Takashi Iwai" at Mar 22, 2006 11:56:39 AM
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
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, alsa-devel@lists.sourceforge.net, rq@akl.lt
List-Id: alsa-devel@alsa-project.org

> > > -	/* Set ADC connection select to match default mixer setting - mic
> > > +	/* Set ADC connection select to match default mixer setting - Mic
> > >  	 * (on mic1 pin)
> > >  	 */
> > >  	{0x04, AC_VERB_SET_CONNECT_SEL, 0x00},
> > >
> > >  	/* Do similar with the second ADC: mute capture input amp and
> > > -	 * set ADC connection to line (on line1 pin)
> > > +	 * set ADC connection to Line (on line1 pin)
> > > +	 * FIXME: the connection is still set to Mic for some reason
> > >  	 */
> > 
> > The point isn't that the init verbs don't work - it's that elsewhere during
> > device initialisation the capture sources are set to the first one in the
> > source list (or so it seems).
> 
> The mixer reads/modifies the values spec->cur_mux[idx] as caches.
> The initial values are 0 = Mic.

Yep, I figured it was something like that - no surprises there.  IMHO the
current state should probably remain as is - that is, default to mic for all
ADCs since not every laptop with an ALC260 has a "line" jack they can use
for input.  That would then require the above patch to be tweaked so the
second ADC is initialised to use the mic channel (if only for internal
consistency).

Regards
  jonathan


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
