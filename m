From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: imx-spdif: Use module_init() to
 handle platform_device_register()
Date: Mon, 16 Dec 2013 22:17:10 +0000
Message-ID: <20131216221710.GH3185@sirena.org.uk>
References: <1387190169-7936-1-git-send-email-Guangyu.Chen@freescale.com>
 <20131216194717.GO3185@sirena.org.uk>
 <20131216211958.GS4360@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8253060840448824101=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 075482602AD
 for <alsa-devel@alsa-project.org>; Mon, 16 Dec 2013 23:17:15 +0100 (CET)
In-Reply-To: <20131216211958.GS4360@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com, Nicolin Chen <Guangyu.Chen@freescale.com>
List-Id: alsa-devel@alsa-project.org


--===============8253060840448824101==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lf0NQ8GVTdtriwpn"
Content-Disposition: inline


--lf0NQ8GVTdtriwpn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 16, 2013 at 09:19:58PM +0000, Russell King - ARM Linux wrote:
> On Mon, Dec 16, 2013 at 07:47:17PM +0000, Mark Brown wrote:

> > The crucial bit of information here is what the "inappropriate
> > condition" is - what is this trying to fix?  The code doesn't look
> > obviously wrong though it does rely on the platform device registration
> > taking effect immediately to actually probe which is a bit of an

> It's an exact copy-n-paste of the same problem which Kirkwood stuff had
> when I first looked at spdif there (presumably because Kirkwood had copied
> it from somewhere.)  The basic problem is this:

Indeed - that was a comment on the qualty of the changelog as much as
anything.

> > What should work right now is for the module to ensure that the S/PDIF
> > CODEC drivers are loaded before it is by linking to some symbol from
> > there.  This is a total hack though.  Nicer would be for the machine
> > driver to either directly register S/PDIF DAIs (rather than devices that
> > then register the DAIs) or to create a card subdevice in parallel with
> > the S/PDIF ones and hook the card registration off that.

> That creates much more complexity though, and adds yet more possibility
> for unreliability into this.  "Keep it simple" is well worth following.

I don't see registering the DAIs directly as adding complexity here;
it's essentially what the current code is trying to do and doesn't
change the normal device registration flow at all.  I do agree that the
card subdevice is more complex, I don't particularly like that idea
myself.

> The simple thing here is to declare the codec device in the module init,
> before registering the card driver, and cleaning it up at the appropriate
> moment.  That way, the card platform driver gets registered and it can

It's certainly simple and it's definitely what I'd recommend for non-DT
systems.  For DT systems it'll cause issues if two drivers both try to
register the same device on module load and the second one to get loaded
checks for errors.  Another way is just to do that in the core so we
don't need to worry about individual drivers conflicting and convert all
the drivers that do this to reference the core copies.

--lf0NQ8GVTdtriwpn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSr3vjAAoJELSic+t+oim9q2oQAJcz6LlKV6uRCFYutGY+aCUz
BQWXljYBAMBb00s97j98shkttsEwV27j9VOFwMRpKcQhznPvEDL44M6xcnCq/pb8
lzeahnVM9YIoSfF3br8PKatJ75gNGq2q2BISpcjsNyNZZguwsOL3F6b1tFeivTet
Ku1OvZhMYUywSDar2EX0yRGJrV26PCjZAwO6vC0Ucs0JO72Rde0gv1Eor2GPge/j
d8OS5h7mikJkCmwDO2HKhCtpBUdSl0MvWhwpLsWO82DgREayi1JneCm+mXr+J6VF
ycCrstfPGj9SUtjImPYXt/zPo0piniYqJI+nkmqKm0cW4izCvDu2uAsy0hFU0Lrx
MNbhntiOPvCkdBfIcQEbxk7WlthXMuT3aW+R8ci73GfI/vYsJT/qQlZKQCKAGc00
gZZWthwsQ9OcTULfZ75iQhkpbBvD/x3FOgax+fo+VThasqgeWxFsLJdWCY/9/px3
9xDZlPU6KblTT/PiROwgkkClJ9K16v4vsOqfg56rm3SlC5UZiMLEa2MwV78BZ0Cu
iQxt3ZqV8vQ3TiWZ+mb/7xe78J5UslzRdKaS6CJ5nD6aQv46oV3U8fFHRBzCPuWy
JS+Q5qPPW891FNkniGpXqTMZVTZ0u2pULJEE+B32yZpO9sgf8MH1Xh2JMGxsOtY2
4xLRZnIqmTHsS9CjZK5T
=VWez
-----END PGP SIGNATURE-----

--lf0NQ8GVTdtriwpn--

--===============8253060840448824101==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8253060840448824101==--
