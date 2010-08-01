From: fons-5YXofNvN5bf4jJi9/k9gcg@public.gmane.org
Subject: Re: [LAD] announcing envy24control, mudita (*) edition.
Date: Mon, 2 Aug 2010 00:54:10 +0200
Message-ID: <20100801225410.GF4060@zita2>
References: <AANLkTikX07nHbBsBSG04r54LEp3R+CRC9dC--aB_h2gQ@mail.gmail.com>
	<201007282012.39291.termtech@rogers.com>
	<201007282110.33065.termtech@rogers.com>
	<201007311506.56614.termtech@rogers.com>
	<AANLkTik61RwcMtZQ6VsD7JHtvdC9F=N2kgjiS9JoMiV9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-audio-dev-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <AANLkTik61RwcMtZQ6VsD7JHtvdC9F=N2kgjiS9JoMiV9-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.linuxaudio.org/options/linux-audio-dev>,
	<mailto:linux-audio-dev-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxaudio.org/pipermail/linux-audio-dev>
List-Post: <mailto:linux-audio-dev-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>
List-Help: <mailto:linux-audio-dev-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linuxaudio.org/listinfo/linux-audio-dev>,
	<mailto:linux-audio-dev-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: linux-audio-dev-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org
Errors-To: linux-audio-dev-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org
To: Niels Mayer <nielsmayer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, john ffitch <jpff-fisDSsGP9JO9FHfhHBbuYA@public.gmane.org>, Bob Wilkinson <wilkinson.bob-Wuw85uim5zDR7s880joybQ@public.gmane.org>, linux-audio-dev-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Jul 31, 2010 at 11:24:31PM -0700, Niels Mayer wrote:

> The main thing I haven't been able to resolve is Fons' complaint
> regarding the DAC Volumes in "Analog Volume" panel not all being the
> same height, due to a -10/+4 radiobox that only appears in first DAC
> column for the Terratec EWS88MT; this radiobox causes the associated
> slider to be shorter than the other channels. Shouldn't this radiobox
> appear in all DAC columns?.

No, it's one switch for all channels.

> Is this a regression in "mudita24" or a feature request for standard
> "envy24control"? I didn't change this  aspect of the code, as far as
> I can tell.

The original has the same problem. Don't waste your time with it
unless someone else thinks it matters. As said I have fixed levels
on all channels, I don't ever use the mixer (as the card is connected
to a real mixer anyway), and everything is initialised by an alsactl
restore on booting. So in practice I never use envy24control. 

Apart from that, I just don't understand why I toolkit like GTK
apparently makes it difficult to  get such a simple thing right.
Same for the faders. 

Ciao,

-- 
FA

There are three of them, and Alleline.
