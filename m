From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Linux 3.2-rc1
Date: Tue, 8 Nov 2011 12:23:30 -0800
Message-ID: <CA+55aFwx5=T1piX5qPj2jCAbzdHAQX2gYJODZnQ40h9hiDjkbQ@mail.gmail.com>
References: <CA+55aFzytqbGcOzWvYAo-EnJCeK5mFqdCF5OjMTeM5UBfeyCXw@mail.gmail.com>
	<20111108145510.GA5142@elliptictech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f41.google.com (mail-ww0-f41.google.com [74.125.82.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 13CC3103981
	for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2011 21:23:52 +0100 (CET)
Received: by wwf27 with SMTP id 27so6724886wwf.2
	for <alsa-devel@alsa-project.org>; Tue, 08 Nov 2011 12:23:51 -0800 (PST)
In-Reply-To: <20111108145510.GA5142@elliptictech.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Nick Bowler <nbowler@elliptictech.com>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Keith Packard <keithp@keithp.com>, dri-devel@lists.freedesktop.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hmm, I don't know what caused this to trigger, but I'm adding both the
i915 people and the HDA people to the cc, and they can fight to the
death about this in the HDMI Thunderdome.

Guys: One.. Two.. Three.. FIGHT!

                 Linus

On Tue, Nov 8, 2011 at 6:55 AM, Nick Bowler <nbowler@elliptictech.com> wrot=
e:
>
> Mode switches are very noisy on an Intel G45 in 3.2-rc1:
>
> =A0HDMI hot plug event: Codec=3D3 Pin=3D3 Presence_Detect=3D1 ELD_Valid=
=3D1
> =A0HDMI status: Codec=3D3 Pin=3D3 Presence_Detect=3D1 ELD_Valid=3D1
> =A0HDMI: detected monitor W2253 at connection type HDMI
> =A0HDMI: available speakers: FL/FR
> =A0HDMI: supports coding type LPCM: channels =3D 2, rates =3D 32000 44100=
 48000, bits =3D 16 20 24
>
> These lines get printed every single switch; previously only a single
> line was printed once at boot (the "HDMI status" line).
>
> Cheers,
> --
> Nick Bowler, Elliptic Technologies (http://www.elliptictech.com/)
>
