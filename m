From: "Sergey Kolosov" <freeserj@gmail.com>
Subject: Re: question about closed source alsa driver
Date: Tue, 16 May 2006 23:26:47 +0400
Message-ID: <d39e2e70605161226i2234a968rd301315188fb5831@mail.gmail.com>
References: <d39e2e70605160318meac7c91g40bb9cd7a85c0665@mail.gmail.com>
	 <4469CE12.6090701@findus.dhs.org>
	 <d39e2e70605160637g153bd27ei3cc3dc28df59dba1@mail.gmail.com>
	 <1147791320.13948.111.camel@mindpipe>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_82103_23591658.1147807607623"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1147791320.13948.111.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: =?ISO-8859-1?Q?Petter_Sundl=F6f?= <petter.sundlof@findus.dhs.org>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

------=_Part_82103_23591658.1147807607623
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

It's not just a sound card. It's driver for device but sound is one of the
basic functions( still there are other parts, initialize mapping etc). Mayb=
e
I emit some functions to other module...

On 5/16/06, Lee Revell <rlrevell@joe-job.com> wrote:
>
> On Tue, 2006-05-16 at 17:37 +0400, Sergey Kolosov wrote:
> > Whether me interests if I shall write closed source alsa driver there
> > will be it violations gpl?
> >
>
> No you cannot.  The ALSA driver core is GPL so all drivers must be GPL.
>
> Why do you need to hide the hardware details?  It's just a sound card.
>
> Lee
>
> > On 5/16/06, Petter Sundl=F6f <petter.sundlof@findus.dhs.org> wrote:
> >         Question is, in my mind: Should you?
> >
> >         Sergey Kolosov wrote:
> >         > Can i  write closed source alsa-driver? If it possible what
> >         rules I must
> >         > succeed(etc. can I use alsa function or I must implement it
> >         anew?).
> >         >
> >         > P.S.
> >         > It is not my initiative, but license agreement.
> >
>
>

------=_Part_82103_23591658.1147807607623
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

It's not just a sound card. It's driver for device but sound is one <span i=
d=3D"r_text" name=3D"r_text">of the basic functions(</span><span id=3D"r_te=
xt" name=3D"r_text"> still there are other parts, initialize mapping etc</s=
pan><span id=3D"r_text" name=3D"r_text">
). Maybe I emit some functions to other module...</span><br><span id=3D"r_t=
ext" name=3D"r_text"></span><br><div><span class=3D"gmail_quote">On 5/16/06=
, <b class=3D"gmail_sendername">Lee Revell</b> &lt;<a href=3D"mailto:rlreve=
ll@joe-job.com">
rlrevell@joe-job.com</a>&gt; wrote:</span><blockquote class=3D"gmail_quote"=
 style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.=
8ex; padding-left: 1ex;">On Tue, 2006-05-16 at 17:37 +0400, Sergey Kolosov =
wrote:
<br>&gt; Whether me interests if I shall write closed source alsa driver th=
ere<br>&gt; will be it violations gpl?<br>&gt;<br><br>No you cannot.&nbsp;&=
nbsp;The ALSA driver core is GPL so all drivers must be GPL.<br><br>Why do =
you need to hide the hardware details?&nbsp;&nbsp;It's just a sound card.
<br><br>Lee<br><br>&gt; On 5/16/06, Petter Sundl=F6f &lt;<a href=3D"mailto:=
petter.sundlof@findus.dhs.org">petter.sundlof@findus.dhs.org</a>&gt; wrote:=
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Question is, in my=
 mind: Should you?<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; Sergey Kolosov wrote:
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; Can i&nbsp;&n=
bsp;write closed source alsa-driver? If it possible what<br>&gt;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rules I must<br>&gt;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; succeed(etc. can I use alsa function o=
r I must implement it<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; anew?).<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; P.S.<br>&gt;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; It is not my initiativ=
e, but license agreement.<br>&gt;<br><br></blockquote></div><br>

------=_Part_82103_23591658.1147807607623--


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
