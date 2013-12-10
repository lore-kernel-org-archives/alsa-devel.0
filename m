From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Issue with multiple hdmi codecs in
 radeonhd, hacked to work
Date: Tue, 10 Dec 2013 13:39:47 +0800
Message-ID: <CAN8ccibt-pbWY0roHVjkhRz5eoOGMhbZRmL5Ce4fQLFOnZ0GaA@mail.gmail.com>
References: <CAJ3TwYRYGR5Z2m1XSQ9QOp3ffe9sb2C_znsVUeBpARySZ7KbMQ@mail.gmail.com>
	<CAJ3TwYTeR4fZSRGaMpUudL2t_dR0dkYYV1tP_aEAGnjUqN3iDg@mail.gmail.com>
	<CAN8cciZ8okPOUD1X3Vy3ofayQHfW6K3eojUwLkGc3o-xX0BFgg@mail.gmail.com>
	<CAJ3TwYQr3u-04zRduACx9g283tpyj2bmjDvgA+ok=15OGg5g9w@mail.gmail.com>
	<CAN8cciYEikGtPaET-qZECcyGTAqRQab6jEsGP-Zt=4U2ngLqbA@mail.gmail.com>
	<CAJ3TwYRheSya2Y7y-e82=-HPv5j26n7SR-L1GeC=CPfrOKHpbA@mail.gmail.com>
	<CAN8ccibrFmQa4rPcP6gqt7h1MpMQ310b8y2zcbN-h_rtN_6vvw@mail.gmail.com>
	<CAJ3TwYQ_1BTmPafS-_BJWWNp1VSXA5K_e0vVHMipGrkdOjGuwA@mail.gmail.com>
	<CAN8cciaUWAxfPp0rNhBV=DCp2hSOJ-EPHeoQ-k25M91xYjmFiQ@mail.gmail.com>
	<CAJ3TwYTJnGb7C_TZrGOVTsPPb1kB6Kzqge4suh2B_QAdNUMWgw@mail.gmail.com>
	<CAN8cciZTuP8Y-nvv8ecJZBoJZBgsucb2p0sd-2dmyMWGxDgifQ@mail.gmail.com>
	<CAJ3TwYQukvyyXvuOtquv3UmnToK3CwM1zNxrq6kr4QE2Sshx2A@mail.gmail.com>
	<CAN8cciYeo9UrCPdjRfezFRyv6z_BXSwGvkRg6jKu2B9BMHJayA@mail.gmail.com>
	<52A55CAD.3080007@iki.fi> <52A55E4D.1050906@iki.fi>
	<CAJ3TwYSQHSTF0QyFn35db2FGAwpGgT3wKNa44eVMsrgFW95BJg@mail.gmail.com>
Reply-To: General PulseAudio Discussion
	<pulseaudio-discuss@lists.freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0185875890=="
Return-path: <pulseaudio-discuss-bounces@lists.freedesktop.org>
In-Reply-To: <CAJ3TwYSQHSTF0QyFn35db2FGAwpGgT3wKNa44eVMsrgFW95BJg@mail.gmail.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@lists.freedesktop.org>
List-Help: <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=subscribe>
Sender: pulseaudio-discuss-bounces@lists.freedesktop.org
Errors-To: pulseaudio-discuss-bounces@lists.freedesktop.org
To: John Ettedgui <john.ettedgui@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, General PulseAudio Discussion <pulseaudio-discuss@lists.freedesktop.org>, Douglas N <erutrot@gmail.com>, Takashi Iwai <tiwai@suse.de>, Alex Deucher <alexander.deucher@amd.com>
List-Id: alsa-devel@alsa-project.org

--===============0185875890==
Content-Type: multipart/alternative; boundary=90e6ba6e85865cc3d904ed278af8

--90e6ba6e85865cc3d904ed278af8
Content-Type: text/plain; charset=UTF-8

>
>> > ATI/AMD does not internally use ELD but analogous custom stuff. But as
>> > noted, the HDA driver on this kernel does not support reading it, it is
>> > a 3.12+ feature (though note that writing the info is disabled in 3.12
>> > radeon video driver on some cards).
>>
>> A typo here, AMD stuff is a 3.13+ feature.
>>
>> New logs.
> I hope this time I got it right:
>
>
> zcat /proc/config.gz :
> CONFIG_SND_DEBUG=y
> CONFIG_SND_DEBUG_VERBOSE=y
> CONFIG_SND_PCM_XRUN_DEBUG=y
> CONFIG_SND_DYNAMIC_MINORS=y
>
>
Did you pass the output of alsa-info.sh and eld to the alsa-devel mailing
list ?

Codec: ATI R6xx HDMI
Address: 0
AFG Function Id: 0x1 (unsol 0)
Vendor Id: 0x1002aa01
Subsystem Id: 0x00aa0100
Revision Id: 0x100300

seem that your codec may get Audio-Video Association Port ID and Sink
Information for your DENON-AVAMP

Do pulseaudio show four available HDMI ports ?

pactl list

Do pulseaudio select the first HDMI as active port the default sink ?

pactl stat

--90e6ba6e85865cc3d904ed278af8
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br>
<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
"><div dir=3D"ltr"><div><div class=3D"gmail_quote"><div class=3D"im"><br><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">
<div><div><br>
&gt; ATI/AMD does not internally use ELD but analogous custom stuff. But as=
<br>
&gt; noted, the HDA driver on this kernel does not support reading it, it i=
s<br>
&gt; a 3.12+ feature (though note that writing the info is disabled in 3.12=
<br>
&gt; radeon video driver on some cards).<br>
<br>
</div></div>A typo here, AMD stuff is a 3.13+ feature.<br>
<div><div><br></div></div></blockquote></div>New logs.<div>I hope this time=
 I got it right:</div><div><br></div><div><br></div><div><div>zcat /proc/co=
nfig.gz :</div><div>CONFIG_SND_DEBUG=3Dy</div><div>CONFIG_SND_DEBUG_VERBOSE=
=3Dy</div>

<div>CONFIG_SND_PCM_XRUN_DEBUG=3Dy</div></div><div><div>CONFIG_SND_DYNAMIC_=
MINORS=3Dy</div></div><div><br></div></div></div></div></blockquote><div><b=
r></div><div>Did you pass the output of alsa-info.sh and eld to the alsa-de=
vel mailing list ?<br>
<br>Codec: ATI R6xx HDMI<br>Address: 0<br>AFG Function Id: 0x1 (unsol 0)<br=
>Vendor Id: 0x1002aa01<br>Subsystem Id: 0x00aa0100<br>Revision Id: 0x100300=
<br><br></div><div>seem that your codec may get Audio-Video Association Por=
t ID and Sink Information for your DENON-AVAMP <br>
</div><div><br></div></div>Do pulseaudio show four available HDMI ports ?<b=
r><br></div><div class=3D"gmail_extra">pactl list<br></div><div class=3D"gm=
ail_extra"><br></div><div class=3D"gmail_extra">Do pulseaudio select the fi=
rst HDMI as active port the default sink ?<br>
<br></div><div class=3D"gmail_extra">pactl stat<br></div></div>

--90e6ba6e85865cc3d904ed278af8--

--===============0185875890==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
pulseaudio-discuss mailing list
pulseaudio-discuss@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss

--===============0185875890==--
