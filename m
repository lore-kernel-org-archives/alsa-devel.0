From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: hw_params and approximate values
Date: Thu, 28 Aug 2003 13:40:01 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0308281334210.1958-100000@pnote.perex-int.cz>
References: <oprukrmaexq1sf88@mail.broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <oprukrmaexq1sf88@mail.broadpark.no>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Arve Knudsen <aknuds-1@broadpark.no>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 27 Aug 2003, Arve Knudsen wrote:

> On Fri, 22 Aug 2003 15:11:08 +0200 (CEST), Jaroslav Kysela <perex@suse.cz> 
> wrote:
> 
> > On Thu, 21 Aug 2003, Arve Knudsen wrote:
> >
> >> Hi
> >>
> >> I'm not sure if I quite understand the alsa-lib docs regarding the
> >> snd_pcm_hw_params API; in addition to an approximate integer value, one
> >> might specify a direction. Is the direction parameter a way to instruct
> >> ALSA to look for a floating point value in either direction? If that's 
> >> the
> >> case, couldn't this be handled with floats directly?
> >
> > The direction means:
> >
> > 0 = use exactly equal number
> > -1 = use the most close previous number
> > 1 = use the most close next number
> >
> > You may also get most close value using the *_near() function. In this
> > case, the direction selection is left on the library or driver code.
> >
> > Regarding floats, we cannot use floats in a simple way in kernel so it's
> > better to avoid this requirement.
> 
> By most close, do you mean the nearest supported integer value, or 
> floating point value? The terminology is a little unclear to me, but the 
> existance of a set_integer method leads me to believe the latter is 
> correct. I was meaning to use set_rate_near() to find me a suitable 
> default samplerate, but if it returns an approximate (floating point) 
> value, I would like to be able to report the exact value. The code is 

For rate, use snd_pcm_hw_params_get_rate_numden() function which returns 
the floating point value in fraction. Other values are always processed as 
integers in the driver (with possible rounding). And yes, the most close 
value might be a floating point one but rounded to the integer value.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
