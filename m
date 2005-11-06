From: David Smoot <davidsmoot@gmail.com>
Subject: Re: Question: setting up the hardware for alsa
Date: Sun, 6 Nov 2005 11:46:08 -0600
Message-ID: <b15982770511060946m696e8148w89a65833fc840808@mail.gmail.com>
References: <b15982770511040749k3ccbaa07gcbd7bac05689a8e7@mail.gmail.com>
	 <1131237903.6781.22.camel@mindpipe>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_1469_22876836.1131299168271"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1131237903.6781.22.camel@mindpipe>
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
List-Id: alsa-devel@alsa-project.org

------=_Part_1469_22876836.1131299168271
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I have to do a hand install... My box that I am wanting to eventually
capture data on is a very limited, special purpose device. It does not have
gcc or support for building native. Thanks for the tips though, it is good
to know what my configuration files are. I'm taking it easier and installin=
g
first on one of my full development systems.

David


On 11/5/05, Lee Revell <rlrevell@joe-job.com> wrote:
>
> On Fri, 2005-11-04 at 09:49 -0600, David Smoot wrote:
> > 5. I copied libasound to my libraries folder.
> >
> > At this point I at least knew libasound was OK because I could
> > execute some simple code that listed libasound data types and
> > parameters.
> >
> > But I can't open any devices and talk to them. I know I am missing
> > some kind of crucial step in setting up the hw:0,0 device but I can't
> > seem to figure out the next step. I've read tutorials, googled, but I
> > am stuck. If someone would point me to the proper documents I would
> > be grateful.
> >
>
> Ah, this is the problem. It's not sufficient to just copy the libasound
> binary into your LD_LIBRARY_PATH. Alsa-lib needs these files too:
>
> /usr/share/alsa/alsa.conf
> /usr/share/alsa/pcm/*
> /usr/share/alsa/cards/*
>
> Why not just run "make install" instead of trying to install alsa-lib by
> hand?
>
> Lee
>
>

------=_Part_1469_22876836.1131299168271
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I have to do a hand install... My box that I am wanting to eventually
capture data on is a very limited, special purpose device.&nbsp; It
does not have gcc or support for building native.&nbsp; Thanks for the
tips though, it is good to know what my configuration files are.&nbsp;
I'm taking it easier and installing first on one of my full development
systems.<br>
<br>
David<br>
<br><br><div><span class=3D"gmail_quote">On 11/5/05, <b class=3D"gmail_send=
ername">Lee Revell</b> &lt;<a href=3D"mailto:rlrevell@joe-job.com">rlrevell=
@joe-job.com</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=
=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; p=
adding-left: 1ex;">
On Fri, 2005-11-04 at 09:49 -0600, David Smoot wrote:<br>&gt; 5.&nbsp;&nbsp=
;I copied libasound to my libraries folder.<br>&gt;<br>&gt; At this point I=
 at least knew libasound was OK because I could<br>&gt; execute some simple=
 code that listed libasound data types and
<br>&gt; parameters.<br>&gt;<br>&gt; But I can't open any devices and talk =
to them.&nbsp;&nbsp;I know I am missing<br>&gt; some kind of crucial step i=
n setting up the hw:0,0 device but I can't<br>&gt; seem to figure out the n=
ext step.&nbsp;&nbsp;I've read tutorials, googled, but I
<br>&gt; am stuck.&nbsp;&nbsp;If someone would point me to the proper docum=
ents I would<br>&gt; be grateful.<br>&gt;<br><br>Ah, this is the problem.&n=
bsp;&nbsp;It's not sufficient to just copy the libasound<br>binary into you=
r LD_LIBRARY_PATH.&nbsp;&nbsp;Alsa-lib needs these files too:
<br><br>/usr/share/alsa/alsa.conf<br>/usr/share/alsa/pcm/*<br>/usr/share/al=
sa/cards/*<br><br>Why not just run &quot;make install&quot; instead of tryi=
ng to install alsa-lib by<br>hand?<br><br>Lee<br><br></blockquote></div>
<br>

------=_Part_1469_22876836.1131299168271--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
