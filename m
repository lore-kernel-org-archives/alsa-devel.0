From: "Mariusz Domanski" <surfer.q3@gmail.com>
Subject: Re: hda-intel,
	ALC861 and Asus A6rp laptop - problem with headphones almost solved
Date: Tue, 26 Sep 2006 17:43:26 +0200
Message-ID: <b209ae1e0609260843j1418adcbn154f8308842ac251@mail.gmail.com>
References: <b209ae1e0609231108i634d41fm87012983b4b9b83e@mail.gmail.com>
	<s5hpsdjj4mp.wl%tiwai@suse.de>
	<b209ae1e0609251125k399f7897jcf4d33d96d55055f@mail.gmail.com>
	<s5hmz8nt00v.wl%tiwai@suse.de>
	<b209ae1e0609260743kce76b90r15d4a8505657d146@mail.gmail.com>
	<s5h4puusmwc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1323311887=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5h4puusmwc.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--===============1323311887==
Content-Type: multipart/alternative;
	boundary="----=_Part_10543_22740245.1159285406510"

------=_Part_10543_22740245.1159285406510
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

2006/9/26, Takashi Iwai <tiwai@suse.de>:
>
> At Tue, 26 Sep 2006 16:43:32 +0200,
> Mariusz Domanski wrote:
> >
> > 2006/9/26, Takashi Iwai <tiwai@suse.de>:
> >
> >     >At Mon, 25 Sep 2006 20:25:50 +0200,
> >     >Mariusz Domanski wrote:
> >     >>
> >     >>
> >     > >2006/9/25, Takashi Iwai <tiwai@suse.de>:
> >     >>
> >     >>     >> Propably the sound will appear after (x)th compilation,
> but why? Why it
> >     is not
> >     >>     working
> >     >>     >> all the time?
> >     >>
> >     >>     >No idea.  A weird hardware...
> >     >>
> >     >>     >> And why the ALC861 is detected to be the ALC660?
> >     >>
> >     >>     >Simply because they are almost compatible (according to
> Realtek).
> >     >>
> >     >>     >The patch looks broken.  Could you regenerated it?
> >     >>
> >     >>     >thanks,
> >     >>
> >     >>     >Takashi
> >     >>
> >     >>  Here is patch (now I'll write it as a part of email):
> >     >
> >     >... and it's more broken now :)
> >     >
> >     >Could you give the correct patch as an attachment?
> >     >Also, try to avoid C++ style comments as much as possible.
> >     >
> >     >
> >     >Thanks,
> >     >
> >     >Takashi
> >
> > Ok, I really don't know why the patch doesn't want to work... It looks
> well, but
> > produces errors when applied...
> > Anyway, I'm sending attachement with modified patch_realtek.c and patch
> file which
> > should work but doesn't...
>
> Maybe the gzipped patch should have sufficed.  So, it's kept
> unmodified by the mailer.
>
> I'm now looking at your new patch, and found that you do _not_ comment
> out #if 0 for mic and line-in verbs as you did in the earlier patch.
> Namely, in the earler version:
>
> +//#if 0
> + { 0x15, AC_VERB_SET_AMP_GAIN_MUTE, (0x7080 | (0x01 << 8)) }, /*mic*/
> + { 0x15, AC_VERB_SET_AMP_GAIN_MUTE, (0x7080 | (0x02 << 8)) }, /*line in*/
> +//#endif
> + { } /* end */
>
> while the '//' are removed in the newer version.
> Is it intentional?
>
> Otherwise it looks fine.
>
>
> Thanks,
>
> Takashi
>

Well... It does't seem to make difference for me.. Now it does't want to
work with comment tags and withotu them... It only works _sometimes_.

I wrote in bugreport that when model=3stack is chosen and channel mode is
set to 6ch the line-in and mic works as output, but I can now tell you that
was one of these _sometimes_ and it worked only once, but worked, and there
in the sourcecode the #if 0 is not commented out. Later, when testing my
patch everything worked with #if 0 commented out.. So... It doesn't change
anything in my case...

I wasn't sure what i was doing writing this patch... :) I just read almost
whole patch_realtek.c and codec#0 output and saw that there is something
wrong... At first I was doing changes which had sense for me (mixer and pin
config from uniwill, 0x0e as HP, 2ch and 6ch modes from
3stack) but it didn't work, so I started to make other changes, when
changed HDA_INPUT to HDA_OUTPUT in the mixer, the sound appeard in the
mixer,
then I changed something in the code and recompiled Alsa, sound disappeard
so I was making other changeswas until I got sount in headphones. When I got
it, i also noticed that it is only to the next start of Alsa and this is the
point where I'm standing now and don't know what to do next... Even codec#0
outputs are same, when comparing the one when everything was working and the
one made now, when it doesn't work...

The situation is too complicated for me so I'm asking you for help, because
it is so close to the finish :)

------=_Part_10543_22740245.1159285406510
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br><br><div><span class=3D"gmail_quote">2006/9/26, Takashi Iwai &lt;<a hre=
f=3D"mailto:tiwai@suse.de">tiwai@suse.de</a>&gt;:</span><blockquote class=
=3D"gmail_quote" style=3D"margin-top: 0; margin-right: 0; margin-bottom: 0;=
 margin-left: 0; margin-left: 0.80ex; border-left-color: #cccccc; border-le=
ft-width: 1px; border-left-style: solid; padding-left: 1ex">
At Tue, 26 Sep 2006 16:43:32 +0200,<br>Mariusz Domanski wrote:<br>&gt;<br>&=
gt; 2006/9/26, Takashi Iwai &lt;<a href=3D"mailto:tiwai@suse.de">tiwai@suse=
.de</a>&gt;:<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;At Mon, 25 Sep 200=
6 20:25:50 +0200,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;Mariusz Domanski wrote:<br>&gt;&nbsp;&nbsp=
;&nbsp;&nbsp; &gt;&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;<br>&gt;&nbs=
p;&nbsp;&nbsp;&nbsp; &gt; &gt;2006/9/25, Takashi Iwai &lt;<a href=3D"mailto=
:tiwai@suse.de">tiwai@suse.de</a>&gt;:<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;=
&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&=
gt; Propably the sound will appear after (x)th compilation, but why? Why it
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; is not<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt=
;&gt;&nbsp;&nbsp;&nbsp;&nbsp; working<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&=
gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt; all the time?<br>&gt;&nbsp;&nbsp;&nbsp=
;&nbsp; &gt;&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;=
&nbsp; &gt;No idea.&nbsp;&nbsp;A weird hardware...<br>&gt;&nbsp;&nbsp;&nbsp=
;&nbsp; &gt;&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;=
&nbsp; &gt;&gt; And why the ALC861 is detected to be the ALC660?
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &=
gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;Simply because they are almost compatib=
le (according to Realtek).<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;<br>&gt;=
&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;The patch loo=
ks broken.&nbsp;&nbsp;Could you regenerated it?<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&=
gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;thanks,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt=
;&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;=
Takashi<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&=
nbsp; &gt;&gt;&nbsp;&nbsp;Here is patch (now I'll write it as a part of ema=
il):<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;... and it's more broken now :)<br>&gt=
;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;Could yo=
u give the correct patch as an attachment?<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; =
&gt;Also, try to avoid C++ style comments as much as possible.<br>&gt;&nbsp=
;&nbsp;&nbsp;&nbsp; &gt;
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;T=
hanks,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;=
 &gt;Takashi<br>&gt;<br>&gt; Ok, I really don't know why the patch doesn't =
want to work... It looks well, but<br>&gt; produces errors when applied...<=
br>
&gt; Anyway, I'm sending attachement with modified patch_realtek.c and patc=
h file which<br>&gt; should work but doesn't...<br><br>Maybe the gzipped pa=
tch should have sufficed.&nbsp;&nbsp;So, it's kept<br>unmodified by the mai=
ler.<br>
<br>I'm now looking at your new patch, and found that you do _not_ comment<=
br>out #if 0 for mic and line-in verbs as you did in the earlier patch.<br>=
Namely, in the earler version:<br><br>+//#if 0<br>+ { 0x15, AC_VERB_SET_AMP=
_GAIN_MUTE, (0x7080 | (0x01 &lt;&lt; 8)) }, /*mic*/
<br>+ { 0x15, AC_VERB_SET_AMP_GAIN_MUTE, (0x7080 | (0x02 &lt;&lt; 8)) }, /*=
line in*/<br>+//#endif<br>+ { } /* end */<br><br>while the '//' are removed=
 in the newer version.<br>Is it intentional?<br><br>Otherwise it looks fine=
.
<br><br><br>Thanks,<br><br>Takashi<br></blockquote></div><br>Well... It doe=
s't seem to make difference for me..&nbsp;Now it does't want to work with c=
omment&nbsp;tags and withotu them... It only works _sometimes_.<br><br>I wr=
ote in bugreport that when model=3D3stack&nbsp;is&nbsp;chosen and channel m=
ode is set to 6ch the line-in and mic works as output, but I can now tell y=
ou&nbsp;that was&nbsp;one&nbsp;of these _sometimes_ and it worked only once=
, but worked, and there in the sourcecode&nbsp;the&nbsp;#if&nbsp;0 is not c=
ommented out. Later, when testing my patch everything worked with #if 0 com=
mented out.. So... It doesn't change anything in my case...
<br><br>I wasn't sure what i was doing writing this patch... :) I just read=
 almost whole patch_realtek.c and codec#0 output and saw that there is some=
thing wrong... At first I was doing changes which had sense  for me (mixer =
and pin config from uniwill, 0x0e as HP, 2ch and 6ch modes from 3stack)&nbs=
p;but&nbsp;it&nbsp;didn't&nbsp;work,&nbsp;so&nbsp;I&nbsp;started&nbsp;to&nb=
sp;make&nbsp;other&nbsp;changes,&nbsp;when&nbsp;changed&nbsp;HDA_INPUT&nbsp=
;to&nbsp;HDA_OUTPUT&nbsp;in&nbsp;the&nbsp;mixer,&nbsp;the&nbsp;sound&nbsp;a=
ppeard&nbsp;in&nbsp;the&nbsp;mixer, then I changed something in&nbsp;the co=
de and recompiled Alsa, sound disappeard  so I was making other changeswas =
until I got sount in headphones. When I got it, i also noticed that it is o=
nly to the next start of Alsa and this is the point where I'm standing&nbsp=
;now and don't know what to do next... Even codec#0 outputs are same, when =
comparing the one when everything was working and the one&nbsp;made&nbsp;no=
w, when it doesn't work...
<br> <br>The situation is too complicated for me so I'm asking you for help=
, because  it is so close to the finish :)<br>

------=_Part_10543_22740245.1159285406510--


--===============1323311887==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1323311887==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1323311887==--
