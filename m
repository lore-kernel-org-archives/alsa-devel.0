From: Stuffed Crust <pizza@shaftnet.org>
Subject: Re: Selectable async notification signal?
Date: Thu, 11 Apr 2002 14:02:41 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020411140241.C15906@shaftnet.org>
References: <20020407234548.A14312@shaftnet.org> <s5hzo0ajjbi.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="DSayHWYpDlRfCAAQ"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hzo0ajjbi.wl@alsa2.suse.de>; from tiwai@suse.de on Thu, Apr 11, 2002 at 06:23:13PM +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--DSayHWYpDlRfCAAQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2002 at 06:23:13PM +0200, Takashi Iwai wrote:
> int snd_pcm_async(snd_pcm_t *pcm, int sig, pid_t pid)
>=20
> .. so you can pass your favorite signal to the 2nd argument.
>=20
> or do i misunderstand your question?

Yes, let me try to explain it a bit better.

BTW, This is for FreeSCI (http://freesci.linuxgames.com).

The main process forks off a child to handle all of the sound-related
stuff, and communicates with that child through a pair of pipes.  We use
select()s to check for events, usually with a very small (~100ms max)
timeout.  We need the timeout to enforce note timing.

The child process is what opens the sound device.

I wrote an ALSA PCM output plugin for FreeSCI which uses async PCM; ie
I register a callback, and every period ALSA kicks in, executes the
callback and fills its buffers.

Both on their own work just fine.  However, when I turn on the ALSA
callback, the select()s block indefinately.   Since the select()s block,
no note data gets fired off, which results in no sound.

I am not installing any SIGIO handler at all; The only ones installed in
the child is SIGPIPE.

I tried the snd_pcm_async() call; that didn't help.  What
happens is the callback keeps kitting my custom signal, but meanwhile
the select()s still block. =20

If I don't start the pcm device, then the select()s succeed.

 - Pizza
--=20
Solomon Peachy                                    pizzaATfucktheusers.org
I ain't broke, but I'm badly bent.                           ICQ# 1318344
Patience comes to those who wait.
    ...It's not "Beanbag Love", it's a "Transanimate Relationship"...

--DSayHWYpDlRfCAAQ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8tc/BysXuytMhc5ERAqiXAJ43tNt7Pv5zGBPop/O1da64wnQokgCeMidT
2mOyYQXF9M3Jap4h/Ly2a1c=
=zL2s
-----END PGP SIGNATURE-----

--DSayHWYpDlRfCAAQ--
