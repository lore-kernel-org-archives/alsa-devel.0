From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: wrong decibel data?
Date: Sat, 17 Apr 2010 08:40:13 +0800
Message-ID: <n2y4f3252891004161740t111819v6feed682099f5e71@mail.gmail.com>
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
Received: from mail-pz0-f202.google.com (mail-pz0-f202.google.com
	[209.85.222.202])
	by alsa0.perex.cz (Postfix) with ESMTP id 94A121037EC
	for <alsa-devel@alsa-project.org>;
	Sat, 17 Apr 2010 02:40:15 +0200 (CEST)
Received: by pzk40 with SMTP id 40so2349742pzk.23
	for <alsa-devel@alsa-project.org>; Fri, 16 Apr 2010 17:40:14 -0700 (PDT)
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

if you had read studied the bug report

"On my Compaq R3070 laptop setting Master and Master Mono controls to 0 does
not result in no sound out. I still get audio at a low level."

The user only set Master and Master mono controls to 0.

http://www.analog.com/en/audiovideo-products/audio-codecs/ad1981b/products/=
product.html

Refer to Figure 1 THe functional BLock Diagram , you should notice that
there is another volume control in the audio path from DAC to LINE_OUT

The Master Volume and Master mono control have dB range from -46.5dB to 0dB

But the PCM Out volume control has dB range of -34.5dB to +12 dB

That is you have to sum the atten of the hardware volume controls in the
audio path
