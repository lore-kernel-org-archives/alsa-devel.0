From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Re: SB Live 5.1 Digital OEM [SB0220, (c) 2003]
Date: Tue, 6 Dec 2005 11:48:53 +0000
Message-ID: <ad2655cb0512060348o4d28abf6s@mail.gmail.com>
References: <20051116212639.GB13191@felix.mfa.kfki.hu>
	 <437B9D8A.7080109@superbug.co.uk> <s5hd5kalb06.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_3510_11357570.1133869733149"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hd5kalb06.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: James Courtier-Dutton <James@superbug.co.uk>, TAMAS Gergely <dice@mfa.kfki.hu>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

------=_Part_3510_11357570.1133869733149
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 06/12/05, Takashi Iwai <tiwai@suse.de> wrote:
>
> At Wed, 16 Nov 2005 20:58:50 +0000,
> James Courtier-Dutton wrote:
> >
> > TAMAS Gergely wrote:
> > > Hi!
> > >
> > > I've got an 'SB Live 5.1 Digital OEM' card, model number 'SB0220',
> > > (c) 2003.
> > >
> > > PCM playing and MIDI (i tested only these) works fine, but alsamixer
> and
> > > /proc/asound/cards shows 'unknown' as card type (on kernel 2.6.14,
> > > included alsa drivers).
> > >
> > > If it doesn't do any harm, maybe the following patch could be
> included.
> > >
> > > --- >>> --- >>> --- >>> ---
> > > --- emu10k1/emu10k1_main.c~ 2005-11-16 22:08:32.218141000 +0100
> > > +++ emu10k1/emu10k1_main.c  2005-11-16 22:20:24.575285000 +0100
> > > @@ -748,6 +748,12 @@
> > >      .emu10k1_chip =3D 1,
> > >      .ac97_chip =3D 1,
> > >      .sblive51 =3D 1} ,
> > > +   {.vendor =3D 0x1102, .device =3D 0x0002, .subsystem =3D 0x100a110=
2,
> > > +    .driver =3D "EMU10K1", .name =3D "SB Live 5.1 [SB0220]",
> > > +    .id =3D "Live",
> > > +    .emu10k1_chip =3D 1,
> > > +    .ac97_chip =3D 1,
> > > +    .sblive51 =3D 1} ,
> > >     {.vendor =3D 0x1102, .device =3D 0x0002, .subsystem =3D 0x8064110=
2,
> > >      .driver =3D "EMU10K1", .name =3D "SB Live 5.1",
> > >      .id =3D "Live",
> > > --- <<< --- <<< --- <<< ---
> > >
> > > Thanks in advance,
> > > Gergely
> > >
> >
> > Can you please add a signed off line:
> > Signed-off-by:  yourname <emailaddres>
>
> What about this patch now?  We can merge it without the credit,
> though...
>
>
> Takashi



Takashi,

If you want to merge it, please add a comment line above it with something
like:
/* Tested at 6-12-2005 by Gergely Tamas <dice@mfa.kfki.hu> */

That way, I can keep trace of which options have been tested, and which hav=
e
not.

------=_Part_3510_11357570.1133869733149
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div><span class=3D"gmail_quote">On 06/12/05, <b class=3D"gmail_sendername"=
>Takashi Iwai</b> &lt;<a href=3D"mailto:tiwai@suse.de">tiwai@suse.de</a>&gt=
; wrote:</span>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">At Wed, 16 Nov 2005 20:58:50 +00=
00,<br>James Courtier-Dutton wrote:<br>&gt;<br>&gt; TAMAS Gergely wrote:<br=
>
&gt; &gt; Hi!<br>&gt; &gt;<br>&gt; &gt; I've got an 'SB Live 5.1 Digital OE=
M' card, model number 'SB0220',<br>&gt; &gt; (c) 2003.<br>&gt; &gt;<br>&gt;=
 &gt; PCM playing and MIDI (i tested only these) works fine, but alsamixer =
and
<br>&gt; &gt; /proc/asound/cards shows 'unknown' as card type (on kernel 2.=
6.14,<br>&gt; &gt; included alsa drivers).<br>&gt; &gt;<br>&gt; &gt; If it =
doesn't do any harm, maybe the following patch could be included.<br>&gt; &=
gt;
<br>&gt; &gt; --- &gt;&gt;&gt; --- &gt;&gt;&gt; --- &gt;&gt;&gt; ---<br>&gt=
; &gt; --- emu10k1/emu10k1_main.c~ 2005-11-16 22:08:32.218141000 +0100<br>&=
gt; &gt; +++ emu10k1/emu10k1_main.c&nbsp;&nbsp;2005-11-16 22:20:24.57528500=
0 +0100
<br>&gt; &gt; @@ -748,6 +748,12 @@<br>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;.emu10k1_chip =3D 1,<br>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;.ac97_chip =3D 1,<br>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.sblive=
51 =3D 1} ,<br>&gt; &gt; +&nbsp;&nbsp; {.vendor =3D 0x1102, .device =3D 0x0=
002, .subsystem =3D 0x100a1102,<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;.driver =3D &quot;EMU10K1&quot;, .name =
=3D &quot;SB Live 5.1 [SB0220]&quot;,<br>&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp=
;.id =3D &quot;Live&quot;,<br>&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;.emu10k1_c=
hip =3D 1,<br>&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;.ac97_chip =3D 1,<br>&gt; =
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;.sblive51 =3D 1} ,
<br>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; {.vendor =3D 0x1102, .device =3D 0x00=
02, .subsystem =3D 0x80641102,<br>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;.driver =3D &quot;EMU10K1&quot;, .name =3D &quot;SB Live 5.1&quot;,<br>=
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.id =3D &quot;Live&quot;,<br>&=
gt; &gt; --- &lt;&lt;&lt; --- &lt;&lt;&lt; --- &lt;&lt;&lt; ---
<br>&gt; &gt;<br>&gt; &gt; Thanks in advance,<br>&gt; &gt; Gergely<br>&gt; =
&gt;<br>&gt;<br>&gt; Can you please add a signed off line:<br>&gt; Signed-o=
ff-by:&nbsp;&nbsp;yourname &lt;emailaddres&gt;<br><br>What about this patch=
 now?&nbsp;&nbsp;We can merge it without the credit,
<br>though...<br><br><br>Takashi</blockquote>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>Takashi,</div>
<div>&nbsp;</div>
<div>If you want to merge it, please add a comment line above it with somet=
hing like:</div>
<div>/* Tested at 6-12-2005 by Gergely Tamas &lt;<a onclick=3D"return top.j=
s.OpenExtLink(window,event,this)" href=3D"mailto:dice@mfa.kfki.hu">dice@mfa=
.kfki.hu</a>&gt; */</div>
<div>&nbsp;</div>
<div>That way, I can keep trace of which options have been tested, and whic=
h have not.</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div><br>&nbsp;</div>

------=_Part_3510_11357570.1133869733149--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
