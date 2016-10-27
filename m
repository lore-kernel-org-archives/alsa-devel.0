From: Mark Brown <broonie@kernel.org>
Subject: Audio miniconference at LPC/KS - draft schedule
Date: Thu, 27 Oct 2016 23:17:54 +0100
Message-ID: <20161027221754.GW25322@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0890770642584847087=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 57BE0260083
 for <alsa-devel@alsa-project.org>; Fri, 28 Oct 2016 00:18:08 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, vinod.koul@intel.com, "Luis R. Rodriguez" <mcgrof@kernel.org>, Eric Laurent <elaurent@google.com>
List-Id: alsa-devel@alsa-project.org


--===============0890770642584847087==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Wt10+cXOThorkX0z"
Content-Disposition: inline


--Wt10+cXOThorkX0z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The audio miniconference is next Tuesday, starting at 9am in Sweeney CDE
at the Santa Fe Convention Center.

Currently the set of topics we have on the wiki and from e-mail for
discussion is:

 - mmap/no IRQ mode
 - Time stamp reporting (both current APIs and addition of ability to
   push down PCM sync)
 - USB audio power and latency performance
 - Standardizing HDMI / DP interface
 - SoundWire support
 - Tracepoints for PCM parameter support
 - Low latency audio
 - Propagating digital configuration through the DAPM graph
 - Userspace and configuration integration (how will topology etc get
   integrated in OSes)
 - Move of ASoC clocking into the clock API
 - HDA/ASoC integration
 - UCM scaling, does it scale well=E2=80=A6?
 - How to improve upstreaming vendor drivers?
 - Stable / LTS kernel maintenance
 - Para Virtualized audio driver support
 - Userspace drivers (for IEEE 1394 and other things)
 - Dropping the DICE driver
 - Media Controller API integration
  - Is there anything new here or should we just drop this entirely?

which is quite a list but some of those should be fairly simple to
discuss so hopefully fairly quick.  I've made some effort to sort this
into a rough order but it's very much a first pass so suggestions for
changes are welcome.  Similarly are there are other things people think
we should discuss?

There's also some discussion of incoporating the kernel wide topic of
inter-device dependenices into the audio miniconference since this
affects audio (especially ASoC) quite a bit as well as several other
subsystems, that is likely to be just after a break or first thing in
the morning in order to allow others who aren't interested in audio
specifically to join (and hopefully if this happens we can convince them
to get involved in working on audio!).

I look forward to seeing many of you in Santa Fe next week!

--Wt10+cXOThorkX0z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYEn0QAAoJECTWi3JdVIfQ+VsIAIcIhAUPM9zhi7H0pPvchhQM
ZWSkojvBCQRSTEGFiR/Y3pqZTVzpgH9isjAaxkhCr8wE074zkIFvbq1VIBneIGi0
a/QqpyMo+d52Cf7rWe3xG/fjmnStL58V4Ux27Tfndh+bin2oUBMuyybFsPLf42fC
v0G9rP4EsRvRhuRyX4rzyiDamqGTxPsH93y2H9HnNgnWr1vGeMqQtTYyVcb3uxNb
H3MtxlxuaaBAl3y5eF+W+5/rUiPj5XJgjx9aN2225++nNv4Ro7nF3OVwv7WfQ3Z1
jHQ6JKOA9NZ+zXZpBiQZKkwv7q5LtgD2OMswfXx7cg4mgXDrGcHg1RL17w+pFCo=
=8Jb4
-----END PGP SIGNATURE-----

--Wt10+cXOThorkX0z--

--===============0890770642584847087==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0890770642584847087==--
