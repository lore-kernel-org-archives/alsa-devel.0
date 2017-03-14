From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: hdmi-codec: fix non static symbol
	warnings
Date: Tue, 14 Mar 2017 19:46:00 +0000
Message-ID: <20170314194600.dq3siegzwiv5oip4@sirena.org.uk>
References: <20170313022618.21103-1-takashi.sakamoto@miraclelinux.com>
 <20170313165009.gusafsjhbbblbmdj@sirena.org.uk>
 <3d254f6b-f254-c119-287d-5532112eb5cc@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5070936918400671617=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8279F266ED5
 for <alsa-devel@alsa-project.org>; Tue, 14 Mar 2017 20:46:11 +0100 (CET)
In-Reply-To: <3d254f6b-f254-c119-287d-5532112eb5cc@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com, Takashi Sakamoto <takashi.sakamoto@miraclelinux.com>, ichiro.suzuki@miraclelinux.com, arnaud.pouliquen@st.com, weiyongjun1@huawei.com, yukie.kato@miraclelinux.com
List-Id: alsa-devel@alsa-project.org


--===============5070936918400671617==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ky7xqhayf35hf4ui"
Content-Disposition: inline


--ky7xqhayf35hf4ui
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 14, 2017 at 01:01:57PM +0900, Takashi Sakamoto wrote:
> On Mar 14 2017 01:50, Mark Brown wrote:

> > Did you write this or did Wei Yongjun?  If they did then the patch
> > should show them as the author.

> I'm sure that you've rejected such a patch in which sender is not commit
> author. With this memory, I sent this patch with my name as author
> regardless of original author.

No, I've never done that.  What I complain about is people sending
patches that they wrote themselves but which have different authorship
information in the file, usually because they've used a different e-mail
address.  This is a problem because it makes it look like it's a patch
that needs at least two signoffs as it wasn't written by the person
sending it so slows things down.  If there are actually two signoffs
there's no problem at all as that's what's expected.

If you look at git you'll see I fairly regularly apply patches which
were forwarded by someone else.

> What fashion is suitable for you? Please give me enough instruction to your
> fashion in this case, Mark. I'm puzzled.

Please follow the process covered in SubmittingPatches - if you're
forwarding on a patch someone else wrote you need to preserve their
authorship and add your own signoff after theirs.

--ky7xqhayf35hf4ui
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljISHMACgkQJNaLcl1U
h9Cwogf8C5sgXNshzLmNEo0VEds0wOjk1dR5su3BbyloeLy2FNWoBl8XkmH9xQSZ
revCSntq4G1EtK9wIVQCmyX1KDHdt935QzB2Z98JfNVher3JthWB+kG79b2xpj6D
992V+znk3h5bZ4WvZ5SKi439oMnSWF2JCFoMi/w9Zw4O5e2KzRD4+hT6vbwrrWj4
24kHacKjLbfWLpY+yqLn9JY22KP9tfTqKKhjMQ/QniU2evxIdT76Wxn1LAY5Y5ma
xZfTh1U+KZNLOSwl+EIM1WgyxaTVGS5T27NlLLhRdT6YYfjEpJEDa3C6i/mqjEkt
vY2AYtal6A0Tt393rQeDd5s7xHJAFw==
=Aep7
-----END PGP SIGNATURE-----

--ky7xqhayf35hf4ui--

--===============5070936918400671617==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5070936918400671617==--
