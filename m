From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Add merrifield machine driver
Date: Tue, 12 Aug 2014 22:48:22 +0100
Message-ID: <20140812214822.GB17528@sirena.org.uk>
References: <1405599225-31538-1-git-send-email-subhransu.s.prusty@intel.com>
 <20140729195043.GM17528@sirena.org.uk>
 <20140812060601.GA1115@vinod.koul@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0311862063003238826=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C3E4265329
 for <alsa-devel@alsa-project.org>; Tue, 12 Aug 2014 23:48:30 +0200 (CEST)
In-Reply-To: <20140812060601.GA1115@vinod.koul@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============0311862063003238826==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1A7woSEVe9ndBHs9"
Content-Disposition: inline


--1A7woSEVe9ndBHs9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 12, 2014 at 11:36:09AM +0530, Subhransu S. Prusty wrote:
> On Tue, Jul 29, 2014 at 08:50:43PM +0100, Mark Brown wrote:
> > On Thu, Jul 17, 2014 at 05:43:45PM +0530, Subhransu S. Prusty wrote:

> > > +	/* Force enable VMID to avoid cold latency constraints */
> > > +	snd_soc_dapm_force_enable_pin(&card->dapm, "VMID");
> > > +	snd_soc_dapm_sync(&card->dapm);

> > This looks like you're open coding a version of wm8994_vmid_mode().
> > Though that might need some tuning for systems that really have no
> > single ended outputs.

> VMID has a larget settling time. Keep it ON here to avoid the delay. Any
> better way of doing this?

Look at what wm8994_vmid_mode() does...

--1A7woSEVe9ndBHs9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT6oujAAoJELSic+t+oim9iecP/2jz2FoIXJY3sJf0S41uwBxT
f8yULl0SGuT22jRU16vi6cn4tPI/x8VOvnF6lMajGrXdccGJHZ7GwwpZay2jktDo
tZPlH/dCcAdimHNnUgHPKDS+Ne5076xEtIM0hn5RwXafIR/tkff/gHD9dMaPifgO
4fzle72Ab8Bfpya1Qr3QAZzb0XkVScrg2Y2hyGd5TukqX7CA4x/h5I5V2INUySnt
Q82d1Z1sQPwIOL6k3kEjRrhe/iiTqIVF5hF29h3FH6/EbUw6v0IVwZ1vPeorUT5L
T9JJ7nssp/MR/PJiWHXQvJv6/4glOxIn+nDivwakMhzu1x0zkkrO0NXYsY3r6nwp
OtQA/rfChcVz8PfBloylZ+OUe6hqlfto4YbSLOzQ6AlFJt1rJ2MxAfTG/ML1e9c9
j4SeGKz/yyYNt3JiuJkxqLOiEUJle82Q6S46POgqYRXMl8NPBtEjb/INIsS8EwNZ
DiPliU1z37860U9TnyoueWPWgpCp74kQT9O1pnooZltbb1YkOR61tKFncUaBRsgJ
2e4yzx7/Zbb85Q7yi/CGHf9I5Ibk/BH5nKKlayVrTqNM8O9PwlTrU+I6qITJaLur
D1OW3JzeSce1sObCrVUyOX/VQHfnmGdsutLVWBMPIbmLDwu+DhvPfTjFwOovupVy
fzQwMW/8xZaNaqRa3c1q
=lyx7
-----END PGP SIGNATURE-----

--1A7woSEVe9ndBHs9--

--===============0311862063003238826==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0311862063003238826==--
