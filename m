From: Joachim Blaabjerg <styx@gentoo.org>
Subject: Re: Fwd: [Alsa-user] VIA VT8235 (ALC201) problems
Date: Sat, 19 Oct 2002 12:21:23 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200210191221.23517.styx@gentoo.org>
References: <200210161628.19666.styx@gentoo.org> <200210161826.12753.styx@gentoo.org> <s5hfzv65opd.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hfzv65opd.wl@alsa2.suse.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wednesday 16 October 2002 18:32, Takashi Iwai wrote:
> At Wed, 16 Oct 2002 18:26:12 +0200,
>
> Joachim Blaabjerg wrote:
> > On Wednesday 16 October 2002 18:12, you wrote:
> > > 8235 has the same pci id with 8233, so it's ok.
> > >
> > >
> > > Takashi
> >
> > As far as I know, though, the 8235 south bridge uses a different sound
> > chip. VT8233 uses ALC650, while VT8235 uses ALC201. Or am I wrong?
>
> yes, you are confused among two things.
>
> ALC650 and ALC201 are AC97 codecs, which corresponds to ADC/DAC and
> mixer parts.  it has nothing to do with the sound engine.
> the sound core of VT8235 is almost identical with 8233, thus via82xx
> driver is the one you need.

Sorry for asking dumb questions here, but I'm still learning the basics of=
=20
ALSA here.

I've ruled out the possibility of an IRQ conflict, so that's not the cause =
of=20
my problems. So now I'm wondering, is the ALC201 AC97 codec pretty much=20
identical to the ALC200(P) or ALC202 codecs? I can't find ALC201 in=20
ac97_codec.c. Alsamixer tells me it's using ALC650. Could that be the=20
problem?

Has anyone had success with the VT8235 south bridge? A google search didn't=
=20
turn up much, I wonder if it's because I'm the only one with the problem, o=
r=20
if it Just Works(tm) with everyone else.

> > And no, I still can't get sound. :)
Still valid ;)

Best Regards,



-------------------------------------------------------
This sf.net email is sponsored by:
Access Your PC Securely with GoToMyPC. Try Free Now
https://www.gotomypc.com/s/OSND/DD
