From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 1/7] ASoC: hda - add ASoC HDA codec
 match function
Date: Tue, 2 Jun 2015 11:38:43 +0100
Message-ID: <20150602103843.GF14071@sirena.org.uk>
References: <s5hr3q3cv77.wl-tiwai@suse.de>
 <20150526194316.GY21577@sirena.org.uk>
 <s5hfv6ieero.wl-tiwai@suse.de>
 <20150527183406.GM21577@sirena.org.uk>
 <s5hpp5lde48.wl-tiwai@suse.de>
 <20150528195359.GG21577@sirena.org.uk>
 <s5hk2vsasjz.wl-tiwai@suse.de> <20150529081544.GC3140@localhost>
 <20150529173503.GQ21577@sirena.org.uk>
 <20150601050504.GH3140@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7612926997938107653=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3DE702604B5
 for <alsa-devel@alsa-project.org>; Tue,  2 Jun 2015 12:38:52 +0200 (CEST)
In-Reply-To: <20150601050504.GH3140@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, patches.audio@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============7612926997938107653==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ik0NlRzMGhMnxrMX"
Content-Disposition: inline


--ik0NlRzMGhMnxrMX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 01, 2015 at 10:35:04AM +0530, Vinod Koul wrote:
> On Fri, May 29, 2015 at 06:35:03PM +0100, Mark Brown wrote:
> > On Fri, May 29, 2015 at 01:45:44PM +0530, Vinod Koul wrote:

> > > well userspace parsing is only for the pin mapping and changes which
> > > users want to do on their systems. For basic things the default graph
> > > will be read by existing HDA parser and codec driver will create
> > > widgets based on that. The generic HDA codec library should do most and
> > > the HDA ASoC codecs should do device specfic work (like existing
> > > patch_xxx)

> > So we *are* planning to continue to use the existing CODEC support but
> > with some different interfacing on top of it?

> Nope. Existing codecs wont be reused here.

> We are doing new ASoC HDA codec drivers which use common hdac parsing logic.
> Since some codecs need own methods we can't write a single HDA generic
> codec, and had to do with generic codec parser and then specfic driver
> (HDMI, ALC to start with) on top.

But I thought we already had a generic CODEC parser?  Are you saying
you're going to write a new one?

--ik0NlRzMGhMnxrMX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVbYeyAAoJECTWi3JdVIfQdBIH/iKI8qlxe5mAvQxlUl1gF2iB
J+i1JKnBxLGnZy5WB75AY71lmSq9b+Te6/skDlA165R/6w8g92fL1TU6GceF9uaX
wQjKGxc6gmGpjIEZsQHaKGjNh8AqTb4yJxE89EEYtyEDwKxkqnJsoF3C3/KRnyMJ
YKsMxGqBVsM4v8j6tfHkFrlgeVk3SOr2PNLAOHn9EP8dTp5j/ElEBdWbipZYftIV
NprDzxqQeglsYnd/FF8UHIe5wdBL6n2DuA5IOjkgDsIho+TIIGU4F8aGdNONJ1E3
eyrmeqZc1FDjEf4eEc1XYxaYvHQ1cP/MNFXpBeWQETxvkTE/XOaf2itzHHUG5PI=
=7JtI
-----END PGP SIGNATURE-----

--ik0NlRzMGhMnxrMX--

--===============7612926997938107653==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7612926997938107653==--
