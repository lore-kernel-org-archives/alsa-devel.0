From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Cleanup HSW pcm format support
Date: Mon, 14 Jul 2014 19:09:30 +0100
Message-ID: <20140714180930.GM6800@sirena.org.uk>
References: <1405330656-29569-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0442179060747510592=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 559B8261B36
 for <alsa-devel@alsa-project.org>; Mon, 14 Jul 2014 20:09:37 +0200 (CEST)
In-Reply-To: <1405330656-29569-1-git-send-email-yang.jie@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jie Yang <yang.jie@intel.com>
Cc: mengdong.lin@intel.com, alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============0442179060747510592==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sWvRP97dwRHm9fX+"
Content-Disposition: inline


--sWvRP97dwRHm9fX+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 14, 2014 at 05:37:36PM +0800, Jie Yang wrote:
> This change removes unsupported formats from System,
> Capture and Loopback FE DAIs.
> Also it fixes S24_LE support on all DAIs.
> While at this fix 24 bit flag for BYT as well.

Applied, thanks.

--sWvRP97dwRHm9fX+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTxBzXAAoJELSic+t+oim9kkgP/07/QnwqaN2hOLjzM38zNFR+
e1BcoPAb+WXMUY9cFTNFWft1ODOar91VVKxaM+e3l7iL9BXbp8XBlNHhtcXJz+cn
K8JXmxfdFEFeApqxmxBKSd/P6xLEfqul4f9Z+54EGO5sAg3FHk5HmcYFmNfC8sEh
X8Z8EBHNUURv0s3As0BFb2vA+bX/owtJwuIT+m6vEZpMR9++p5miyEme1Hcx+YTa
Esq9avwmYri795JA4pbi7Bkl1yWVEPYUwWs0d2vFDulMDxCAOPvmOG5pucQM5UIH
3K72EWWfvJlG0upB6CnwzzvRfvlURR/8sX6P3ohb45vAIQUQoTh+UjWHerDtYyhI
h/e2lSYe0A3c9DONTeHrYlAx7zKnJowlqQttK2iJIw0+UJXgR49Mi9evnxW8Gej0
OeoNWlI+RCir/XTmhEcvpYXV/aIavc3/yzo8q80VbXqNMswlZkl8ShEew78aRZuP
C2u1iS9AvnTad+w+bUsWYOhliaA2ZFWKXiRn0wH4rY20CWdkeQrWRdW7Nnthy05G
hI6Gum9z3lg8ZWcsyY1V2lBMSJxuzz7HPqJFTa6H+pJKRCaspXsKf8o6HsyYtENm
Xay2I/ieJxM183wBx6CjGYk0a7s/8m2JZDDJyQu9DlrWU8NH5IYXOukImKAKyDIN
SQk1OzeMhs/oE9jiJEeE
=jwlw
-----END PGP SIGNATURE-----

--sWvRP97dwRHm9fX+--

--===============0442179060747510592==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0442179060747510592==--
