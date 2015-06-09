From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: snd_pcm_avail no reliable
Date: Tue, 9 Jun 2015 16:08:30 +0800
Message-ID: <CAN8cciY+f4b6ZbvFrKVN9eayEbH5vunMzQpKCKneSEhGOk_Gew@mail.gmail.com>
References: <55765481.8020008@gmail.com>
 <CAN8cciZ7fsgFxzrQTHs_6cOMERsU5kzTXkFHF-WCgjrRV8jDqg@mail.gmail.com>
 <5576683F.4080605@gmail.com>
 <CAN8ccibd2aXx66ypAB-a3nu0KSk1N40rOCf22QbN3XN3tBkJLA@mail.gmail.com>
 <5576795A.4080200@gmail.com>
 <CAN8cciZZ7TR0NbX-SaxkO6S4X2d+wfsEB_AMn+_f_g1CQuNh6A@mail.gmail.com>
 <CACuU-+h9LKBaq4=e9ev2+cm_LdbMHYR8MhLjAsQNzFNrtyvU6A@mail.gmail.com>
 <CAN8cciaq7vXiF_U67rikGgD+kQHtvEF0VPb-=TESbvVuoQBKxw@mail.gmail.com>
 <CACuU-+hi85K0=3W5YOWt3yY5H9kRK4trECJAfDfmA4WXtn6+Yw@mail.gmail.com>
 <5576950A.9040405@gmail.com>
Reply-To: General PulseAudio Discussion
 <pulseaudio-discuss@lists.freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1129347987=="
Return-path: <pulseaudio-discuss-bounces@lists.freedesktop.org>
In-Reply-To: <5576950A.9040405@gmail.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/pulseaudio-discuss>,
 <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@lists.freedesktop.org>
List-Help: <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss>,
 <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=subscribe>
Errors-To: pulseaudio-discuss-bounces@lists.freedesktop.org
Sender: "pulseaudio-discuss" <pulseaudio-discuss-bounces@lists.freedesktop.org>
To: General PulseAudio Discussion <pulseaudio-discuss@lists.freedesktop.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
Cc: lijian <lijian@pset.suntec.net>, wangwei <wangwei@pset.suntec.net>
List-Id: alsa-devel@alsa-project.org

--===============1129347987==
Content-Type: multipart/alternative; boundary=089e01538c5c8b54c705181143e0

--089e01538c5c8b54c705181143e0
Content-Type: text/plain; charset=UTF-8

>
>     I tried using a smaller period_size (about 1/16 of hwbuf_size),
snd_pcm_avail returned a better value.

Period bytes  = 2Kbytes which is still larger than the default
rewind_safeguard 512 bytes

>     But cpu usage moved from 1% to 4%, since we are using it in a
automotive, we don`t care about power saving,  I think it is acceptable.
>
>     But I`m not sure if there is any other down side about "time based
scheduling" ?
>
>

--089e01538c5c8b54c705181143e0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p><br>
&gt;<br>
&gt; =C2=A0 =C2=A0 I tried using a smaller period_size (about 1/16 of hwbuf=
_size), snd_pcm_avail returned a better value.<br></p>
<p>Period bytes=C2=A0 =3D 2Kbytes which is still larger than the default re=
wind_safeguard 512 bytes</p>
<p>&gt; =C2=A0 =C2=A0 But cpu usage moved from 1% to 4%, since we are using=
 it in a automotive, we don`t care about power saving,=C2=A0 I think it is =
acceptable.<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 But I`m not sure if there is any other down side about &=
quot;time based scheduling&quot; ?<br>
&gt;<br>
&gt; </p>

--089e01538c5c8b54c705181143e0--

--===============1129347987==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KcHVsc2VhdWRp
by1kaXNjdXNzIG1haWxpbmcgbGlzdApwdWxzZWF1ZGlvLWRpc2N1c3NAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHA6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9wdWxz
ZWF1ZGlvLWRpc2N1c3MK

--===============1129347987==--
