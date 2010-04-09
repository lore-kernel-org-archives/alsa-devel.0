From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: wrong decibel data?
Date: Fri, 9 Apr 2010 19:37:31 +0800
Message-ID: <j2g4f3252891004090437qaeee60ffhf68d0e06b076ba51@mail.gmail.com>
References: <q2s98391a7b1004021121sde36d074m8a70acc142f95d93@mail.gmail.com>
	<r2i4f3252891004051846xc6ef1834habaf4f9db3bdd384@mail.gmail.com>
	<q2z98391a7b1004060101kd5ffef92tf4d98faa62a3ad5b@mail.gmail.com>
	<q2l4f3252891004071905l553da6a0he8b53448524fc94d@mail.gmail.com>
	<z2s98391a7b1004080542ud4af307l992ac9636d9aa508@mail.gmail.com>
	<u2w4f3252891004081611tc0293e7fzb6312ca188eacdc1@mail.gmail.com>
	<s2l98391a7b1004090030vd55faadew6ae97c85a7a4b379@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f178.google.com (mail-pz0-f178.google.com
	[209.85.222.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 74F1A1037EA
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Apr 2010 13:37:33 +0200 (CEST)
Received: by pzk8 with SMTP id 8so2084329pzk.16
	for <alsa-devel@alsa-project.org>; Fri, 09 Apr 2010 04:37:32 -0700 (PDT)
In-Reply-To: <s2l98391a7b1004090030vd55faadew6ae97c85a7a4b379@mail.gmail.com>
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

2010/4/9 Nicolo' Chieffo <nicolo.chieffo@gmail.com>

> On Fri, Apr 9, 2010 at 1:11 AM, Raymond Yau <superquad.vortex2@gmail.com>
> wrote:
> > Mute Capable (1 bit) reports if the respective amplifier is capable of
> > muting. Muting implies a =96infinity gain (no sound passes), but the ac=
tual
> > performance is determined by the hardware.
> >
> > http://thread.gmane.org/gmane.linux.alsa.devel/39262/focus=3D16100
>
> I think you missed the point, I'll explain again.
> I'm not complaining that at 0% the audio is not mute, as the bug you
> linked.
>
> >>> Clemens Ladisch (developer) 2004-11-09 09:26
> >>>    The AD1981B's datasheet says that the maximum attenuation is 46.5 =
dB
> >>> (which conforms to the AC'97 specification).
> >>> To mute, use Mute.
>
> In fact my problem is that at 0% I get mute, but I shouldn't (as
> reported by that developer), since the max attenuation is not -inf,
> but -48 dB.
> So if you prefer, you could see this issue from a different point of
> view: at -48 dB the audio should be still audible, but it's not.
>
> so you have to decide where the issue resides (but definitely not in
> pulseaudio)
> a) it is ok that the audio is mute at 0% (in this case you have to
> declare -inf dB)
> b) the audio level is really -48 dB (in this case the volume shouldn't
> be cut off completely, but simply quite low)
> Which one do you prefer?
>


All the alsa drvier are using information in the codec datasheet to
implement the dB scale

All the AC97 codec datasheet, DAC datahseet and HDA codec specifcation and
datasheet are regarded the mute switch as -inf dB , the minimum dB are a
finite negative number because the codec , DAC and HDA codec have finite
bits of resolution when convert digital signal to analog signal

For your case if you change DAC amplifier volume control to -inf dB , how
can you calculate the sum of Volume knob widget and  DAC ampilifer volume
control since the datasheet explicitly mention that the max atten is 95.25dB


may be pulseaudio did not add the volume knob widget in the calculation

I don't know how PA calculate the softvol plugin "PCM volume control" since
you mention that PA seem not maintain "PCM volume control" at 0dB
