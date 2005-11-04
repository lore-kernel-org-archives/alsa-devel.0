From: David Smoot <davidsmoot@gmail.com>
Subject: Re: Question: setting up the hardware for alsa
Date: Fri, 4 Nov 2005 11:33:59 -0600
Message-ID: <b15982770511040933t2ee5ec9dke8b898929cb287e1@mail.gmail.com>
References: <b15982770511040749k3ccbaa07gcbd7bac05689a8e7@mail.gmail.com>
	 <436B88BE.1090106@superbug.co.uk>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_24507_18062557.1131125639661"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <436B88BE.1090106@superbug.co.uk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

------=_Part_24507_18062557.1131125639661
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Sorry, it appears I did not provide enough detail. I am playing with the
tutorial from the linuxjournal:
http://www.linuxjournal.com/article/6735

I can compile and run the first listing, it just prints out some variables
set up by the soundalib. But the second listing that actually calls
"snd_pcm_open"
fails because it cannot open the default device.

So I believe I am failing somewhere to set some variable or parameter that
tells ALSA what the default devices is. All I am doing so far is creating
the nodes and loading the sound modules. I'm thinking I am missing one more
step. Any suggestions?

David
On 11/4/05, James Courtier-Dutton <James@superbug.co.uk> wrote:
>
> David Smoot wrote:
> > Greetings, first post to the list and hopefully a simple question:
> >
> > My company builds Linux based telemetry systems. We are working on an
> > airborne telemetry platform. The customer has expressed a desire to
> record
> > the pilot voice traffic on the data stream with the other data from the
> > instruments.
> >
> > We use a stripped down kernel and build pretty much everything by hand.
> I'm
> > attempting to set up ALSA so I can pull the audio data from the line in=
.
> >
> > At this point I at least knew libasound was OK because I could execute
> some
> > simple code that listed libasound data types and parameters.
> >
> > But I can't open any devices and talk to them. I know I am missing some
> kind
> > of crucial step in setting up the hw:0,0 device but I can't seem to
> figure
> > out the next step. I've read tutorials, googled, but I am stuck. If
> someone
> > would point me to the proper documents I would be grateful.
> >
> > David
> >
>
> The ca0106 alsa driver is quite new and as such might not be the most
> reliable driver to use for avionics systems. Line in/Mic input was only
> recently added to the driver, so it would be important for you to tell
> us which alsa version you are using. The following will tell you.
> cat /proc/asound/version.
>
> Another problem you will have is noise on the input. Special care has to
> be taken when recording voice in an aircraft.
>
> A good application to use to test voice capture is arecord.
> The ca0106 card is very basic, and you should only really use a capture
> rate of 48000 Hz if you want any sort of quality captured. You can
> resample it in your application to a lower rate, or compress it using a
> codec before transmission over the telemetry link. The ca0106 is
> particulary bad at 44100 Hz, but should be ok at rates 24000, 12000,8000
> Hz
>
> You should open the devices directly, but instead use the libasound
> snd_pcm_open() call.
>
> James
>
>

------=_Part_24507_18062557.1131125639661
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Sorry, it appears I did not provide enough detail.&nbsp; I am playing with =
the tutorial from the linuxjournal:<br>
<a href=3D"http://www.linuxjournal.com/article/6735">http://www.linuxjourna=
l.com/article/6735</a><br>
<br>
I can compile and run the first listing, it just prints out some
variables set up by the soundalib.&nbsp; But the second listing that
actually calls <tt>&quot;snd_pcm_open&quot;</tt><br>
fails because it cannot open the default device.&nbsp; <br>
<br>
So I believe I am failing somewhere to set some variable or parameter
that tells ALSA what the default devices is.&nbsp; All I am doing so
far is creating the nodes and loading the sound modules.&nbsp;
I'm&nbsp; thinking I am missing one more step.&nbsp; Any suggestions?<br>
<br>
David<br>
<span style=3D"font-family: monospace;"></span><div><span class=3D"gmail_qu=
ote">On 11/4/05, <b class=3D"gmail_sendername">James Courtier-Dutton</b> &l=
t;<a href=3D"mailto:James@superbug.co.uk">James@superbug.co.uk</a>&gt; wrot=
e:</span>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">David Smoot wrote=
:<br>&gt; Greetings, first post to the list and hopefully a simple question=
:
<br>&gt;<br>&gt; My company builds Linux based telemetry systems. We are wo=
rking on an<br>&gt; airborne telemetry platform. The customer has expressed=
 a desire to record<br>&gt; the pilot voice traffic on the data stream with=
 the other data from the
<br>&gt; instruments.<br>&gt;<br>&gt; We use a stripped down kernel and bui=
ld pretty much everything by hand. I'm<br>&gt; attempting to set up ALSA so=
 I can pull the audio data from the line in.<br>&gt;<br>&gt; At this point =
I at least knew libasound was OK because I could execute some
<br>&gt; simple code that listed libasound data types and parameters.<br>&g=
t;<br>&gt; But I can't open any devices and talk to them. I know I am missi=
ng some kind<br>&gt; of crucial step in setting up the hw:0,0 device but I =
can't seem to figure
<br>&gt; out the next step. I've read tutorials, googled, but I am stuck. I=
f someone<br>&gt; would point me to the proper documents I would be gratefu=
l.<br>&gt;<br>&gt; David<br>&gt;<br><br>The ca0106 alsa driver is quite new=
 and as such might not be the most
<br>reliable driver to use for avionics systems. Line in/Mic input was only=
<br>recently added to the driver, so it would be important for you to tell<=
br>us which alsa version you are using. The following will tell you.<br>
cat /proc/asound/version.<br><br>Another problem you will have is noise on =
the input. Special care has to<br>be taken when recording voice in an aircr=
aft.<br><br>A good application to use to test voice capture is arecord.
<br>The ca0106 card is very basic, and you should only really use a capture=
<br>rate of 48000 Hz if you want any sort of quality captured. You can<br>r=
esample it in your application to a lower rate, or compress it using a<br>
codec before transmission over the telemetry link. The ca0106 is<br>particu=
lary bad at 44100 Hz, but should be ok at rates 24000, 12000,8000 Hz<br><br=
>You should open the devices directly, but instead use the libasound<br>
snd_pcm_open() call.<br><br>James<br><br></blockquote></div><br>

------=_Part_24507_18062557.1131125639661--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
