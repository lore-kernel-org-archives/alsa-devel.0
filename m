From: Jon Grosshart <jgrosshart@gmail.com>
Subject: Re: kernel 2.6.14.x and alsamixer problems
Date: Sat, 26 Nov 2005 15:25:35 -0500
Message-ID: <9cf823c60511261225v6448a793xf0337d67ac677edf@mail.gmail.com>
References: <437EB3E6.6030205@gmail.com> <437F073D.4070906@superbug.co.uk>
	 <437FF88A.5070502@gmail.com> <43805484.70902@superbug.co.uk>
	 <9cf823c60511212148o2fa440b7vb3b151c97b1a78db@mail.gmail.com>
	 <9cf823c60511251409u49de1bd2u5621e54cedbe72f4@mail.gmail.com>
	 <1132972554.7393.11.camel@mindpipe>
	 <9cf823c60511261119j1e73a94cq1838239557527d00@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_23741_11219920.1133036735812"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <9cf823c60511261119j1e73a94cq1838239557527d00@mail.gmail.com>
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
Cc: James Courtier-Dutton <James@superbug.co.uk>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

------=_Part_23741_11219920.1133036735812
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 11/26/05, Jon Grosshart <jgrosshart@gmail.com> wrote:
>
>
> On 11/25/05, Lee Revell <rlrevell@joe-job.com> wrote:
> >
> > On Fri, 2005-11-25 at 17:09 -0500, Jon Grosshart wrote:
> >
> > Try this patch:
> >
> > --- /home/rlrevell/cvs/alsa/alsa-kernel/pci/emu10k1/emu10k1_main.c~
> > 2005-11-05 16:25:13.000000000 -0500
> > +++
> > /home/rlrevell/cvs/alsa/alsa-kernel/pci/emu10k1/emu10k1_main.c      200=
5-11-25
> > 15:28: 47.000000000 -0500
> > @@ -752,9 +752,16 @@
> >          .emu10k1_chip =3D 1,
> >          .ac97_chip =3D 1,
> >          .sblive51 =3D 1} ,
> > +       /* Tested by Alexandr 25th Nov 2005 */
> > +       {.vendor =3D 0x1102, .device =3D 0x0002, .subsystem =3D 0x80661=
102,
> > +        .driver =3D "EMU10K1", .name =3D "SB Live 5.1 [SB0220]",
> > +        .id =3D "Live",
> > +        .emu10k1_chip =3D 1,
> > +        .ac97_chip =3D 1,
> > +        .sblive51 =3D 1} ,
> >         /* Tested by Thomas Zehetbauer 27th Aug 2005 */
> >         {.vendor =3D 0x1102, .device =3D 0x0002, .subsystem =3D 0x80651=
102,
> > -        .driver =3D "EMU10K1", .name =3D "SB Live 5.1 [SB0220]",
> > +        .driver =3D "EMU10K1", .name =3D "SB Live 5.1 [SB0222]",
> >          .id =3D "Live",
> >          .emu10k1_chip =3D 1,
> >          .ac97_chip =3D 1,
> >
> >
> >
> >
> Well, I tried that just for grins but no joy. I even compiled ALL alsa
> packages against the modified C file just incase lib and utils used it.. =
It
> doesn't seem (to me) that this is a driver problem or a problem with my c=
ard
> not being identified correctly. As near as I can tell, that just adds SB0=
222
> to the index list of cards and possibly corrects a subsystem ID for SB022=
0.
> Thanks tho. I appreciate any effort given. I still get that error when
> running alsamixer tho.
>
> Now, I haven't tried using the kernel modules yet. I don't see how that
> will do anything as alsa-driver uses the same kernel source to build it's
> modules... :-) Any further thought is most welcome.
>


I did sit down and mess around with simple_none.c in alsa-lib and I got
everything to work. I can see your approach Lee with regards to the
subdevice. It does seem like it may be complaining about not finding the
subdevice ID.. However, this is what I did....

--- alsa-lib-1.0.10/src/mixer/simple_none.c.orig    2005-08-24 06:41:
16.000000000 -0400
+++ alsa-lib-1.0.10/src/mixer/simple_none.c    2005-11-26
14:58:10.000000000-0500
@@ -1214,8 +1214,7 @@
                 snd_hctl_elem_get_index(helem),
                 snd_hctl_elem_get_device(helem),
                 snd_hctl_elem_get_subdevice(helem));
-        err =3D -EINVAL;
-        goto __error;
+        return 0;
     }
     simple->ctls[type].elem =3D helem;
     simple->ctls[type].type =3D snd_ctl_elem_info_get_type(info);

I really hate to do that, but this is the main reason why I switched to *ni=
x
long ago.... If there's a problem, there's always a solution... All 6
speakers work and sound great now. I still get the error ofcourse but
atleast alsamixer doesn't crap out now. I suppose I could move up a few
lines and eliminate the SNDERR echo.... I'll leave it so it reminds me I'm
still running a hack.

And... I still hope to see a fix from within the kernel someday if that is
truely where the problem lies. Thanks again...

------=_Part_23741_11219920.1133036735812
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br><br><div><span class=3D"gmail_quote">On 11/26/05, <b class=3D"gmail_sen=
dername">Jon Grosshart</b> &lt;<a href=3D"mailto:jgrosshart@gmail.com">jgro=
sshart@gmail.com</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" sty=
le=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex;=
 padding-left: 1ex;">
<div><span class=3D"e" id=3D"q_107ce03a76175757_0"><br><div><span class=3D"=
gmail_quote">On 11/25/05, <b class=3D"gmail_sendername">Lee Revell</b> &lt;=
<a href=3D"mailto:rlrevell@joe-job.com" target=3D"_blank" onclick=3D"return=
 top.js.OpenExtLink(window,event,this)">
rlrevell@joe-job.com</a>&gt; wrote:</span><blockquote class=3D"gmail_quote"=
 style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.=
8ex; padding-left: 1ex;">
On Fri, 2005-11-25 at 17:09 -0500, Jon Grosshart wrote:<br><br>Try this pat=
ch:<br><br>--- /home/rlrevell/cvs/alsa/alsa-kernel/pci/emu10k1/emu10k1_main=
.c~&nbsp;&nbsp;&nbsp;&nbsp; 2005-11-05 16:25:13.000000000 -0500<br>+++ /hom=
e/rlrevell/cvs/alsa/alsa-kernel/pci/emu10k1/emu10k1_main.c&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;2005-11-25 15:28:
47.000000000 -0500<br>@@ -752,9 +752,16 @@<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; .emu10k1_chip =3D 1,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; .ac97_chip =3D 1,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; .sblive51 =3D 1} ,<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*=
 Tested by Alexandr 25th Nov 2005 */<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; {.vendor =3D 0x1102, .device =3D 0x0002, .subsystem =3D 0x80661102,
<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.driver =3D &quot;EMU1=
0K1&quot;, .name =3D &quot;SB Live 5.1 [SB0220]&quot;,<br>+&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.id =3D &quot;Live&quot;,<br>+&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.emu10k1_chip =3D 1,<br>+&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.ac97_chip =3D 1,<br>+&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;.sblive51 =3D 1} ,<br>&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;/* Tested by Thomas Zehetbauer 27th Aug 2005 */
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{.vendor =3D 0x1102, .d=
evice =3D 0x0002, .subsystem =3D 0x80651102,<br>-&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;.driver =3D &quot;EMU10K1&quot;, .name =3D &quot;SB L=
ive 5.1 [SB0220]&quot;,<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;.driver =3D &quot;EMU10K1&quot;, .name =3D &quot;SB Live=20
5.1 [SB0222]&quot;,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .id=
 =3D &quot;Live&quot;,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
.emu10k1_chip =3D 1,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .a=
c97_chip =3D 1,<br><br><br><br></blockquote></div><br></span></div>
Well, I tried that just for grins but no joy. I even compiled ALL alsa
packages against the modified C file just incase lib and utils used
it.. It doesn't seem (to me) that this is a driver problem or a problem
with my card not being identified correctly. As near as I can tell,
that just adds SB0222 to the index list of cards and possibly corrects
a subsystem ID for SB0220. Thanks tho. I appreciate any effort given. I
still get that error when running alsamixer tho.<br>
<br>
Now, I haven't tried using the kernel modules yet. I don't see how that
will do anything as alsa-driver uses the same kernel source to build
it's modules... :-) Any further thought is most welcome.<br>

</blockquote></div><br>
<br>
I did sit down and mess around with simple_none.c in alsa-lib and I got
everything to work. I can see your approach Lee with regards to the
subdevice. It does seem like it may be complaining about not finding
the subdevice ID.. However, this is what I did....<br>
<br>
--- alsa-lib-1.0.10/src/mixer/simple_none.c.orig&nbsp;&nbsp;&nbsp; 2005-08-=
24 06:41:16.000000000 -0400<br>
+++ alsa-lib-1.0.10/src/mixer/simple_none.c&nbsp;&nbsp;&nbsp; 2005-11-26 14=
:58:10.000000000 -0500<br>
@@ -1214,8 +1214,7 @@<br>
&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;=
&nbsp; snd_hctl_elem_get_index(helem),<br>
&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;=
&nbsp; snd_hctl_elem_get_device(helem),<br>
&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;=
&nbsp; snd_hctl_elem_get_subdevice(helem));<br>
-&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; err =3D -EINVAL;<br>
-&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; goto __error;<br>
+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp; simple-&gt;ctls[type].elem =3D helem;<br>
&nbsp;&nbsp;&nbsp;&nbsp; simple-&gt;ctls[type].type =3D snd_ctl_elem_info_g=
et_type(info);<br>
<br>
I really hate to do that, but this is the main reason why I switched to
*nix long ago.... If there's a problem, there's always a solution...
All 6 speakers work and sound great now. I still get the error ofcourse
but atleast alsamixer doesn't crap out now. I suppose I could move up a
few lines and eliminate the SNDERR echo.... I'll leave it so it reminds
me I'm still running a hack.<br>
<br>
And... I still hope to see a fix from within the kernel someday if that is =
truely where the problem lies. Thanks again...<br>

------=_Part_23741_11219920.1133036735812--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
