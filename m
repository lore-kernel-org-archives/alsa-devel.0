From: Christof Damian <cdamian@guideguide.com>
Subject: Re: Hoontech Audio DSP24 Value (+bracket)
Date: Tue, 12 Feb 2002 10:31:08 +0000
Message-ID: <20020212103108.K18197@stratus.london.guideguide.com>
References: <20020211141559.A16177@stratus.london.guideguide.com> <s5hpu3b5776.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hpu3b5776.wl@alsa2.suse.de>; from tiwai@suse.de on Tue, Feb 12, 2002 at 11:24:13AM +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa developer mailinglist <alsa-devel@alsa.alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai schrieb am Dienstag, den 12. Februar 2002:
>  
> The patch is apprently not enough.  We need additional codes in
> snd_ice1712_ak4524_write() to send signals to ak4524 correctly.
> Most likely there are gpio bits for codec selection, data and clock
> lines.  Looking at the photo of the card, the DSP24 Value looks like
> having fairly different usage of gpio.

Yes, i wondered about that ;-) For me it was just a way of making it
work a bit more.

> If we really have no info about this card, we need to guess from
> other cards how the connections are..  Well, it's not a good dream..

I wrote to Hoontech and asked about more information about the card,
but I don't know how good they are releasing spec.

> Since your card was recognized as STDSP24, it means that both cards
> have the same sub vendor/device id.  Thus it's difficult to guess
> which chip is.  Perhaps trying to detect ak4524 at first, then one
> can recognize it as DSP24 Value or not.

I asked Hoontech about that too.

> Do you mean whether the routing itself doesn't work, or ADC volumes
> cannot be controlled?  The routing is a generic function of ice1712,
> so this must work regardless of the card model.

Without my patch the volumes were not available and on the routing
page only the routing to S/PDIF was available. With my patch the
routing to H/W Out is awailable too (and works). The DAC & ADC volume
don't seem to work though.

christof
-- 
Christof Damian         
Technical Director, guideguide ltd.	            

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
