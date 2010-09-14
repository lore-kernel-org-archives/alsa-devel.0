From: Niels Mayer <nielsmayer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [LAU] [alsa-devel] Terratec EWS88D (ice1712) optical stuck on
 ADAT (no IEC958 optical i/o)
Date: Mon, 13 Sep 2010 18:13:30 -0700
Message-ID: <AANLkTimD6pJkkCTEM2mVGaix1KL8wKo_4Dkoqu63vzyk@mail.gmail.com>
References: <AANLkTik7=sY9VJ2QX9j=W4+qH5s6SfBKi-LGG2WeF3x1@mail.gmail.com>
	<201009132135.26733.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2178688791098107761=="
Return-path: <linux-audio-user-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>
In-Reply-To: <201009132135.26733.gineera-w3fLijarSLctUJzwtRwX/w@public.gmane.org>
List-Unsubscribe: <http://lists.linuxaudio.org/options/linux-audio-user>,
	<mailto:linux-audio-user-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxaudio.org/pipermail/linux-audio-user>
List-Post: <mailto:linux-audio-user-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>
List-Help: <mailto:linux-audio-user-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linuxaudio.org/listinfo/linux-audio-user>,
	<mailto:linux-audio-user-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-audio-user-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org
Errors-To: linux-audio-user-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org
To: Alan Horstmann <gineera-w3fLijarSLctUJzwtRwX/w@public.gmane.org>
Cc: linux-audio-user <linux-audio-user-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

--===============2178688791098107761==
Content-Type: multipart/alternative; boundary=0016369c8da7c6f07304902debdc

--0016369c8da7c6f07304902debdc
Content-Type: text/plain; charset=UTF-8

On Mon, Sep 13, 2010 at 1:35 PM, Alan Horstmann <gineera-w3fLijarSLctUJzwtRwX/w@public.gmane.org>wrote:
>
> May be helpful to use alsamixer (command-line pseudo graphical) - that
> should
> present all the controls the driver provides.  Certainly I found that to be
> the most useful way of understanding/operating the underlying controls.
> (Which envy24control etc operate on top of).
>

It's hard to cut and paste from alsamixer(1) which is why I used amixer(1)
and scripting to show what happens in alsamixer(1). The controls of
interest,  'IEC958 Input Optical' 'IEC958 Input Optical' 'ADAT External
Master Clock' 'ADAT Output Optical' 'ADAT Through' 'Enable ADAT' -- all
appear in alsamixer(1) and they're all "stuck" at the current settings.

Using either 'm' or 'space' or any other means that would normally change a
boolean value for other ALSA properties do nothing for the above values in
alsamixer(1). Basically, it appears that the property toggles, and then
flips right back to the previous state (because that's what ALSA says it's
at).

Similarly, when set from the commandline, the ALSA result indicates the
value stays the same:

amixer cset iface=MIXER,name='IEC958 Input Optical' true
numid=95,iface=MIXER,name='IEC958 Input Optical'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off


> I am fairly sure that the ice1712 driver has no run-time mechanism for
> enabling/disabling the paired digital streams that are ADAT on EWS88D, and
> go
> to/from the AK4524 codecs on most other versions.


Seems like there's something of it in the code, and certainly the Windows
drivers and the hardware itself support this functionality. See also

http://git.alsa-project.org/?p=alsa-kernel.git;a=blob_plain;f=sound/pci/ice1712/ews.c;hb=HEAD

static struct snd_kcontrol_new snd_ice1712_ews88d_controls[] __devinitdata =
{
EWS88D_CONTROL(SNDRV_CTL_ELEM_IFACE_MIXER, "IEC958 Input Optical", 0, 1, 0),
/* inverted */
EWS88D_CONTROL(SNDRV_CTL_ELEM_IFACE_MIXER, "ADAT Output Optical", 1, 0, 0),
EWS88D_CONTROL(SNDRV_CTL_ELEM_IFACE_MIXER, "ADAT External Master Clock", 2,
0, 0),
EWS88D_CONTROL(SNDRV_CTL_ELEM_IFACE_MIXER, "Enable ADAT", 3, 0, 0),
EWS88D_CONTROL(SNDRV_CTL_ELEM_IFACE_MIXER, "ADAT Through", 4, 1, 0),
};

It's almost like set/get aren't handling "boolean" correctly... And also, this
"invert" thing looks suspect -- explanation???

static int snd_ice1712_ews88d_control_get(struct snd_kcontrol *kcontrol,
struct snd_ctl_elem_value *ucontrol)
{
...
int invert = (kcontrol->private_value >> 8) & 1;
...
}
static int snd_ice1712_ews88d_control_put(struct snd_kcontrol *kcontrol,
struct snd_ctl_elem_value *ucontrol)
{
...
int invert = (kcontrol->private_value >> 8) & 1;
...
}


>  With the DMX6fire, which
> normally has 3-pairs, I added a different register value used at start-up
> so
> that 2 channel are not active (and picking up 'static' noise), but the
> other
> ice1712's enable all 4 pairs always.
>
> It is possible that the functions and controls have been coded from
> data-sheets and never debugged on real hardware, or at least not in every
> respect.  Perhaps others may know?
>

Hoping somebody knows. Or knows of some magic command or patch I can use to
switch these inputs.

-- Niels
http://nielsmayer.com

--0016369c8da7c6f07304902debdc
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Mon, Sep 13, 2010 at 1:35 PM, Alan Horstmann =
<span dir=3D"ltr">&lt;<a href=3D"mailto:gineera-w3fLijarSLctUJzwtRwX/w@public.gmane.org">gineera@as=
pect135.co.uk</a>&gt;</span> wrote:<blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">

May be helpful to use alsamixer (command-line pseudo graphical) - that shou=
ld<br>
present all the controls the driver provides. =C2=A0Certainly I found that =
to be<br>
the most useful way of understanding/operating the underlying controls.<br>
(Which envy24control etc operate on top of).<br></blockquote><div><br></div=
><div>It&#39;s hard to cut and paste from alsamixer(1) which is why I used =
amixer(1) and scripting to show what happens in alsamixer(1). The controls =
of interest,=C2=A0<span class=3D"Apple-style-span" style=3D"font-family: ar=
ial, sans-serif; font-size: 11.1111px; border-collapse: collapse; ">=C2=A0&=
#39;IEC958 Input Optical&#39; &#39;IEC958 Input Optical&#39; &#39;ADAT Exte=
rnal Master Clock&#39; &#39;ADAT Output Optical&#39; &#39;ADAT Through&#39;=
 &#39;Enable ADAT&#39; -- all appear in alsamixer(1) and they&#39;re all &q=
uot;stuck&quot; at the current settings.=C2=A0</span></div>
<div><span class=3D"Apple-style-span" style=3D"font-family: arial, sans-ser=
if; font-size: 11.1111px; border-collapse: collapse; "><br></span></div><di=
v><span class=3D"Apple-style-span" style=3D"font-family: arial, sans-serif;=
 font-size: 11.1111px; border-collapse: collapse; ">Using either &#39;m&#39=
; or &#39;space&#39; or any other means that would normally change a boolea=
n value for other ALSA properties do nothing for the above values in alsami=
xer(1). Basically, it appears that the property toggles, and then flips rig=
ht back to the previous state (because that&#39;s what ALSA says it&#39;s a=
t).</span></div>
<div><span class=3D"Apple-style-span" style=3D"font-family: arial, sans-ser=
if; font-size: 11.1111px; border-collapse: collapse; "><br></span></div><di=
v><span class=3D"Apple-style-span" style=3D"font-family: arial, sans-serif;=
 font-size: 11.1111px; border-collapse: collapse; ">Similarly, when set fro=
m the commandline, the ALSA result indicates the value stays the same:</spa=
n></div>
<div><span class=3D"Apple-style-span" style=3D"font-family: arial, sans-ser=
if; font-size: 11.1111px; border-collapse: collapse; "><br></span></div><di=
v><span class=3D"Apple-style-span" style=3D"font-family: arial, sans-serif;=
 font-size: 11.1111px; border-collapse: collapse; "><span class=3D"Apple-st=
yle-span" style=3D"font-size: 11.1111px; "><div>
amixer cset iface=3DMIXER,name=3D&#39;IEC958 Input Optical&#39; true</div><=
div>numid=3D95,iface=3DMIXER,name=3D&#39;IEC958 Input Optical&#39;</div><di=
v>=C2=A0=C2=A0; type=3DBOOLEAN,access=3Drw------,values=3D1</div><div>=C2=
=A0=C2=A0: values=3Doff</div></span></span></div>
<div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex;"><font class=3D"Apple-style=
-span" face=3D"arial, sans-serif"><span class=3D"Apple-style-span" style=3D=
"border-collapse: collapse;"></span></font>
I am fairly sure that the ice1712 driver has no run-time mechanism for<br>
enabling/disabling the paired digital streams that are ADAT on EWS88D, and =
go<br>
to/from the AK4524 codecs on most other versions.</blockquote><div><br></di=
v><div>Seems like there&#39;s something of it in the code, and certainly th=
e Windows drivers and the hardware itself support this functionality. See a=
lso=C2=A0</div>
<div><span class=3D"Apple-style-span" style=3D"font-family: arial, sans-ser=
if; font-size: 11.1111px; border-collapse: collapse; "><div>=C2=A0=C2=A0<a =
href=3D"http://git.alsa-project.org/?p=3Dalsa-kernel.git;a=3Dblob_plain;f=
=3Dsound/pci/ice1712/ews.c;hb=3DHEAD" target=3D"_blank" style=3D"color: rgb=
(28, 81, 168); ">http://git.alsa-project.org/?p=3Dalsa-kernel.git;a=3Dblob_=
plain;f=3Dsound/pci/ice1712/ews.c;hb=3DHEAD</a></div>
<div><br></div><div><div>static struct snd_kcontrol_new snd_ice1712_ews88d_=
controls[] __devinitdata =3D {</div><div><span class=3D"Apple-tab-span" sty=
le=3D"white-space:pre">	</span>EWS88D_CONTROL(SNDRV_CTL_ELEM_IFACE_MIXER, &=
quot;IEC958 Input Optical&quot;, 0, 1, 0), /* inverted */</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>EWS88=
D_CONTROL(SNDRV_CTL_ELEM_IFACE_MIXER, &quot;ADAT Output Optical&quot;, 1, 0=
, 0),</div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	<=
/span>EWS88D_CONTROL(SNDRV_CTL_ELEM_IFACE_MIXER, &quot;ADAT External Master=
 Clock&quot;, 2, 0, 0),</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>EWS88=
D_CONTROL(SNDRV_CTL_ELEM_IFACE_MIXER, &quot;Enable ADAT&quot;, 3, 0, 0),</d=
iv><div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>EW=
S88D_CONTROL(SNDRV_CTL_ELEM_IFACE_MIXER, &quot;ADAT Through&quot;, 4, 1, 0)=
,</div>
<div>};</div></div><div><br></div><div>It&#39;s almost like set/get aren&#3=
9;t handling &quot;boolean&quot; correctly... And also, th<span class=3D"Ap=
ple-style-span" style=3D"font-size: 11.1111px; ">is &quot;invert&quot; thin=
g looks suspect -- explanation???</span></div>
<div><br></div><div><div>static int snd_ice1712_ews88d_control_get(struct s=
nd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)</div><div>{</di=
v><div>...</div><div><span class=3D"Apple-tab-span" style=3D"white-space:pr=
e">	</span>int invert =3D (kcontrol-&gt;private_value &gt;&gt; 8) &amp; 1;<=
/div>
</div><div>...</div><div>}</div><div><div>static int snd_ice1712_ews88d_con=
trol_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol=
)</div><div>{</div><div>...</div><div><span class=3D"Apple-tab-span" style=
=3D"white-space:pre">	</span>int invert =3D (kcontrol-&gt;private_value &gt=
;&gt; 8) &amp; 1;</div>
</div><div>...</div><div>}</div></span></div><div>=C2=A0</div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;=
padding-left:1ex;"> =C2=A0With the DMX6fire, which<br>
normally has 3-pairs, I added a different register value used at start-up s=
o<br>
that 2 channel are not active (and picking up &#39;static&#39; noise), but =
the other<br>
ice1712&#39;s enable all 4 pairs always.<br>
<br>
It is possible that the functions and controls have been coded from<br>
data-sheets and never debugged on real hardware, or at least not in every<b=
r>
respect. =C2=A0Perhaps others may know?<br></blockquote><div><br></div><div=
>Hoping somebody knows. Or knows of some magic command or patch I can use t=
o switch these inputs.</div><div><br></div><div>-- Niels</div><div><a href=
=3D"http://nielsmayer.com">http://nielsmayer.com</a>=C2=A0</div>
<div>=C2=A0</div></div>

--0016369c8da7c6f07304902debdc--

--===============2178688791098107761==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-audio-user mailing list
Linux-audio-user-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org
http://lists.linuxaudio.org/listinfo/linux-audio-user

--===============2178688791098107761==--
