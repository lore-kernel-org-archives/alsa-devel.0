From: Mark Brown <broonie@kernel.org>
Subject: Re: [question about DPCM] dpcm_be_disconnect race
	condition
Date: Thu, 28 Aug 2014 09:58:24 +0100
Message-ID: <20140828085824.GI17528@sirena.org.uk>
References: <53FD9384.3020501@marvell.com>
 <20140827185225.GQ17528@sirena.org.uk> <53FE8ED2.80701@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0109523020916933222=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D41C265DC6
 for <alsa-devel@alsa-project.org>; Thu, 28 Aug 2014 10:58:36 +0200 (CEST)
In-Reply-To: <53FE8ED2.80701@marvell.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Qiao Zhou <zhouqiao@marvell.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, Xin Qian <xqian@marvell.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============0109523020916933222==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SMJPu4vYr3RYCSAQ"
Content-Disposition: inline


--SMJPu4vYr3RYCSAQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 28, 2014 at 10:07:14AM +0800, Qiao Zhou wrote:
> On 08/28/2014 02:52 AM, Mark Brown wrote:
> >On Wed, Aug 27, 2014 at 04:15:00PM +0800, Qiao Zhou wrote:

> >Well, it should do that in general if it wants to make sure that the
> >audio actually gets played but the kernel should protect against this.
> >We should be holding a lock whenever we update the lists.

> Thanks a lot for your suggestion! Firstly we'll ask user space app to apply
> this rule currently to avoid such issue.
> Currently it holds card->mutex in mutex_lock_nested whenever the list is
> updated. Here list_for_each_entry in snd_pcm_stop may run in interrupt
> context(the bottom half of tasklet), so it can not use this mutex simply. Is
> there any other way to protect it?

Right, that's a problem.  We'd need to either have a finer grained spin
lock (which we'd doubtless end up needing to hold for far too long so
probably won't work) or defer the list update to a workqueue or other
non-interrupt context which gets tricky.  Hrm...

--SMJPu4vYr3RYCSAQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT/u8tAAoJELSic+t+oim9JqwP/0rctWVBK9GGJUNuymeiC95Z
9K9Z45Z3VhljmuEABbIoth30l9u2y7ZF5zgcL2r1yboyrSMIi6VPdOymneexQINa
fA6EZ0D+gEMptFWmhElpvtmYKVuFMkFdGtYBKg65CiG3KIeGod2QSeE8EoGPEto4
9zTexenOjAFI5Z3j2n6WAftFoAjd+2JwcwchEBsrNxu0ROO65bJzh9AOyToJm4r8
kPnCdKuwVHi3gq9s/epr/I6ZJ3d2gA6zmFr6M3GQfSUVaRE9n4jc0Vlr25JdVCyO
iZrBg9X1Sioj/qVfRFyBeqNFJ+8CRUPKkOhV/TNPXnXHTEdDfjLz1WSz3dKWYofC
b0w0gS7iOT9St11A7Oa9zt2YWmjAmI3nMJXKX2vq9mlerqwIyfSc3178Z2sSB8X+
3plIw/y/svrGJz63aFq+H8hCa+F5kzFjh+he40PAcD3DDGUQeQOPaoii1Hd7qGMu
Bz/dFD/VC29o2IDymueUr5kSw5/B/pwf68K2UDQvu2+mdCSVFzGcqk24n8U4jKiK
QajVkicYHzd6DUglgWPIOSxoxGZxYhw5Ehp0klyiRAYUDhNW3+ajx7Gq8wKgcrW2
p0kFSh9HOv+LECokRZExxQMzzL6lYZq+4ShAh7IlnUE80yFKO48vA6EBD1v7kaxG
pOtXKPRzO26Gt4ry0YB5
=CP7X
-----END PGP SIGNATURE-----

--SMJPu4vYr3RYCSAQ--

--===============0109523020916933222==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0109523020916933222==--
