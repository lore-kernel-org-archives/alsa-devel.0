From: Thomas Zehetbauer <thomasz@hostmaster.org>
Subject: Re: Re: [Alsa-user] ALSA / emu10k1 / SPDIF / surround?
Date: Tue, 30 Aug 2005 01:05:38 +0200
Message-ID: <1125356738.21560.27.camel@hostmaster.org>
References: <1124755115.5763.3.camel@hostmaster.org>
	 <1125166820.22285.68.camel@hostmaster.org>
	 <1125168446.25011.68.camel@mindpipe>
	 <1125173150.22285.103.camel@hostmaster.org>
	 <1125174445.25011.76.camel@mindpipe>
	 <1125177706.22285.144.camel@hostmaster.org>
	 <1125178767.25011.86.camel@mindpipe>
	 <1125181627.22285.155.camel@hostmaster.org>
	 <1125183623.25011.102.camel@mindpipe>
	 <1125195487.2684.8.camel@hostmaster.org>
	 <1125196132.25011.111.camel@mindpipe>  <s5hbr3h3xxy.wl%tiwai@suse.de>
	 <1125325907.4598.23.camel@mindpipe>
	 <1125342246.21560.2.camel@hostmaster.org>
	 <1125345314.4598.58.camel@mindpipe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-eMmVBWGlVFNGq6ROx/fs"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1125345314.4598.58.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@lists.sourceforge.net>, ALSA user list <alsa-user@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-eMmVBWGlVFNGq6ROx/fs
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2005-08-29 at 15:55 -0400, Lee Revell wrote:
> I still think these are poor choices for mixer control names.  The kX
> driver solves this problem nicely by separating the AC97 mixer controls
> from the ones implemented with EMU10K1 DSP microcode.  I guess to have
> this option on Linux, we'd need some way for driver to report which
> controls are part of the AC97 codec.

It's not the name, it's the almost total lack of documentation that
makes mixer controls so confusing. I am going to make up a page from
what I have learned, but I feel that I am still scratching on the
surface. For example I still wonder what these controls do:
- 3D Control - Switch
- 3D Control Sigmatel - Depth
- 3D Control Sigmatel - Rear Depth
- Sigmatel 4-Speaker Stereo Playback Switch

Tom

--=20
  T h o m a s   Z e h e t b a u e r   ( TZ251 )
  PGP encrypted mail preferred - KeyID 96FFCB89
      finger thomasz@hostmaster.org for key

Nearly all men can stand adversity, but if you want to test a man's
character, give him power.
                                Abraham Lincoln




--=-eMmVBWGlVFNGq6ROx/fs
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iQEVAwUAQxOUwmD1OYqW/8uJAQL6kgf+PPuMYPFzMLDuR4Nfqp5Xsk2hQ5pLxEHt
xJufKJV+9vr0vkxFVQY3CUMSH0ZARsXo/qlUWSQYRq1OD6WE1pocKumun0X8TXTz
ZdEr9nmPuXfnC4wLoo9DfEg8m189gtb6xvrK7BQJmEwZiUGmBgVdF7e5g06mn9Eg
85cF8Bi2++ZsnEYu8LGp8Nba7j/LwWQvTSzA7sedhgQdXZG5pMy4tIz4S9aWw8Hm
WR03b1E0Y4OfbBEIMRipvkUOqiybAWyEIOQWHT2DpwmNJY88061qS0Jb3rvb2tS+
g8esKcGa96wuiLC3pgn9oXcH/jb4ZafM5995ygyjdIdxhmfd8lsKkA==
=0xac
-----END PGP SIGNATURE-----

--=-eMmVBWGlVFNGq6ROx/fs--



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
