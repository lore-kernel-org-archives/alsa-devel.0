From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] ASoC: davinci-mcasp: Optimize
 pm_runtime usage and clean up the init code
Date: Tue, 22 Apr 2014 19:52:16 +0100
Message-ID: <20140422185216.GE12304@sirena.org.uk>
References: <1398164594-29169-1-git-send-email-peter.ujfalusi@ti.com>
 <1398164594-29169-4-git-send-email-peter.ujfalusi@ti.com>
 <20140422114712.GO12304@sirena.org.uk> <53565E91.9040200@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5239977314151856578=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D4D30264F28
 for <alsa-devel@alsa-project.org>; Tue, 22 Apr 2014 20:52:35 +0200 (CEST)
In-Reply-To: <53565E91.9040200@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: daniel@zonque.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============5239977314151856578==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s1oWHZVDl8DmrvUg"
Content-Disposition: inline


--s1oWHZVDl8DmrvUg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 22, 2014 at 03:20:33PM +0300, Peter Ujfalusi wrote:
> On 04/22/2014 02:47 PM, Mark Brown wrote:

> > This does mean that if the device gets enumerated but isn't used in the
> > system it won't go to runtime idle since the DAI level probe is only
> > called when we're building a card.

> If the given mcasp is not used as part of a card, it should not have been
> probed in the first place (at least with DT boot we can control this). If the
> driver is probed for a mcasp instance and it is not part of any card than it
> can be left disabled IMHO no need for runtime pm to take care of it.
> I might missed something related to runtime pm, but this is my understanding.

Sure, but you then also have the cases where for whatever reason the
card doesn't probe (some other driver missing for example).  Probably
almost all the time it's not going to make a practical difference but it
just feels like a step in the wrong direction for a minimal gain.

--s1oWHZVDl8DmrvUg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTVrpdAAoJELSic+t+oim9X40P/0VaBpuq0LBHgPDLTLScGCuR
SSX0w6DQyJvLqLRMxy5xrcLH5S2essvIUz76IuJgubaQfu+tB7kcVDxPe/tRjffc
B8H5S0kMPB2n6hjvPn1mdx6vggKUQo/KgM4xwYhDdO4ee4nKnVKOkNBgRQ/coucZ
x/MbWgLEL5inGTcuSa8WeFgjEo8R+ri8epLMDmKqg5EaNXk8VWEZLMhTeWiAJwee
Amfe2NCpq73wbn9SWf2rGWzuhEVrBudwDvnTFxEmSKwNiTdRzU4Uis6n/WU2Icgu
N61WlEkLcm5nAHJ8i8K9lMSdfoUAO2pdUikvCTGE4lk9Wn5rltAkL6CybG5K1eMx
wZz/7XKjmDr9DS1OyLAEv5blbKYyssbLOX8daiIw+WusuYz9dtESe37NVnSwA/Kt
wAIxZ3+w/5cxVAfQi6BRGE1Vnn9Fdz7T+FM2HMGEd1Lw3VGiUcfbaWNbi2U809Yu
JGGTonQl6yqxgOSU4E59lKpvfjns43izgoE8e+MNX8ugkgPtXGbjjgrQRlhG92IU
L35dXjpZgOWSszkqVrtcVYHK34X+eV9sRQrR6AG8KRnJNdL9tcDv24VY9kvm3Bx6
iaSWi42YbAb+93wlyl0a+tplwktVRP9vwYgUCoWH6PMLnpLHOUfAo+wi7kU7kt27
Wk1BZoOcwNbFFBbqBKpU
=BQD4
-----END PGP SIGNATURE-----

--s1oWHZVDl8DmrvUg--

--===============5239977314151856578==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5239977314151856578==--
