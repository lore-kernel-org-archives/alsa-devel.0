From: Thomas Zehetbauer <thomasz@hostmaster.org>
Subject: Re: [Alsa-devel] Re: ALSA / emu10k1 / SPDIF / surround?
Date: Mon, 29 Aug 2005 21:04:06 +0200
Message-ID: <1125342246.21560.2.camel@hostmaster.org>
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
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-JoW8aTdj1FAsEr4K5Hgz"
Return-path: <alsa-user-admin@lists.sourceforge.net>
In-Reply-To: <1125325907.4598.23.camel@mindpipe>
Sender: alsa-user-admin@lists.sourceforge.net
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@lists.sourceforge.net>, ALSA user list <alsa-user@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-JoW8aTdj1FAsEr4K5Hgz
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2005-08-29 at 10:31 -0400, Lee Revell wrote:
> As I understand the emu10k1 driver, after initializing the AC97, it's
> supposed to rename the "Wave" control to "PCM".  Why is this user
> getting both?

No, they are definitely different controls. From what I have seen "Wave"
appears to be handled by the EMU10K1 and attenuates the PCM data stream
for both digital (SPDIF) and analog output. "PCM" appears to control the
DAC of the Sigmatel STAC9708T AC97 codec.

Tom

--=20
  T h o m a s   Z e h e t b a u e r   ( TZ251 )
  PGP encrypted mail preferred - KeyID 96FFCB89
      finger thomasz@hostmaster.org for key

"Memory is like gasoline. You use it up when you are running. Of course you
get it all back when you reboot..."
                                        Microsoft Helpdesk




--=-JoW8aTdj1FAsEr4K5Hgz
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iQEVAwUAQxNcJmD1OYqW/8uJAQKeVwf+NFnCT9ryYAcXAxLg9pzog/0xdZhXbP55
NDsHyaZQSG05dKiDtg72qWgCaMmm8wBMxstWI+F/Pq3RzbB3d3hiQ3GqlcVngEua
RuKQVSCe0u9Ifow2STJB6Lt9NzjQuEgXGTkvcs4wj1IhSFP5YeIIn7/rjJqoQKB3
I/df+iI/Gmp43DPBnSYRyqasFaYoBqDnveWQ3am0zxcNNrN/ef+VuPoQd/7XCzij
dnIQzI6byTTdVtsAaPn7eK675t2Vn0Jr28WeuVxUZszHaCsBdPe20vpDtJnCHXDI
JrE6RXgPYOsfC4JqW+cqfvwiJUwdEHesTgUACx53iWK0GcFKN9vp6A==
=Aur7
-----END PGP SIGNATURE-----

--=-JoW8aTdj1FAsEr4K5Hgz--



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
