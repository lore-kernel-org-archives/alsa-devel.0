From: Patrick Dumais <pat@dumaisnet.ca>
Subject: Re: hardware channel mixing
Date: Fri, 3 Sep 2004 10:04:29 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0409030957010.9962@pat.dumaisnet.ca>
References: <Pine.HPX.4.33n.0409031451550.24397-100000@studcom.urz.uni-halle.de>
 <Pine.LNX.4.58.0409030913180.9962@pat.dumaisnet.ca> <20040903155801.1ae48548@mango.fruits.de>
Reply-To: pat@dumaisnet.ca
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040903155801.1ae48548@mango.fruits.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


That's the thing. I'm writing a soft-sampler. meaning that I have multiple
samples playing at one time when the user presses the keys on his midi
keyboard. I don't like software mixing because I feel I could gain quality
by relying on the hardware (am I right?). And I also want my app to go
faster by letting the hardware do this job. But I realize that opening 16
devices (16voice polyphony for my app) can be ressource consuming, so it's
a drawback. I'm not too sure what to do.

Mixing is a little bit more than adding the samples together, you have to
do clipping and there is also a method shown on
http://www.vttoth.com/digimix.htm
to make prevent one sound to be higher than the other one when one has a
silence in it. With that in mind I think I could get a high quality sound
for my app, but would it be worth all the processing? should I still use
more than one device instead, assuming that I would include but
functionalyties for users that don't have a compatible sound card.

Your help is very appreciated

Patrick Dumais
****************************
http://www.dumaisnet.ca:242/

On Fri, 3 Sep 2004, Florian Schmidt wrote:

> Date: Fri, 3 Sep 2004 15:58:01 +0200
> From: Florian Schmidt <mista.tapas@gmx.net>
> To: pat@dumaisnet.ca
> Cc: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@lists.sourceforge.net
> Subject: Re: [Alsa-devel] hardware channel mixing
>
> On Fri, 3 Sep 2004 09:15:06 -0400 (EDT)
> Patrick Dumais <pat@dumaisnet.ca> wrote:
>
> >
> > Thanks a lot, I've been looking for that information.
> >
> > So this would mean that the only solution would be to snd_pcm_open() a
> > device for each sound file that I want to play simultenaously?
>
> If you are programming an app that needs to play several sounds at once,
> it is a very bad idea to rely on the hardware provifding hw mixing. Most
> SC's do not provide hw mixing.
>
> So the solution really is to do the mixing yourself before sending the
> sound to the soundcard [mixing sounds is pretty trivial -> add them.
> only take care about the headroom].
>
> OTOH: if you write this app only for yourself and you know you will
> always use a SC with hw mixing, feel free to use snd_pcm_open for every
> sound you play..
>
> flo
>


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
