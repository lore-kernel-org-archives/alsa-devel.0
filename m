From: Mark Brown <broonie@kernel.org>
Subject: Re: linux-next: manual merge of the sound-asoc tree with the
 drm-misc tree
Date: Wed, 18 Oct 2017 11:08:02 +0100
Message-ID: <20171018100802.4eiin6bhsj6wir75@sirena.co.uk>
References: <20171018095733.2ffvg6ty6kn2lfdf@sirena.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0641376490=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20171018095733.2ffvg6ty6kn2lfdf@sirena.co.uk>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Alex Deucher <alexander.deucher@amd.com>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Rex Zhu <Rex.Zhu@amd.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Intel Graphics <intel-gfx@lists.freedesktop.org>, DRI <dri-devel@lists.freedesktop.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--===============0641376490==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6odhojqr3rupvxx3"
Content-Disposition: inline


--6odhojqr3rupvxx3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 18, 2017 at 10:57:33AM +0100, Mark Brown wrote:

> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Actually I'm just going to discard the AMD drivers from the ASoC tree
because the build produces reams of errors like those below, the changes
to move the chip type definitions around weren't fully baked.  Please
resend both the pull request and the patches with this fixed.  Note also
that if you're basing something on Linus' tree you should use a tagged
release rather than just a random commit.

In file included from /home/broonie/tmpfs/next/drivers/gpu/drm/amd/amdgpu/amdgpu.h:51:0,
                 from /home/broonie/tmpfs/next/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c:31:
/home/broonie/tmpfs/next/drivers/gpu/drm/amd/amdgpu/../include/amd_shared.h:33:6: error: nested redefinition of 'enum amd_asic_type'
 enum amd_asic_type {
      ^
/home/broonie/tmpfs/next/drivers/gpu/drm/amd/amdgpu/../include/amd_shared.h:33:6: error: redeclaration of 'enum amd_asic_type'
In file included from /home/broonie/tmpfs/next/drivers/gpu/drm/amd/amdgpu/../include/amd_shared.h:26:0,
                 from /home/broonie/tmpfs/next/drivers/gpu/drm/amd/amdgpu/amdgpu.h:51,
                 from /home/broonie/tmpfs/next/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c:31:
/home/broonie/tmpfs/next/include/drm/amd_asic_type.h:28:6: note: originally defined here
 enum amd_asic_type {
      ^

--6odhojqr3rupvxx3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnnKAEACgkQJNaLcl1U
h9AXYAf9FH24hnfvF42jW0fFpPhZXrac4pf9j//QczzcPStmLcZqmbd4nb9DgmBw
qdGmVArFX6y+tcAdKLOqFIEPolZ9wDD9NTUtK9i6YAZa+U0Lr8Mr+pY2kq3BlJNW
XEgCAEqfLJbeV+SBg4J9UogRXtwwJqDK8KHx9q/EU5yxnkE3ayqqKqlP+sc69dWB
eonSxPcJ/Dyb0HpGqkXoAHO1MNnZmE5/44HGHqw7zZjCLeIdC9UFhNF6zPt4guC+
Re2iAPdn77QOpmjgRGZwKPyE8HP1C++reWocucqwslHu2KnLrxlDHdL/H+l+OkXs
lhYC7w3CdjK0f4pWkrGQHlcCowCTSw==
=tah9
-----END PGP SIGNATURE-----

--6odhojqr3rupvxx3--

--===============0641376490==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0641376490==--
