From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] Revert "ASoC: core: mark SND_SOC_BYTES_EXT
	as deprecated"
Date: Fri, 16 Sep 2016 11:52:47 +0100
Message-ID: <20160916105247.GY27974@sirena.org.uk>
References: <1473980762-13259-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5429738892764582383=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 971AB261560
 for <alsa-devel@alsa-project.org>; Fri, 16 Sep 2016 12:53:06 +0200 (CEST)
In-Reply-To: <1473980762-13259-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: tiwai@suse.de, vinod.koul@intel.com, alsa-devel@alsa-project.org, clemens@ladisch.de, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============5429738892764582383==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DHfswzTG6eDt0nli"
Content-Disposition: inline


--DHfswzTG6eDt0nli
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 16, 2016 at 08:06:02AM +0900, Takashi Sakamoto wrote:

Please submit patches using subject lines reflecting the style for the
subsystem.  This makes it easier for people to identify relevant
patches.  Look at what existing commits in the area you're changing are
doing and make sure your subject lines visually resemble what they're
doing.

> However, SND_SOC_BYTES_TLV brought confusions to user land because it
> doesn't follow to a protocol of ALSA control interface. At least, this
> macro and related kernel APIs include two misunderstandings:
>  - 'struct snd_ctl_elem_info.count' can also represent the length of TLV
>    packet paylaod, snd_soc_bytes_info_ext() performs in this way.
>  - 'struct snd_ctl_tlv.tlv' can include arbitrary data regardless of TLV
>    packet structure, snd_soc_bytes_tlv_callback() performs in this way.

I can't tell what problem you are trying to describe here, sorry.  What
are you expecting the userspace ABI to do that these controls don't,
you appear to be saying that the code does actually do what's expected
which obviously isn't a problem.  What do you expect to happen, what is
actually happening and why do you beleive this to be a problem?

> In the first place, SND_SOC_BYTES_TLV was added to satisfy a request of
> developers who need to add control elements which transfer data larger than
> the size which 'struct snd_ctl_elem_value' can represent; e.g. over 512
> bytes. As long as the size is less than the size, SND_SOC_BYTES_EXT is
> still available. Although there is the limitation of maximum data size,
> it's better to use this API for stable application interface till better
> alternative ways are implemented in future.

This doesn't make much sense to me, sorry.  This is an interface for
drivers.  They shouldn't need to know the implementation details of
different controls and we should be striving for consistency in the
interface we present both at the driver level and at the userspace
level.  Having two randomly different interfaces is not going to help
that or stop the larger controls existing, it'll just make the interface
more confusing for driver authors.

--DHfswzTG6eDt0nli
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJX287+AAoJECTWi3JdVIfQhyAH/0G+XKnIjsHQK3MS28jMa1e3
IMOykA9atwQ3VJoi31MabHhoD+D6qnn7Af4i74VtOhq6A0jxDTubvL93k0IJQbzc
aeC2ecpcdOI+3t4PgypM+UIFHFBJE1aiPIFX2fHX9Gek98HoADD//4uSAT8xYazk
Nd2WnhnbkmIIbYWHVoNjkzZqb8C2svD81etQmFnhuTyp9JqGCvobNHg+ZOBELJBT
+wZ67EcFKJb7tXSRvgxv19iFvWyaR8NXR6oU0Jgs3NqU5CV07FHUyz+TqmTtd5cz
ZbIhZK1cPIBImeveXnNryUYi2+m9Tiup0dcb1z2n/Zh7b/hBQeXiYHFz46rsC4U=
=JIn6
-----END PGP SIGNATURE-----

--DHfswzTG6eDt0nli--

--===============5429738892764582383==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5429738892764582383==--
