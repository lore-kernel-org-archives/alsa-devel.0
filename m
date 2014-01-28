From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/4] ASoC: tda998x: adjust the audio hw
 parameters from EDID
Date: Tue, 28 Jan 2014 11:00:51 +0000
Message-ID: <20140128110051.GI11841@sirena.org.uk>
References: <cover.1390813480.git.moinejf@free.fr>
 <d99e90932aad1a644fa32ff22fd2cb56b830341b.1390813481.git.moinejf@free.fr>
 <20140127204441.GZ11841@sirena.org.uk>
 <20140127204915.GC15937@n2100.arm.linux.org.uk>
 <20140127205437.GC11841@sirena.org.uk>
 <s5hppncihn6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3294873822308541951=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 610D02651C0
 for <alsa-devel@alsa-project.org>; Tue, 28 Jan 2014 12:01:12 +0100 (CET)
In-Reply-To: <s5hppncihn6.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>, Dave Airlie <airlied@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============3294873822308541951==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nPae/vprxxBmi7c6"
Content-Disposition: inline


--nPae/vprxxBmi7c6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 28, 2014 at 10:23:57AM +0100, Takashi Iwai wrote:
> Mark Brown wrote:
> > On Mon, Jan 27, 2014 at 08:49:15PM +0000, Russell King - ARM Linux wrote:

> > > Yes, preferably as a generic ALSA helper rather than an ASoC helper -
> > > I don't see any need for this to be ASoC specific (I have a pure ALSA
> > > driver which has very similar code in it.)

> > Indeed, definitely ALSA generic - ideally we could factor a lot of the
> > integration with the video side out.

> Yes, indeed.

> OTOH, as discussed recently, we're heading to move from ELD parsing to
> more direct communication between video and audio drivers for
> HD-audio.  ELD will be still provided to user-space, but not evaluated
> any longer in the new scenario.

That sort of refactoring being one of the best reasons to keep things
out of individual drivers!  Having said all this I don't know if it's
worth blocking Jean-Francois' work on that, it's an improvement in
itself.  Splitting the code out a bit would be good to help prepare but
having the full refactoring done might be too much of a blocker.

--nPae/vprxxBmi7c6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS543gAAoJELSic+t+oim9030QAIxNMZp0qBNi1Cw63gVJ3Frd
2otQ0B+K49gjJCyQnVflvkX0kyK3wki1NQILYl/9dLIPL44MykJLR17km33n8iFw
BbmYv16ZvUR2YzfZe1N3SKnyP61oG1Xr4p5GMK+9EG76oB6td4ygAKaAisO38iVR
+zqyFasyaaWL7NFPPYrx7K/b3jDGbwKgaJK0rLfvEzQ+qQyt7Vpd2F1zHEV+pKLW
Qj0V0wsXRNT+fFMoskPcE+MinfWWe+jmqLADfXrhOLt+M6CXxoQceceEloCopB+R
lS1iN2tZgQE/RGNecMoAq4Ckzyd0zGIfNa/Zm5oHjBBpIQJAPM/wyDPX46bPHPOf
BfP4/KHbA5SdItiPLUZAEPS3llkGSOtvEkRZp4abV9j7epqBHjd2N1RZpLHO5lJp
N13u3Cwe/ggy+8fhFnIXAvH3f9qirGmSr5X7Fj1ppsb+A3PY8ZrihiRvzw/JWbVB
NR5iqZPCueLoaMeQ0T7HmZQ9kZIwcJX6mLPziqfRh+AKWMJ9pPtLplVnxNLX1DIi
pqmniLQMueIjtDQxBX2dwrVm4i5mf+ym7lDS1CwViLkj3FGtXREdq+Z6RUrYY597
RgvAwcfks5fFbnG71YmHFWeUZKxHwb8+cRexRy0TDvEH36FfFp4QrE3bsKV3He7e
RIuYdfK/MRvagJBstuI7
=bRji
-----END PGP SIGNATURE-----

--nPae/vprxxBmi7c6--

--===============3294873822308541951==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3294873822308541951==--
