From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: wrong decibel data?
Date: Fri, 9 Apr 2010 07:11:48 +0800
Message-ID: <u2w4f3252891004081611tc0293e7fzb6312ca188eacdc1@mail.gmail.com>
References: <q2s98391a7b1004021121sde36d074m8a70acc142f95d93@mail.gmail.com>
	<r2i4f3252891004051846xc6ef1834habaf4f9db3bdd384@mail.gmail.com>
	<q2z98391a7b1004060101kd5ffef92tf4d98faa62a3ad5b@mail.gmail.com>
	<q2l4f3252891004071905l553da6a0he8b53448524fc94d@mail.gmail.com>
	<z2s98391a7b1004080542ud4af307l992ac9636d9aa508@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f178.google.com (mail-pz0-f178.google.com
	[209.85.222.178])
	by alsa0.perex.cz (Postfix) with ESMTP id C990E10385C
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Apr 2010 01:11:50 +0200 (CEST)
Received: by pzk8 with SMTP id 8so1806498pzk.16
	for <alsa-devel@alsa-project.org>; Thu, 08 Apr 2010 16:11:49 -0700 (PDT)
In-Reply-To: <z2s98391a7b1004080542ud4af307l992ac9636d9aa508@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/4/8 Nicolo' Chieffo <nicolo.chieffo@gmail.com>

> I'm sorry but I found out that I gave you wrong values of "amixer -D
> pulse": I just discovered that when I lower the alsa master volume, in
> some occasions the PCM volume goes to 99%, so now I will put it to
> 100% and check the pulse volume again.
>
> 0 dB    =3D  65536 [100%]
> -3 dB   =3D  57520 [88%]
> -6 dB   =3D  52057 [79%]
> -12 dB =3D  41034 [63%]
> -24 dB =3D  26090 [40%]
> -48 dB =3D 10151 [15%]
>
> So again, the only problem is that -48 dB IS mute, but it's not
> declared as mute.
> This is the real issue.
>

Refer to HD audio specification

7.3.4.10 Amplifier Capabilities

Mute Capable (1 bit) reports if the respective amplifier is capable of
muting. Muting implies a =96infinity gain (no sound passes), but the actual
performance is determined by the hardware.

http://thread.gmane.org/gmane.linux.alsa.devel/39262/focus=3D16100

>> Clemens Ladisch (developer) 2004-11-09 09:26

>>    The AD1981B's datasheet says that the maximum attenuation is 46.5 dB
(which
>> conforms to the AC'97 specification).
>> To mute, use Mute.


refer to your codec datasheet , the volume knob widget also affect the
volume if it is configured in direct mode


=95 DIRECT MODE
=95 In Direct mode, the Volume Knob widget directly controls the volume of =
all
of the DACs in the part. The volume in the Volume Knob widget acts as the
master volume and limits the maximum volume for each of the DAC amplifiers.
The amp gain for each of the DACs can also be adjusted using the DAC
amplifiers. However, the actual gain for an individual DAC will be the sum
of the Volume Knob volume and the DAC amplifier volume. For example, if the
DAC amplifier gain is set to 0x7F (0dB) and the Volume Knob volume is set to
0x3F (-48dB) the resulting gain would be -48dB. If the combination of gains
is less than -95.25dB
(the equivalent to a value of 0x0 for the DAC or Volume Knob volume
settings) then the actual gain will be -95.25dB. For example, if the Volume
Knob is set to 0x3F (-48dB) and the DAC amplifier volume is set to 0x1F
(-72dB) then the DAC volume will be set to -95.25dB.
