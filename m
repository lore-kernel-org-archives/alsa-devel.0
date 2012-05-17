From: cee1 <fykcee1@gmail.com>
Subject: Re: Adjust volume may cause audio playback
	corruption
Date: Fri, 18 May 2012 05:34:20 +0800
Message-ID: <CAGXxSxUC54kb8pmDXuRGjRVbQ465v9M0n8_rO-Z4cYUpnzLz+A@mail.gmail.com>
References: <CAGXxSxUxFbC3mGWa-pbUKrzUqsBbvoQ5PmXNrKfL2W_BXyv1_A@mail.gmail.com>
	<CAGXxSxWSD+c9tnJHsKVDJYhq=AkY4KfefZgPj6rtgQozzFjuiQ@mail.gmail.com>
	<CAGXxSxUYWLyRZ1BEz53TRY9aE-CPPxSRoZeNGE5QTsOKP=B+Gg@mail.gmail.com>
	<4FB54BF6.3000901@ladisch.de>
Reply-To: General PulseAudio Discussion
	<pulseaudio-discuss@lists.freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2107546756=="
Return-path: <pulseaudio-discuss-bounces+gcapd-polypaudio-discuss=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <4FB54BF6.3000901@ladisch.de>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@lists.freedesktop.org>
List-Help: <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=subscribe>
Sender: pulseaudio-discuss-bounces+gcapd-polypaudio-discuss=m.gmane.org@lists.freedesktop.org
Errors-To: pulseaudio-discuss-bounces+gcapd-polypaudio-discuss=m.gmane.org@lists.freedesktop.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "pulseaudio-discuss@lists.freedesktop.org" <pulseaudio-discuss@lists.freedesktop.org>
List-Id: alsa-devel@alsa-project.org

--===============2107546756==
Content-Type: multipart/alternative; boundary=047d7b10ca2dde285c04c0423288

--047d7b10ca2dde285c04c0423288
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: quoted-printable

=D4=DA 2012=C4=EA5=D4=C218=C8=D5=D0=C7=C6=DA=CE=E5=A3=ACClemens Ladisch =D0=
=B4=B5=C0=A3=BA

> cee1 wrote:
> > We've found a way the can reproduce the problem more quickly on our
> product:
> > 1. do audio playback
> > 2. alsamixer, select 'Master', press 'm' and hold for a while.
> >
> > Then release 'm', playback corrupts(sounds similar to
> > http://dev.lemote.com/files/upload/software/PA-apc/corrupted_sound.ogg)=
.
>
> Is the output supposed to be playing or muted at this time?

Playing


>
> This appears to be a problem with PA's volume handling.
> It might be caused by incorrect dB volume information of the HDA codec,
> or by a bug in PA.
>
> > What does rewind do? Why we need rewind here?
>
> It allows to rewrite already written parts of the audio buffer; it's used
> to apply the new volume to samples that have not yet been actually played=
.
>
>
> Regards,
> Clemens
>


--=20
Regards,

- cee1

--047d7b10ca2dde285c04c0423288
Content-Type: text/html; charset=GB2312
Content-Transfer-Encoding: quoted-printable

=D4=DA 2012=C4=EA5=D4=C218=C8=D5=D0=C7=C6=DA=CE=E5=A3=ACClemens Ladisch  =
=D0=B4=B5=C0=A3=BA<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">cee1 wrote:<br>
&gt; We&#39;ve found a way the can reproduce the problem more quickly on ou=
r product:<br>
&gt; 1. do audio playback<br>
&gt; 2. alsamixer, select &#39;Master&#39;, press &#39;m&#39; and hold for =
a while.<br>
&gt;<br>
&gt; Then release &#39;m&#39;, playback corrupts(sounds similar to<br>
&gt; <a href=3D"http://dev.lemote.com/files/upload/software/PA-apc/corrupte=
d_sound.ogg" target=3D"_blank">http://dev.lemote.com/files/upload/software/=
PA-apc/corrupted_sound.ogg</a>).<br>
<br>
Is the output supposed to be playing or muted at this time?</blockquote><di=
v>Playing<span></span></div><div>&nbsp;</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
>
<br>
This appears to be a problem with PA&#39;s volume handling.<br>
It might be caused by incorrect dB volume information of the HDA codec,<br>
or by a bug in PA.<br>
<br>
&gt; What does rewind do? Why we need rewind here?<br>
<br>
It allows to rewrite already written parts of the audio buffer; it&#39;s us=
ed<br>
to apply the new volume to samples that have not yet been actually played.<=
br>
<br>
<br>
Regards,<br>
Clemens<br>
</blockquote><br><br>-- <br>Regards,<div><br><div>- cee1</div></div><br>

--047d7b10ca2dde285c04c0423288--

--===============2107546756==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
pulseaudio-discuss mailing list
pulseaudio-discuss@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss

--===============2107546756==--
