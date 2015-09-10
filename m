From: Mark Brown <broonie@kernel.org>
Subject: Re: Missing return check of of_property_read_*()
Date: Thu, 10 Sep 2015 11:54:50 +0100
Message-ID: <20150910105450.GF20922@sirena.org.uk>
References: <alpine.DEB.2.10.1509090954430.3157@heelroid>
 <s5hfv2nd45t.wl-tiwai@suse.de>
 <20150909155737.GB20922@sirena.org.uk>
 <s5hvbbjbmzx.wl-tiwai@suse.de>
 <20150909161919.GC20922@sirena.org.uk>
 <s5hr3m7bls5.wl-tiwai@suse.de>
 <20150910031022.GA28677@wfg-t540p.sh.intel.com>
 <20150910032344.GA29391@wfg-t540p.sh.intel.com>
 <s5h37ymet63.wl-tiwai@suse.de>
 <20150910062432.GA3326@wfg-t540p.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2262513318624144730=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E2E52614C4
 for <alsa-devel@alsa-project.org>; Thu, 10 Sep 2015 12:55:00 +0200 (CEST)
In-Reply-To: <20150910062432.GA3326@wfg-t540p.sh.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, Brian Austin <brian.austin@cirrus.com>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2262513318624144730==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sDKAb4OeUBrWWL6P"
Content-Disposition: inline


--sDKAb4OeUBrWWL6P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 10, 2015 at 02:24:32PM +0800, Fengguang Wu wrote:
> On Thu, Sep 10, 2015 at 07:32:04AM +0200, Takashi Iwai wrote:

> > So this made me wonder whether we have a way to take a glance through
> > gathered compile warnings at once.  Are they archived and reachable?

> Yes. Here are the active "may be used uninitialized" warnings under sound/:

> sound/core/pcm_lib.c:244: warning: 'curr_tstamp.tv_nsec' may be used uninitialized in this function

Is there any way we can view the current status on line?

--sDKAb4OeUBrWWL6P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV8WF2AAoJECTWi3JdVIfQSecH/i/3p3e84ucjh68kIS0XK3aU
WcoKjfofhrrJ6oX9QZQuPWXq87wiWDCY3GFY1GCgvBYV6FyxIq7Ue8m4yChAajus
kfXoqNDm+92OF162tkE3aZgfGnTCuOx9x7SGdMD4jqnu8lzu92trJKFPhiNpbTBc
IFWVq1+B0VI1wdHHFXK2BuDfUv2JQV/jxHJf/kpn2QIQj1tJUgCR5Aq7Ie2xb5As
KD5VNMZCLZ0cumfhd6GR96kHkKAkCy/FpZyKwDohOq0ULt2a8Q46if3mihZ+DG50
8oMDMy0aiLIS8PlQSIBVzFDX2evdKa5GZfZcCjnG5g5A+rUZT4dSM4k3FMxoa/o=
=mZuT
-----END PGP SIGNATURE-----

--sDKAb4OeUBrWWL6P--

--===============2262513318624144730==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2262513318624144730==--
