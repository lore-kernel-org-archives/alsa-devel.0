From: =?UTF-8?B?QnVyYWsgTUVUxLBO?= <metinburak@gmail.com>
Subject: Re: [alsa-devel] [PATCH] Asus Essence STX II
Date: Mon, 4 Aug 2014 14:47:12 +0300
Message-ID: <CADG_eVoSstSsh6qJH=0sona2Y5jCCg2XsuVVLRjnSm7fJE-owQ@mail.gmail.com>
References: <53DD9448.8070804@gmx.de> <s5hzjfkv6hp.wl%tiwai@suse.de>
	<CADG_eVqEj=-Y7AP4fb8B+o7eWgfJk+wBpQvM4=_rP6_FZjBwBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7539979729183071761=="
Return-path: <alsa-user-bounces@lists.sourceforge.net>
In-Reply-To: <CADG_eVqEj=-Y7AP4fb8B+o7eWgfJk+wBpQvM4=_rP6_FZjBwBQ@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=alsa-user>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
Errors-To: alsa-user-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org, "alsa-user@lists.sourceforge.net" <alsa-user@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

--===============7539979729183071761==
Content-Type: multipart/alternative; boundary=001a11339e88b53fae04ffcc4c21

--001a11339e88b53fae04ffcc4c21
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

When =C4=B1 dmesg, it says:

[ 5418.913160] retire_playback_urb: 1673 callbacks suppressed
[ 5419.253436] cannot submit urb 0, error -28: not enough bandwidth
[ 5419.254887] cannot submit urb 0, error -28: not enough bandwidth



On Mon, Aug 4, 2014 at 2:43 PM, Burak MET=C4=B0N <metinburak@gmail.com> wro=
te:

> Hi,
>
> I have 2 CM6571 usb sound cards.
>
> In Ubuntu, i want to use these 2 cardds simultaneously. I open 2
> terminals, and arecord -D plughw:1,0 | aplay -D plughw:1,0 in one termina=
l,
> it works well. but when i type arecord -D plughw:2,0 | aplay -D plughw:2,=
0
> in another terminal, in second terminal, it says
>
> Recording WAVE 'stdin' : Unsigned 8 bit, Rate 8000 Hz, Mono
> arecord: xrun:1552: Playing WAVE 'stdin' : read/write error, state =3D
> PREPAREDUnsigned 8 bit,
> Rate 8000 Hz, Mono
> aplay: set_params:1297: Unable to install hw params:
> ACCESS:  RW_INTERLEAVED
> FORMAT:  U8
> SUBFORMAT:  STD
> SAMPLE_BITS: 8
> FRAME_BITS: 8
> CHANNELS: 1
> RATE: 8000
> PERIOD_TIME: 125000
> PERIOD_SIZE: 1000
> PERIOD_BYTES: 1000
> PERIODS: 4
> BUFFER_TIME: 500000
> BUFFER_SIZE: 4000
> BUFFER_BYTES: 4000
> TICK_TIME: 0
>
> I think it is about the usb driver in alsa, any ideas?
>
>
> On Mon, Aug 4, 2014 at 2:28 PM, Takashi Iwai <tiwai@suse.de> wrote:
>
>> At Sun, 03 Aug 2014 03:45:44 +0200,
>> corubba wrote:
>> >
>> > Today I got my new sound card, a Asus Essence STX II. After plugin it =
in
>> > and booting my Linux machine, the card was recognized by lspci as audi=
o
>> > controller, but not listed by alsa as soundcard. Information on suppor=
t
>> > for this new card under linux are hard to find. Due to the hardware
>> > similarities between STX and STX II, I tried to modify the existing ST=
X
>> > driver in order to work for the STX II too. And it seems to work quiet
>> > well: I have sound, can change the volumes, switch between
>> > speaker/headphone/frontpanel, enable the mic boost etc. I don't have t=
he
>> > H6 childboard for surround sound, so I can't test that. I tested my
>> > patch [1] with a 3.15.8 kernel under Arch Linux.
>> >
>> > Just wanted to share this information for others to get it quickly
>> > working, or maybe even include it after a review from the devs.
>> >
>> >
>> > [1] http://pastebin.com/GaGguPvt
>>
>> If the device works as expected by just this addition, I find no
>> problem in the patch.  Please submit in the formal way as described in
>> Documentation/SubmittingPatches.
>>
>>
>> thanks,
>>
>> Takashi
>>
>>
>> ------------------------------------------------------------------------=
------
>> Infragistics Professional
>> Build stunning WinForms apps today!
>> Reboot your WinForms applications with our WinForms controls.
>> Build a bridge from your legacy apps to the future.
>>
>> http://pubads.g.doubleclick.net/gampad/clk?id=3D153845071&iu=3D/4140/ost=
g.clktrk
>> _______________________________________________
>> Alsa-user mailing list
>> Alsa-user@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/alsa-user
>>
>
>

--001a11339e88b53fae04ffcc4c21
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">When =C4=B1 dmesg, it says:<div><br></div><div><div>[ 5418=
.913160] retire_playback_urb: 1673 callbacks suppressed</div><div>[ 5419.25=
3436] cannot submit urb 0, error -28: not enough bandwidth</div><div>[ 5419=
.254887] cannot submit urb 0, error -28: not enough bandwidth</div>
</div><div><br></div></div><div class=3D"gmail_extra"><br><br><div class=3D=
"gmail_quote">On Mon, Aug 4, 2014 at 2:43 PM, Burak MET=C4=B0N <span dir=3D=
"ltr">&lt;<a href=3D"mailto:metinburak@gmail.com" target=3D"_blank">metinbu=
rak@gmail.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div dir=3D"ltr">Hi,<div><br></div><div>I ha=
ve 2 CM6571 usb sound cards.</div><div><br></div><div>In Ubuntu, i want to =
use these 2 cardds simultaneously. I open 2 terminals, and arecord -D plugh=
w:1,0 | aplay -D plughw:1,0 in one terminal, it works well. but when i type=
 arecord -D plughw:2,0 | aplay -D plughw:2,0 in another terminal, in second=
 terminal, it says</div>

<div><br></div><div><div>Recording WAVE &#39;stdin&#39; : Unsigned 8 bit, R=
ate 8000 Hz, Mono</div><div>arecord: xrun:1552: Playing WAVE &#39;stdin&#39=
; : read/write error, state =3D PREPAREDUnsigned 8 bit,=C2=A0</div><div>Rat=
e 8000 Hz, Mono</div>

<div>aplay: set_params:1297: Unable to install hw params:</div><div>ACCESS:=
 =C2=A0RW_INTERLEAVED</div><div>FORMAT: =C2=A0U8</div><div>SUBFORMAT: =C2=
=A0STD</div><div>SAMPLE_BITS: 8</div><div>FRAME_BITS: 8</div><div>CHANNELS:=
 1</div><div>

RATE: 8000</div><div>PERIOD_TIME: 125000</div><div>PERIOD_SIZE: 1000</div><=
div>PERIOD_BYTES: 1000</div><div>PERIODS: 4</div><div>BUFFER_TIME: 500000</=
div><div>BUFFER_SIZE: 4000</div><div>BUFFER_BYTES: 4000</div><div>TICK_TIME=
: 0</div>

</div><div><br></div><div>I think it is about the usb driver in alsa, any i=
deas?</div></div><div class=3D"HOEnZb"><div class=3D"h5"><div class=3D"gmai=
l_extra"><br><br><div class=3D"gmail_quote">On Mon, Aug 4, 2014 at 2:28 PM,=
 Takashi Iwai <span dir=3D"ltr">&lt;<a href=3D"mailto:tiwai@suse.de" target=
=3D"_blank">tiwai@suse.de</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">At Sun, 03 Aug 2014 03:45:44 +0200,<br>
corubba wrote:<br>
&gt;<br>
&gt; Today I got my new sound card, a Asus Essence STX II. After plugin it =
in<br>
&gt; and booting my Linux machine, the card was recognized by lspci as audi=
o<br>
&gt; controller, but not listed by alsa as soundcard. Information on suppor=
t<br>
&gt; for this new card under linux are hard to find. Due to the hardware<br=
>
&gt; similarities between STX and STX II, I tried to modify the existing ST=
X<br>
&gt; driver in order to work for the STX II too. And it seems to work quiet=
<br>
&gt; well: I have sound, can change the volumes, switch between<br>
&gt; speaker/headphone/frontpanel, enable the mic boost etc. I don&#39;t ha=
ve the<br>
&gt; H6 childboard for surround sound, so I can&#39;t test that. I tested m=
y<br>
&gt; patch [1] with a 3.15.8 kernel under Arch Linux.<br>
&gt;<br>
&gt; Just wanted to share this information for others to get it quickly<br>
&gt; working, or maybe even include it after a review from the devs.<br>
&gt;<br>
&gt;<br>
&gt; [1] <a href=3D"http://pastebin.com/GaGguPvt" target=3D"_blank">http://=
pastebin.com/GaGguPvt</a><br>
<br>
If the device works as expected by just this addition, I find no<br>
problem in the patch. =C2=A0Please submit in the formal way as described in=
<br>
Documentation/SubmittingPatches.<br>
<br>
<br>
thanks,<br>
<br>
Takashi<br>
<br>
---------------------------------------------------------------------------=
---<br>
Infragistics Professional<br>
Build stunning WinForms apps today!<br>
Reboot your WinForms applications with our WinForms controls.<br>
Build a bridge from your legacy apps to the future.<br>
<a href=3D"http://pubads.g.doubleclick.net/gampad/clk?id=3D153845071&amp;iu=
=3D/4140/ostg.clktrk" target=3D"_blank">http://pubads.g.doubleclick.net/gam=
pad/clk?id=3D153845071&amp;iu=3D/4140/ostg.clktrk</a><br>
_______________________________________________<br>
Alsa-user mailing list<br>
<a href=3D"mailto:Alsa-user@lists.sourceforge.net" target=3D"_blank">Alsa-u=
ser@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/alsa-user" target=
=3D"_blank">https://lists.sourceforge.net/lists/listinfo/alsa-user</a><br>
</blockquote></div><br></div>
</div></div></blockquote></div><br></div>

--001a11339e88b53fae04ffcc4c21--


--===============7539979729183071761==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Infragistics Professional
Build stunning WinForms apps today!
Reboot your WinForms applications with our WinForms controls. 
Build a bridge from your legacy apps to the future.
http://pubads.g.doubleclick.net/gampad/clk?id=153845071&iu=/4140/ostg.clktrk
--===============7539979729183071761==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-user mailing list
Alsa-user@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-user

--===============7539979729183071761==--
