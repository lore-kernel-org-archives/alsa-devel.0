From: Martin Langer <martin-langer@gmx.de>
Subject: Re: Getting actual sample rate
Date: Tue, 10 Jun 2003 19:12:10 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030610171210.GA501@tuba.home>
References: <3EE5FF42.5080107@iis.fhg.de> <E19Plpg-0005Nv-00@sc8-sf-list1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <E19Plpg-0005Nv-00@sc8-sf-list1.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Eric Allamanche <alm@iis.fhg.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 10, 2003 at 12:24:21PM -0400, Paul Davis wrote:
> >I'm using a digital Hammerfall audio card and was wondering how to 
> 
> which hammerfall? digi9652 or hdsp9652?
> 
> >figure out the sample rate of the ADAT input pcm stream (which can vary 
> >from 32kHZ to 96kHZ). I tried functions like 
> >snd_pcm_hw_params_get_rate() but they do not seem to give the right 
> >answer. Any hints?
> 
> the ALSA hardware parameter model doesn't include the notion of an
> "external rate". 
> 
> >BTW, when the input format changes, it would be great to be notified 
> >about this. Are there any notification handler which could be used for 
> >this purpose.
> 
> there is no way to differentiate between an ADAT signal at 32/44.1/48
> kHz and a "bit/channel stream format" at 64/88.2/96 kHz. so we can't
> tell you that. however, on the hdsp series, the "External Rate"
> control (read only) can be used to check the rate. i don't know
> off hand whether it can be used for notifications via blocking on
> read/poll for the control.
> 

Up to now, I thought ADAT was only defined for 44.1 and 48 kHz, but maybe
I'm wrong in this point. Ok, I believe that the hw doesn't use a restriction in
that point. But are there really any devices that can handle all those rates.

(I have asked rme a few month ago, and they told me that ADAT is only defined
for 44.1/48 kHz. But I've only asked them for 32kHz and not for the
double-speed modes, because I'm still living in a rme32 world;-) ) 

Hmm, does this info help in some way?


martin


-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
