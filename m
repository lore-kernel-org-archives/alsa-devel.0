From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: Any missing patches?
Date: Wed, 22 Mar 2006 13:07:33 +1030 (CST)
Message-ID: <200603220237.k2M2bXqD020575@auster.physics.adelaide.edu.au>
References: <20060321223803.318AD16C42@sc8-sf-spam2.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20060321223803.318AD16C42@sc8-sf-spam2.sourceforge.net> from "alsa-devel-request@lists.sourceforge.net" at Mar 21, 2006 02:37:02 PM
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
Cc: tiwai@suse.de, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, rq@akl.lt
List-Id: alsa-devel@alsa-project.org

Hi guys

> this patch cleans up the mixer interface by removing
> unpractical/non-working features. Applies for ALC260 "acer" model in
> hda-intel module. It also adds/changes a few comments in the source.

I have a few comments regarding this patch.

> +	/* Line jack doesn't actually preamplify the mic even if set to one of the
> +	 * Mic modes. However, it doesn't seem like these can be disabled ATM.
> +	 */
>  	ALC_PIN_MODE("Line Jack Mode", 0x14, ALC_PIN_DIR_INOUT),

This comment is actually slightly misleading - see my posts earlier today.
It's not that this jack "doesn't actually preamplify the mic".  At this
stage, on the strength of a sample of one, it appears that at least some of
the Acer laptops have a DC blocking capacitor between the ALC260 chip and
the physical output jack.  This blocks the DC bias supplied by the ALC260
but it doesn't stop "preamplification" - it simply stops unpowered condensor
microphones from working.  If a self-powered mic was plugged in you'll find
that it will work with either setting.

It is true that ALC_PIN_MODE() can't disable the mic modes and leave the
"line in" mode active at present.  I might do a patch at some stage to add
this flexibility.  However, I would probably argue at this stage that it
might not be desireable to omit the mic modes from this pin in the acer
model, since the issue might simply go away with later/other acer models. 
We would then need to define a new Acer model just to cope with this tiny
variation.

> -	/* Internal speaker/Headphone jack is connected to Line-out pin */
> +	/* Internal speaker and Headphone jack are connected to line-out pin */=
>  	{0x0f, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_HP},

Just a comment: this confirms that NID 0x0f is used for the headphone jack.
This explains why the mic controls automagically revert to "line in" mode
for this jack.  See my earlier post for the explanation.

> -	/* Set ADC connection select to match default mixer setting - mic
> +	/* Set ADC connection select to match default mixer setting - Mic
>  	 * (on mic1 pin)
>  	 */
>  	{0x04, AC_VERB_SET_CONNECT_SEL, 0x00},
>
>  	/* Do similar with the second ADC: mute capture input amp and
> -	 * set ADC connection to line (on line1 pin)
> +	 * set ADC connection to Line (on line1 pin)
> +	 * FIXME: the connection is still set to Mic for some reason
>  	 */

The point isn't that the init verbs don't work - it's that elsewhere during
device initialisation the capture sources are set to the first one in the
source list (or so it seems).  This is why the "to match default mixer
setting" comment is there.  I haven't had time to track this down and I
really didn't think it was important enough at this stage to worry about. I
think it is perfectly acceptable to have all inputs default to "mic" and let
the user work out what they want.  Most distros configure things so the alsa
mixer is restored to its last state during a boot, so I don't think it's that
big a deal.

Regards
  jonathan


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
