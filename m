From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Getting actual sample rate
Date: Wed, 11 Jun 2003 21:44:47 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E19QH3J-000799-00@sc8-sf-list1.sourceforge.net>
References: <1055380015.434.8.camel@localhost>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "11 Jun 2003 21:06:55 EDT."
             <1055380015.434.8.camel@localhost>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "David E. Storey" <dave@tamos.net>
Cc: alsa <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>Anyone care to shed the light on the math for what totalmix does
>regarding fader-to-mixer, fader-to-db and mixer-to-fader values? What I
>have works, but it's UGLY. (well just the constants... I like things to
>be simple.)

you could use the settings in ardour, which has relatively
sophisticated non-linear, volumetric slider function. these map
between a 0..1 fractional position and a gain coefficient.

static inline double 
gain_to_slider_position (ARDOUR::gain_t g)
{
	if (g == 0) return 0;
	return pow((6.0*log(g)/log(2.0)+192.0)/198.0, 8.0);

}

static inline ARDOUR::gain_t 
slider_position_to_gain (double pos)
{
	/* XXX Marcus writes: this doesn't seem right to me. but i don't have a better answer ... */
	return pow (2.0,(sqrt(sqrt(sqrt(pos)))*198.0-192.0)/6.0);
}


-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
