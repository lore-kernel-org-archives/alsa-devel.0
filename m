From: Frank Smith <frsmith-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [LAD] digiface vs. multiface vs. jack vs. other cards
Date: Mon, 29 Mar 2010 23:48:45 +0100
Message-ID: <a5febbe81003291548y16d884ccq5a303386fd5b95a8@mail.gmail.com>
References: <1269884987.354.22.camel@localhost.localdomain>
Reply-To: frsmith-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8592310169699264528=="
Return-path: <linux-audio-dev-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>
In-Reply-To: <1269884987.354.22.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
List-Unsubscribe: <http://lists.linuxaudio.org/listinfo/linux-audio-dev>,
	<mailto:linux-audio-dev-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxaudio.org/pipermail/linux-audio-dev>
List-Post: <mailto:linux-audio-dev-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>
List-Help: <mailto:linux-audio-dev-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linuxaudio.org/listinfo/linux-audio-dev>,
	<mailto:linux-audio-dev-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-audio-dev-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org
Errors-To: linux-audio-dev-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org
To: Fernando Lopez-Lezcano <nando-l0SEpsmuUtBegcJQxxnBRDe48wsgrGvP@public.gmane.org>
Cc: ALSA development <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, linux-audio-dev-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org, Jack devel <jack-devel-jWNxllRMWAzQjzbLk4vjdkB+6BGkLq7r@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

--===============8592310169699264528==
Content-Type: multipart/alternative; boundary=001485f7231ec0cdf50482f850e5

--001485f7231ec0cdf50482f850e5
Content-Type: text/plain; charset=UTF-8

Hi Fernando
Can't help you on the coding but if you find a way to link two RME PCI hdsp
cards to show as one please pass this along.

I have two cards that I have to constantly change as the Bois seems to
change the order of the cards on Boot up ( I use jack to select the cards)


Cheers
Bob
Blueslsd



On 29 March 2010 18:49, Fernando Lopez-Lezcano <nando-l0SEpsmuUtBegcJQxxnBRDe48wsgrGvP@public.gmane.org>wrote:

> At CCRMA we have several studios with linux computers in them (in
> addition to computers sprinkled throughout the building). Some of the
> studios have digiface interfaces, some multiface. All of them are
> connected to the sound system or mixer digitally through adat
> lightpipes. Workstations have Delta 66 or Gina3G soundcards.
>
> It would be nice for a user to be able to play, say, a stereo Ardour
> session in any of them without any changes to the session or routing.
>
> The digifaces send channels 1-24 out the adat ports. The multifaces on
> the other hand send 9-16 on the adat port. Deltas and Ginas send out
> stuff on channels 1-4 or 1-6.
>
> You can see the multiface interfaces are a problem. To get sound out of
> them you have to send on channels 9-16 which is different from _all_
> others!
>
> I tried several workarounds without much success:
>
> a) fix this at the alsa level. Should be the way to go, right? Create
> an /etc/asound.conf that uses ttable to translate channels for the
> multifaces so that the digital out is actually sent through channels 1-8
> (and create the same name plug interface in all other computers that
> does nothing so that the user can set that name as the default in
> qjackctl and will get the same behavior in all computers).
>
> Works, but not quite. When I try to use that "fake" plug interface with
> jack2 I get a warning that I'm using a plug interface (sort of fair) and
> jack only opens it with _2_ i/o channels (even though the ttable is 18
> channels wide!). If I _force_ input and output channels in jack to 18 it
> does work fine. But now it will _not_ work on other computers that have
> less (or more) than 18 channels. Argh.
>
> b) fix it in hdspmixer. Well, it turns out that hdspmixer does not read
> the default matrix gains from a file so I can't really override the
> default. AFAICT the gains are calculated algorithmically in the code and
> there is no command line option to load presets from a file.
>
> Or I could write a small script that will set the right gains for 1-8 to
> go out through 9-16 but if a user starts hdspmixer that gets undone with
> no warning.
>
> And, of course:
>
> c) give up and connect an 8 channel analog snake to the analog outputs
> of the multifaces and do away with a digital connection to the mixer...
>
> Anyone has any other suggestions??
> This should be easy to fix, right?
> :-)
> -- Fernando
>
>
> _______________________________________________
> Linux-audio-dev mailing list
> Linux-audio-dev-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org
> http://lists.linuxaudio.org/listinfo/linux-audio-dev
>

--001485f7231ec0cdf50482f850e5
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Fernando<div>Can&#39;t help you on the coding but if you find a way to l=
ink two RME PCI hdsp cards to show as one please pass this along.</div><div=
><br></div><div>I have two cards that I have to constantly change as the Bo=
is seems to change the order of the cards on Boot up ( I use jack to select=
 the cards)</div>
<div><br></div><div><br></div><div>Cheers</div><div>Bob</div><div>Blueslsd<=
/div><div><br></div><div><br><br><div class=3D"gmail_quote">On 29 March 201=
0 18:49, Fernando Lopez-Lezcano <span dir=3D"ltr">&lt;<a href=3D"mailto:nan=
do-l0SEpsmuUtBegcJQxxnBRDe48wsgrGvP@public.gmane.org">nando-l0SEpsmuUtBegcJQxxnBRDe48wsgrGvP@public.gmane.org</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;">At CCRMA we have several studios with linux=
 computers in them (in<br>
addition to computers sprinkled throughout the building). Some of the<br>
studios have digiface interfaces, some multiface. All of them are<br>
connected to the sound system or mixer digitally through adat<br>
lightpipes. Workstations have Delta 66 or Gina3G soundcards.<br>
<br>
It would be nice for a user to be able to play, say, a stereo Ardour<br>
session in any of them without any changes to the session or routing.<br>
<br>
The digifaces send channels 1-24 out the adat ports. The multifaces on<br>
the other hand send 9-16 on the adat port. Deltas and Ginas send out<br>
stuff on channels 1-4 or 1-6.<br>
<br>
You can see the multiface interfaces are a problem. To get sound out of<br>
them you have to send on channels 9-16 which is different from _all_<br>
others!<br>
<br>
I tried several workarounds without much success:<br>
<br>
a) fix this at the alsa level. Should be the way to go, right? Create<br>
an /etc/asound.conf that uses ttable to translate channels for the<br>
multifaces so that the digital out is actually sent through channels 1-8<br=
>
(and create the same name plug interface in all other computers that<br>
does nothing so that the user can set that name as the default in<br>
qjackctl and will get the same behavior in all computers).<br>
<br>
Works, but not quite. When I try to use that &quot;fake&quot; plug interfac=
e with<br>
jack2 I get a warning that I&#39;m using a plug interface (sort of fair) an=
d<br>
jack only opens it with _2_ i/o channels (even though the ttable is 18<br>
channels wide!). If I _force_ input and output channels in jack to 18 it<br=
>
does work fine. But now it will _not_ work on other computers that have<br>
less (or more) than 18 channels. Argh.<br>
<br>
b) fix it in hdspmixer. Well, it turns out that hdspmixer does not read<br>
the default matrix gains from a file so I can&#39;t really override the<br>
default. AFAICT the gains are calculated algorithmically in the code and<br=
>
there is no command line option to load presets from a file.<br>
<br>
Or I could write a small script that will set the right gains for 1-8 to<br=
>
go out through 9-16 but if a user starts hdspmixer that gets undone with<br=
>
no warning.<br>
<br>
And, of course:<br>
<br>
c) give up and connect an 8 channel analog snake to the analog outputs<br>
of the multifaces and do away with a digital connection to the mixer...<br>
<br>
Anyone has any other suggestions??<br>
This should be easy to fix, right?<br>
:-)<br>
-- Fernando<br>
<br>
<br>
_______________________________________________<br>
Linux-audio-dev mailing list<br>
<a href=3D"mailto:Linux-audio-dev-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org">Linux-audio-dev@lis=
ts.linuxaudio.org</a><br>
<a href=3D"http://lists.linuxaudio.org/listinfo/linux-audio-dev" target=3D"=
_blank">http://lists.linuxaudio.org/listinfo/linux-audio-dev</a><br>
</blockquote></div><br></div>

--001485f7231ec0cdf50482f850e5--

--===============8592310169699264528==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-audio-dev mailing list
Linux-audio-dev-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org
http://lists.linuxaudio.org/listinfo/linux-audio-dev

--===============8592310169699264528==--
