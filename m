From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 1/7] ASoC: hda - add ASoC HDA codec
	match function
Date: Mon, 25 May 2015 14:58:54 +0100
Message-ID: <20150525135854.GV21391@sirena.org.uk>
References: <1431341645-2457-1-git-send-email-vinod.koul@intel.com>
 <1431341645-2457-2-git-send-email-vinod.koul@intel.com>
 <20150522125634.GX21391@sirena.org.uk>
 <s5hwq00enw8.wl-tiwai@suse.de>
 <20150522174106.GV21577@sirena.org.uk>
 <s5hsiao32g6.wl-tiwai@suse.de> <20150523055156.GZ3140@localhost>
 <20150525104828.GA21577@sirena.org.uk>
 <20150525112150.GE3140@localhost> <s5hbnh827n4.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8912491991725592873=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E4D2426048D
 for <alsa-devel@alsa-project.org>; Mon, 25 May 2015 15:59:08 +0200 (CEST)
In-Reply-To: <s5hbnh827n4.wl-tiwai@suse.de>
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
Cc: Vinod Koul <vinod.koul@intel.com>, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, Jeeja KP <jeeja.kp@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org


--===============8912491991725592873==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gkEBo/XPSfx+3zOU"
Content-Disposition: inline


--gkEBo/XPSfx+3zOU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 25, 2015 at 01:55:59PM +0200, Takashi Iwai wrote:
> Vinod Koul wrote:

> > The hdac core doesn't actually do matching. If you see the match
> > function provided by core (hda_bus_match), it is a wrapper and
> > actual matching for legacy devices is being done in legacy code, see
> > hda_codec_match. This match function expects the hdac_device to be
> > wrapped in legacy hda_codec, which we don't need here.

> > So for ASoC we are embedding hdac_device in soc_hda_codec and using
> > the vendor_id and revision_id to match, so hda to write a new one.

You keep on describing what the code does; I can mostly see what the
code does (and could probably figure out extra bits if I wasn't getting
scared off by what I do see) - that's basically what I'm flagging as an
issue.  What I'm having trouble seeing is why this makes sense.  The
question isn't what, it's why.

> > I do not mind if we commonize this and have common match function in
> > hdac, if legacy is happy with it. Or perhaps the move to core later on
> > as ASoC HDA matures, either way whatever you n Takashi agree with
> > would be okay by me.

> This is the next step.  It would need a fairly big amount of rewrite
> in each legacy HDA codec driver, and I don't want it for 4.2.

So how does this actually work then?  If we need to rework all the HDA
CODEC drivers before they work with this new HDA bus (or at least this
new HDA bus when used with controllers that implement a custom match
function) then does it make sense to start trying to use it now?

I would have expected this to be the /first/ step - refactor the
existing HDA code, then add new users.

> Once when we get the common criteria for matching (both for asoc and
> legacy), we can move to the unified match method.

I really don't understand this idea that we need to work out what the
common criteria for matching are, HDA is an enumerable bus isn't it?

> That said, the reason for individual match mechanism is not to break
> the legacy hda code.  If anyone can provide a patch to achieve that
> within 100 LOCs and without regression, I'd happily take it :)

Another way of looking at this is to ask why the CODEC driver matching
can't continue to work the way it currently does - we're transitioning
to a bus (which makes sense as a cleanup) but I've not seen any reason
articulated for tying that up the merge of the Sky Lake code and it
seems like we're not very near being in a position to be able to do
that.  Or could we just keep the bigger hda_codec struct around in the
bus code for now even if it winds up being bloated?

Like I say it's all the why questions that aren't making sense to me
beyond the "we're too scared to touch the existing code" ones.

I'm also wondering how this interacts with the Tegra HDA device by the
way...

--gkEBo/XPSfx+3zOU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVYyqdAAoJECTWi3JdVIfQOpsH/jUXs2E2FiVv2LXrCb2vaoCW
cEp6CRIFUrS+b4JcrfPrkeJjbz30XCxJ1uZHDu1us5EZLHqHefBZXUBO/mQKtQf1
iZo0a7Wl4xWKyBWqqy0bcDVhuAocvvH/hdsJ7hCr1p1TUf92OctiSb+6qESQQWHr
SXeAZUfMIXm/9llZLzu/SlRsIPgwhkDQmMiCYK1addyILIgkEid0F2eYDCf+d7AH
uZg7YERhS8tL6qRuZkbvHKUwE5S/0ObCSHF6rBDLqV94FnOAOao/dlg/Z3n//5r7
W1rJVxW6nObY4bLIXbOxwAXtY+IU2r12vvYCVFLVCglrWDx32DI7Wt4xCOSPWMs=
=iJGA
-----END PGP SIGNATURE-----

--gkEBo/XPSfx+3zOU--

--===============8912491991725592873==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8912491991725592873==--
