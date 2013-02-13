From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Jack: add configurable option for
 irq_flag
Date: Wed, 13 Feb 2013 13:19:17 +0000
Message-ID: <20130213131917.GF5062@opensource.wolfsonmicro.com>
References: <1360647422-12404-1-git-send-email-omair.m.abdullah@linux.intel.com>
 <20130212114752.GA1678@opensource.wolfsonmicro.com>
 <63969.10.223.96.90.1360733997.squirrel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5204472292093359019=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EE6C8261600
 for <alsa-devel@alsa-project.org>; Wed, 13 Feb 2013 14:19:18 +0100 (CET)
In-Reply-To: <63969.10.223.96.90.1360733997.squirrel@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ramesh Babu <ramesh.babu@linux.intel.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, vinod.koul@linux.intel.com, vaibhav.agarwal@intel.com, omair.m.abdullah@intel.com, Omair Mohammed Abdullah <omair.m.abdullah@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============5204472292093359019==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7mxbaLlpDEyR1+x6"
Content-Disposition: inline


--7mxbaLlpDEyR1+x6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 13, 2013 at 11:09:57AM +0530, Ramesh Babu wrote:

> > If the device only interrupts on one edge how does it detect jack
> > removal?

> Some codecs clears it's interrupt line when driver reads the codec status
> register.
> In such cases, the interupt line will go back to normal after driver
> reads status register.  During removal, interrupt line will change and
> triggers on same edge interrupt.

Are you sure this is a GPIO that should be used directly (rather than
handled as part of the CODEC driver) and are you sure that the code
handles things like debounce well?

If this really is a GPIO it feels like the controller out to be exposing
itself as having dual edged interrupts.

--7mxbaLlpDEyR1+x6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRG5KFAAoJELSic+t+oim9stgP/2r70BEZ2w3/JyfRpvzUa+0w
SEaLZISHHLGmpDKh/cH84PWZChPw9CRWp7t58oGCSsMzdLtIebDROtCHf/Q57bv8
V3JTbzeQubSr7iNmVFlHs/DT7gs2iH3LQDo24yP3p37CBsL8XL163DunHmTIleFo
sqftCzBw6/kpswekehuHKeiVQPExO68tfbdfJNLiCD7cWaZ3Rktp1UV/YmDxfcF9
59z+Xm7Lrl/9Y3f9fuMgeDGZn87gfjqhQj1+kITTtXQKfkqIAHB+6rkfhJ6aAQ8A
vYGjO+fzcOV16iDlxy82p5uKVE4W3yfIlq95/va5IKZmMQPwsXoW2xc9EDa4S9Yk
iDPwI15TOsyLtuvixqhlPpxGi9pQ38slctrJWmCHsqxVgfkYJWLxXiXeBqWhZuhj
qnC+WdKum3dxKr+De8TLsDDImsNiCvufdqi7XRRdXnrt8AigEaMiy54vEPdxW3Zs
CcyfPc5oWlTom/MjealZRZ5H0K/bOyPk022xpEPXudFVj+OQzsHu+wpwDtPV+SvH
AKUp8Zu97fGemEerTIl+9/U16wlmNikLCsKdHEZVXeqJ7rEzonK9S7RoTa0MHjsG
ttBWLpQTWusjhj8nHR8yTtNsiZSop0NtDajPThP8z53/d5L5qknfsqb+r7sVXTju
3iBala/k7PUtAhufNXNd
=KKY6
-----END PGP SIGNATURE-----

--7mxbaLlpDEyR1+x6--

--===============5204472292093359019==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5204472292093359019==--
