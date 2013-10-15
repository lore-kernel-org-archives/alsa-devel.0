From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: generic-dmaengine-pcm: Add an
 interface to override its functions
Date: Tue, 15 Oct 2013 13:49:55 +0100
Message-ID: <20131015124955.GN2443@sirena.org.uk>
References: <1381823360-8672-1-git-send-email-b42378@freescale.com>
 <525CF814.6090403@metafoo.de> <20131015082229.GA18714@MrMyself>
 <525D04B4.3050606@metafoo.de> <20131015092350.GA18784@MrMyself>
 <525D0D7A.8010309@metafoo.de> <20131015093717.GB18784@MrMyself>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2627843550651036450=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id C022C26162A
 for <alsa-devel@alsa-project.org>; Tue, 15 Oct 2013 14:49:59 +0200 (CEST)
In-Reply-To: <20131015093717.GB18784@MrMyself>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <b42378@freescale.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============2627843550651036450==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iwhIomKmgY4D0nF/"
Content-Disposition: inline


--iwhIomKmgY4D0nF/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 15, 2013 at 05:37:17PM +0800, Nicolin Chen wrote:
> On Tue, Oct 15, 2013 at 11:40:10AM +0200, Lars-Peter Clausen wrote:

> > Wanting to use on-chip memory for the audio buffers is not that uncommon.
> > I'd rather see this implemented generically in the generic driver instead of
> > each SoC implementing its own version.

> Is that so? Actually, I did as you said in my internal branch, but I just
> fear that might not be easy to upstream, so I tried to figure out another
> plausible way. It looks like I took a detour :)

Sounds like your first idea was the best one!  I don't know about anyone
else but personally I'd be really happy to see the framework support for
these on chip mmemories improved in Linux, there's quite a few chips
aren't taking advantage of them at the minute due to the lack of a clear
way to do so.

--iwhIomKmgY4D0nF/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSXTnvAAoJELSic+t+oim9ZG4P/3ACQe0DY0DKb/9JqA+we+ps
8esjMT3DQRoSNOPK7qyURM+UOVEYtQEjj4hsB224jbNH8lREkBy1ufieSBfRIaj2
pa8fUJFhXT7ht2qd5v2rvdOp8ud7b8WXCHdfTCCI/2cTJI3TwrOaRxHKwmpI5DwA
BRFOgNIr0UsG1yEx27lokm2/kFSuTJbcEEDlsnQQodvOn5Vd+NLA/D9AWlWj/N/X
ngeqNWZzmVjW7GW+N/Vck067T2aXN//45ac23WhmcFzU3o4SIzPn6MM1hLF7lJM4
97tx1AShcLe2cD8YWjgLAFE0dKk84MyJTXQVMRNTzlzPCFe/Ct4OdsnaaXX8T8/M
DG/xy1UJrX0Y8XdGK9kKyswMRgtbhZdTNx9i6QnLFx6ciY5p4LCIaA1WSM5tmTJx
aKEgptwbfy9wSYhUG22+GCzr1YbFcunSSqmMTkcE3iaOQmu426uuFrWbq7QyUoSG
hMC7yWXep7MRO69blwm1W3aVRh8FJrLJ1xCGSHs6j5AOb2jYjTddJKUTySX489Jl
tcjcq23uz3zI7YYITkSOWmarvGjdDT5TLrtSlQ91CpSW1v4hG53wVmEjQMPaGxpQ
KWYQbSyFct2rHohuYx4+vSSruaq1GN3UnX21/m5lZ8cG9v3xK5LDPRDEU/znJktT
ILYdpvs865ypeg3Gk1Or
=mnCi
-----END PGP SIGNATURE-----

--iwhIomKmgY4D0nF/--

--===============2627843550651036450==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2627843550651036450==--
