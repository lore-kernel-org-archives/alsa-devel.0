From: Patrick Dumais <pat@dumaisnet.ca>
Subject: Re: hardware channel mixing
Date: Fri, 3 Sep 2004 10:34:00 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0409031029270.10140@pat.dumaisnet.ca>
References: <Pine.HPX.4.33n.0409031451550.24397-100000@studcom.urz.uni-halle.de>
 <Pine.LNX.4.58.0409030913180.9962@pat.dumaisnet.ca> <20040903155801.1ae48548@mango.fruits.de>
 <Pine.LNX.4.58.0409030957010.9962@pat.dumaisnet.ca> <20040903163146.110c2ba0@mango.fruits.de>
Reply-To: pat@dumaisnet.ca
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040903163146.110c2ba0@mango.fruits.de>
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


yeah I didnt wanna talk about latency because im not sure what causes my
app to run "not smooth" (sorry for my english). maybe its the sound
processing or it might just be the fact that i'm running too much apps on
this computer at the same time. But i'll take your advice.

The thing is I never used a sampler in my life. I'm designing this because
I had an idea in my head and wanted to play samples by using my midi
controller. This is all experimental. So you're telling me that a real
sampler would not clip the sound? would not adjust the volume of each
samples automaticaly (is this what a compressor is used for?)?

I will join the channel this weekend or during next week, you guys seem to
know where to guide me.

Thank you


Patrick Dumais
****************************
http://www.dumaisnet.ca:242/

On Fri, 3 Sep 2004, Florian Schmidt wrote:

> Date: Fri, 3 Sep 2004 16:31:46 +0200
> From: Florian Schmidt <mista.tapas@gmx.net>
> To: pat@dumaisnet.ca
> Cc: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@lists.sourceforge.net
> Subject: Re: [Alsa-devel] hardware channel mixing
>
> On Fri, 3 Sep 2004 10:04:29 -0400 (EDT)
> Patrick Dumais <pat@dumaisnet.ca> wrote:
>
> >
> > That's the thing. I'm writing a soft-sampler. meaning that I have
> > multiple samples playing at one time when the user presses the keys on
> > his midi keyboard. I don't like software mixing because I feel I could
> > gain quality by relying on the hardware (am I right?).
>
> No.
>
> > And I also want my app to go
> > faster by letting the hardware do this job. But I realize that opening
> > 16 devices (16voice polyphony for my app) can be ressource consuming,
> > so it's a drawback. I'm not too sure what to do.
>
> Also this will not help you any at all in avoiding latency [btw: what
> are you referring to as "go faster"?]. And yes, opening 16 devices is
> resource consuming..
>
> >
> > Mixing is a little bit more than adding the samples together, you have
> > to do clipping and there is also a method shown on
> > http://www.vttoth.com/digimix.htm
>
> That method sounds like it's inappropriate for a soft sampler. Mixing is
> adding. period. The user will have to make sure not to bust the headroom
> by adjusting the samples gains. A method like in the link is maybe
> useful for game sound systems, etc.. but a professional audio app should
> avoid such approaches like hell. If you want to make sure you don't
> bust the headroom, use a hardlimiter[and process everything in a
> datatype that can hold the intermediate result], but i wouldn't want my
> sampler to tinker with the dynamics at all if not explicitly requested.
>
> > to make prevent one sound to be higher than the other one when one has
> > a silence in it. With that in mind I think I could get a high quality
> > sound for my app, but would it be worth all the processing? should I
> > still use more than one device instead, assuming that I would include
> > but functionalyties for users that don't have a compatible sound card.
>
> flo
>
> P.S.: you should come join the #lad channel on irc.freenode.org. there
> we can discuss in RT. I hang around there in the evening [gmt] usually
>
> P.P.S.: If you want to avoid all the alsa pcm troubles i strongly
> recommend using jack
>


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
