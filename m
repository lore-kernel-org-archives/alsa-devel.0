From: Aris Aris <father.aris@gmail.com>
Subject: Re: sound: latency and synchronization measurements
Date: Fri, 18 May 2018 16:23:06 +0300
Message-ID: <CA+wdrgkeeCKpJgyA6bOOap+cqKgo4UrfukQyqQ+WuhDXsnBL0g@mail.gmail.com>
References: <CAHhAz+hFFYqz2gtVnEZVyMjAO3fe4f5EtZeFO4tvO-2W-6sv7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4062446518700046667=="
Return-path: <kernelnewbies-bounces@kernelnewbies.org>
In-Reply-To: <CAHhAz+hFFYqz2gtVnEZVyMjAO3fe4f5EtZeFO4tvO-2W-6sv7g@mail.gmail.com>
List-Unsubscribe: <https://lists.kernelnewbies.org/mailman/options/kernelnewbies>,
 <mailto:kernelnewbies-request@kernelnewbies.org?subject=unsubscribe>
List-Archive: <http://lists.kernelnewbies.org/pipermail/kernelnewbies/>
List-Post: <mailto:kernelnewbies@kernelnewbies.org>
List-Help: <mailto:kernelnewbies-request@kernelnewbies.org?subject=help>
List-Subscribe: <https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies>,
 <mailto:kernelnewbies-request@kernelnewbies.org?subject=subscribe>
Errors-To: kernelnewbies-bounces@kernelnewbies.org
To: Muni Sekhar <munisekharrms@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, linux-sound@vger.kernel.org, kernelnewbies <kernelnewbies@kernelnewbies.org>
List-Id: alsa-devel@alsa-project.org

--===============4062446518700046667==
Content-Type: multipart/alternative; boundary="00000000000042467e056c7adace"

--00000000000042467e056c7adace
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

You could try bitbanging any availiable peripheral(i.e gpio) from each
system at the callbacks and have a logic analyzer measuring and reporting
time delay.

Best regards,

Aris

On Fri, May 18, 2018 at 3:37 PM, Muni Sekhar <munisekharrms@gmail.com>
wrote:

> [ Please keep me in CC as I'm not subscribed to the list]
>
> Hi All,
>
> I am trying to characterize the audio synchronization between two
> systems. There is a mechanism to route audio between two systems, we
> run =E2=80=98aplay=E2=80=99 at one system and =E2=80=98arecord=E2=80=99 i=
n other system.
>
> We need to measure the time difference when audio sample is out at one
> port and arriving at another port in different system.
>
> I plan to add printk=E2=80=99s in =E2=80=9Cstruct snd_pcm_ops=E2=80=9D ca=
ll backs, but does
> these call backs tells when it received first and last audio
> frames\samples?
>
> Or else please suggest any other best method.
>
>
> --
> Thanks,
> Sekhar
>
> _______________________________________________
> Kernelnewbies mailing list
> Kernelnewbies@kernelnewbies.org
> https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies
>

--00000000000042467e056c7adace
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Hi,<br><br>You could try bitbanging any availiab=
le peripheral(i.e gpio) from each system at the callbacks and have a logic =
analyzer measuring and reporting=C2=A0 time delay.<br><br></div>Best regard=
s,<br><br></div>Aris<br></div><div class=3D"gmail_extra"><br><div class=3D"=
gmail_quote">On Fri, May 18, 2018 at 3:37 PM, Muni Sekhar <span dir=3D"ltr"=
>&lt;<a href=3D"mailto:munisekharrms@gmail.com" target=3D"_blank">munisekha=
rrms@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">[ Pl=
ease keep me in CC as I&#39;m not subscribed to the list]<br>
<br>
Hi All,<br>
<br>
I am trying to characterize the audio synchronization between two<br>
systems. There is a mechanism to route audio between two systems, we<br>
run =E2=80=98aplay=E2=80=99 at one system and =E2=80=98arecord=E2=80=99 in =
other system.<br>
<br>
We need to measure the time difference when audio sample is out at one<br>
port and arriving at another port in different system.<br>
<br>
I plan to add printk=E2=80=99s in =E2=80=9Cstruct snd_pcm_ops=E2=80=9D call=
 backs, but does<br>
these call backs tells when it received first and last audio<br>
frames\samples?<br>
<br>
Or else please suggest any other best method.<br>
<span class=3D"gmail-HOEnZb"><font color=3D"#888888"><br>
<br>
-- <br>
Thanks,<br>
Sekhar<br>
<br>
______________________________<wbr>_________________<br>
Kernelnewbies mailing list<br>
<a href=3D"mailto:Kernelnewbies@kernelnewbies.org">Kernelnewbies@kernelnewb=
ies.<wbr>org</a><br>
<a href=3D"https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies" =
rel=3D"noreferrer" target=3D"_blank">https://lists.kernelnewbies.<wbr>org/m=
ailman/listinfo/<wbr>kernelnewbies</a><br>
</font></span></blockquote></div><br></div>

--00000000000042467e056c7adace--


--===============4062446518700046667==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Kernelnewbies mailing list
Kernelnewbies@kernelnewbies.org
https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies

--===============4062446518700046667==--
