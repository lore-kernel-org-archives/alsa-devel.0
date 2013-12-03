From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: What-did-you-plugin-dialog
Date: Tue, 3 Dec 2013 11:07:12 +0800
Message-ID: <CAN8cciaHThypbmwcXJja31O4VGbPUa=Tea9UbhR6avkCRaScgw@mail.gmail.com>
References: <52947A6E.6010302@canonical.com>
	<1385470453.2226.26.camel@tkkaskin-mobl2.ger.corp.intel.com>
	<52949CCA.2060601@canonical.com>
	<1385473638.2226.48.camel@tkkaskin-mobl2.ger.corp.intel.com>
	<52951347.9000200@canonical.com> <5295A121.2010202@gmail.com>
	<5295A7C2.2090100@canonical.com>
	<CAN_LGv1F4cTB2cK+rL30N3nbbwyxi23cLYHR6emMC5CbNLP4jQ@mail.gmail.com>
	<CAN_LGv0y2WcYMn8M5rjT1d-2jahh_u-W2D_LnRkMsXXD=ENzdA@mail.gmail.com>
	<CAN8cciZ-y397dLGV_xC3xibo3PY9aE-RYQEB4_dkwRtzN+JnqQ@mail.gmail.com>
	<CAN_LGv02cPydDkvP-AZ+EzkF9TVvm1ij0-6vjzp0YWbieg7_fQ@mail.gmail.com>
	<CAN8cciYnQZQzyRmz_=gLLF6w7p3CZbZPKwYZtJpTHEaN3UOt_Q@mail.gmail.com>
	<CAN_LGv0F6g6L41Se72zdaq4u0DAPJzRc4ZwCMqPPJ06TCFS=qA@mail.gmail.com>
	<CAN8ccibLpVXqcHHdJwfv=_FF8z2hE6frsY8Gg6NRNQibsu2Okw@mail.gmail.com>
	<CAN_LGv2+vmTu_Fu6ONo8UwQFejC2K7ZFUKvODb34kronqAZf=A@mail.gmail.com>
Reply-To: General PulseAudio Discussion
	<pulseaudio-discuss@lists.freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1766301992=="
Return-path: <pulseaudio-discuss-bounces@lists.freedesktop.org>
In-Reply-To: <CAN_LGv2+vmTu_Fu6ONo8UwQFejC2K7ZFUKvODb34kronqAZf=A@mail.gmail.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@lists.freedesktop.org>
List-Help: <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=subscribe>
Sender: pulseaudio-discuss-bounces@lists.freedesktop.org
Errors-To: pulseaudio-discuss-bounces@lists.freedesktop.org
To: General PulseAudio Discussion <pulseaudio-discuss@lists.freedesktop.org>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--===============1766301992==
Content-Type: multipart/alternative; boundary=089e0149bc24d0082104ec98975a

--089e0149bc24d0082104ec98975a
Content-Type: text/plain; charset=UTF-8

>> >

> >> > can you try the patch which add "channel mode" control which allow you
> >> > to
> >> > switch from 6ch to 8ch
> >>
> >> I have tested the patch. In 8ch mode, it works without any overrides
> >> in the sense that the side channels go to the blue jack if I choose
> >> 8ch mode. In the 6ch mode, the line input also works (tested by using
> >> headphones as a very bad microphone-like source).
> >>
> >> Here is alsa-info in the 6ch mode:
> >>
> >>
> http://www.alsa-project.org/db/?f=d152698d4b2d9589d4c5f14e0c8e6d4978c8fbd0
> >>
> >> And in 8ch mode:
> >>
> >>
> http://www.alsa-project.org/db/?f=4d5d14fbb559819fd82e7731e656be7efcfab439
> >>
> >> Pulseaudio is not smart enough to decide by itself that it can toggle
> >> the control and add 7.1 profiles. If I toggle the control manually and
> >> restart pulseaudio, they appear.
> >>
> >> If the role of the "Line jack" control is still unclear, just say so
> >> and tell me what to do to figure it out.
> >>
>
> I will test everything later today, when I return home. However, I
> have questions about the tests.
>
> > In 8ch mode, do the "Line jack" return true when you plugged "Side
> Speaker"
> > ?
>
> Do I understand correctly that I need to look at "amixer -c1 contents"
> output?
>
> > Should changes in "channel mode" , "Headphone Mic jack mode" or "Mic Jack
> > Mode" trigger an event so that pulseaudio server probe the sound card
> again
> > ?
>
> How can I verify this? Is it enough to look at pulseaudio -vvv output?
>
>
if your computer chassis does not have front audio panel and you want to
use headphone with line out jacks the rear panel

just use early patching to  add hints

add_out_jack_modes=1

or

add the following line to patch_realtek.c

spec->gen.add_jack_modes = 1

this create "Line Out Jack Mode" control on those line out jacks and
"Headphone Jack Mode" on headphone jacks which pincap support OUT and HP,

your headphone plugged into Line Out jack still be regarded as Line Out
and use Front Playback Volume

http://cgit.freedesktop.org/pulseaudio/pulseaudio/commit/src/modules/alsa/mixer/profile-sets/default.conf?id=ecf3ab2b5788c85c237eeb6429bd1d525b9ac0cc

http://cgit.freedesktop.org/pulseaudio/pulseaudio/tree/src/modules/alsa/mixer/paths/analog-output-lineout.conf

as add_out_jack_modes is depreciated , you will have "Front Mic Jack Mode"
, "Rear Mic Jack Mode" and "Line Jack Mode" controls

The function of these kind of controls are to change the function of the
corresponding jacks

the function of the "channel mode" control have one more function in
addition to change the input jacks to surround output jacks ,is to change
playback mode from stereo to support multi-channels playback

however "channel mode" change to "8ch" does not imply "Line in" jack must
be retasked (e.g. both rear mic and line in are retaskable)


for those 3stack desktop Line In is retasked as output but for those 5
stack desktop , Line In is still input jacks when "channel mode" is "6ch"

the possible way is to check the pin ctls and vref of the node is match
with the name of the jack detection control, also the driver might set pin
ctl to zero to mute the output

Node 0x1a [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
  Control: name="Side Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Line Boost Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Line Jack", index=0, device=0
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x03 0x03]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x00003736: IN OUT Detect Trigger
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x0181305f: [Jack] Line In at Ext Rear
    Conn = 1/8, Color = Blue
    DefAssociation = 0x5, Sequence = 0xf
  Pin-ctls: 0x40: OUT VREF_HIZ
  Unsolicited: tag=04, enabled=1
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 5
     0x0c 0x0d 0x0e 0x0f* 0x26

--089e0149bc24d0082104ec98975a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">&gt;&gt; &gt;<br><div class=3D"gmail_extra"><div class=3D"=
gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div><div>

&gt;&gt; &gt; can you try the patch which add &quot;channel mode&quot; cont=
rol which allow you<br>
&gt;&gt; &gt; to<br>
&gt;&gt; &gt; switch from 6ch to 8ch<br>
&gt;&gt;<br>
&gt;&gt; I have tested the patch. In 8ch mode, it works without any overrid=
es<br>
&gt;&gt; in the sense that the side channels go to the blue jack if I choos=
e<br>
&gt;&gt; 8ch mode. In the 6ch mode, the line input also works (tested by us=
ing<br>
&gt;&gt; headphones as a very bad microphone-like source).<br>
&gt;&gt;<br>
&gt;&gt; Here is alsa-info in the 6ch mode:<br>
&gt;&gt;<br>
&gt;&gt; <a href=3D"http://www.alsa-project.org/db/?f=3Dd152698d4b2d9589d4c=
5f14e0c8e6d4978c8fbd0" target=3D"_blank">http://www.alsa-project.org/db/?f=
=3Dd152698d4b2d9589d4c5f14e0c8e6d4978c8fbd0</a><br>
&gt;&gt;<br>
&gt;&gt; And in 8ch mode:<br>
&gt;&gt;<br>
&gt;&gt; <a href=3D"http://www.alsa-project.org/db/?f=3D4d5d14fbb559819fd82=
e7731e656be7efcfab439" target=3D"_blank">http://www.alsa-project.org/db/?f=
=3D4d5d14fbb559819fd82e7731e656be7efcfab439</a><br>
&gt;&gt;<br>
&gt;&gt; Pulseaudio is not smart enough to decide by itself that it can tog=
gle<br>
&gt;&gt; the control and add 7.1 profiles. If I toggle the control manually=
 and<br>
&gt;&gt; restart pulseaudio, they appear.<br>
&gt;&gt;<br>
&gt;&gt; If the role of the &quot;Line jack&quot; control is still unclear,=
 just say so<br>
&gt;&gt; and tell me what to do to figure it out.<br>
&gt;&gt;<br>
<br>
</div></div>I will test everything later today, when I return home. However=
, I<br>
have questions about the tests.<br>
<div><br>
&gt; In 8ch mode, do the &quot;Line jack&quot; return true when you plugged=
 &quot;Side Speaker&quot;<br>
&gt; ?<br>
<br>
</div>Do I understand correctly that I need to look at &quot;amixer -c1 con=
tents&quot; output?<br>
<div><br>
&gt; Should changes in &quot;channel mode&quot; , &quot;Headphone Mic jack =
mode&quot; or &quot;Mic Jack<br>
&gt; Mode&quot; trigger an event so that pulseaudio server probe the sound =
card again<br>
&gt; ?<br>
<br>
</div>How can I verify this? Is it enough to look at pulseaudio -vvv output=
?<br>
<div><div><br></div></div></blockquote></div><br></div><div class=3D"gmail_=
extra">if your computer chassis does not have front audio panel and you wan=
t to use headphone with line out jacks the rear panel <br><br></div><div cl=
ass=3D"gmail_extra">
just use early patching to=C2=A0 add hints <br><br></div><div class=3D"gmai=
l_extra">add_out_jack_modes=3D1 <br><br></div><div class=3D"gmail_extra">or=
<br><br></div><div class=3D"gmail_extra">add the following line to patch_re=
altek.c<br>
<br></div><div class=3D"gmail_extra">spec-&gt;gen.add_jack_modes =3D 1<br><=
br></div><div class=3D"gmail_extra">this create &quot;Line Out Jack Mode&qu=
ot; control on those line out jacks and &quot;Headphone Jack Mode&quot; on =
headphone jacks which pincap support OUT and HP,<br>
<br></div><div class=3D"gmail_extra">your headphone plugged into Line Out j=
ack still be regarded as Line Out=C2=A0 and use Front Playback Volume <br><=
br><a href=3D"http://cgit.freedesktop.org/pulseaudio/pulseaudio/commit/src/=
modules/alsa/mixer/profile-sets/default.conf?id=3Decf3ab2b5788c85c237eeb642=
9bd1d525b9ac0cc">http://cgit.freedesktop.org/pulseaudio/pulseaudio/commit/s=
rc/modules/alsa/mixer/profile-sets/default.conf?id=3Decf3ab2b5788c85c237eeb=
6429bd1d525b9ac0cc</a><br>
</div><div class=3D"gmail_extra"><br><a href=3D"http://cgit.freedesktop.org=
/pulseaudio/pulseaudio/tree/src/modules/alsa/mixer/paths/analog-output-line=
out.conf">http://cgit.freedesktop.org/pulseaudio/pulseaudio/tree/src/module=
s/alsa/mixer/paths/analog-output-lineout.conf</a><br>
</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">as ad=
d_out_jack_modes is depreciated , you will have &quot;Front Mic Jack Mode&q=
uot; , &quot;Rear Mic Jack Mode&quot; and &quot;Line Jack Mode&quot; contro=
ls<br>
</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">The f=
unction of these kind of controls are to change the function of the corresp=
onding jacks<br></div><div class=3D"gmail_extra"><br></div><div class=3D"gm=
ail_extra">
the function of the &quot;channel mode&quot; control have one more function=
 in addition to change the input jacks to surround output jacks ,is to chan=
ge playback mode from stereo to support multi-channels playback <br><br>
</div><div class=3D"gmail_extra">however &quot;channel mode&quot; change to=
 &quot;8ch&quot; does not imply &quot;Line in&quot; jack must=C2=A0 be reta=
sked (e.g. both rear mic and line in are retaskable)<br>
</div><div class=3D"gmail_extra"><br><br>for those 3stack desktop Line In i=
s retasked as output but for those 5 stack desktop , Line In is still input=
 jacks when &quot;channel mode&quot; is &quot;6ch&quot;<br><br></div><div c=
lass=3D"gmail_extra">
the possible way is to check the pin ctls and vref of the node is match wit=
h the name of the jack detection control, also the driver might set pin ctl=
 to zero to mute the output<br>
</div>
<div class=3D"gmail_extra"><br><pre>Node 0x1a [Pin Complex] wcaps 0x40058f:=
 Stereo Amp-In Amp-Out
  Control: name=3D&quot;Side Playback Switch&quot;, index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
  Control: name=3D&quot;Line Boost Volume&quot;, index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DIn, idx=3D0, ofs=3D0
  Control: name=3D&quot;Line Jack&quot;, index=3D0, device=3D0
  Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, mute=3D0
  Amp-In vals:  [0x03 0x03]
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x00003736: IN OUT Detect Trigger
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x0181305f: [Jack] Line In at Ext Rear
    Conn =3D 1/8, Color =3D Blue
    DefAssociation =3D 0x5, Sequence =3D 0xf
  Pin-ctls: 0x40: OUT VREF_HIZ
  Unsolicited: tag=3D04, enabled=3D1
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=3DD0, actual=3DD0
  Connection: 5
     0x0c 0x0d 0x0e 0x0f* 0x26</pre><br></div></div>

--089e0149bc24d0082104ec98975a--

--===============1766301992==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
pulseaudio-discuss mailing list
pulseaudio-discuss@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss

--===============1766301992==--
