From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: commit: dpcm: Allow FE to be opened without valid
	BE routes
Date: Wed, 7 Nov 2012 09:48:56 +0100
Message-ID: <20121107084856.GC12323@opensource.wolfsonmicro.com>
References: <mailman.495.1352127790.820.alsa-devel@alsa-project.org>
 <1352221394.4968.38.camel@anish-Inspiron-N5050>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7352981517583029209=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 53057265300
 for <alsa-devel@alsa-project.org>; Wed,  7 Nov 2012 09:49:55 +0100 (CET)
In-Reply-To: <1352221394.4968.38.camel@anish-Inspiron-N5050>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: anish kumar <anish198519851985@gmail.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============7352981517583029209==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WfZ7S8PLGjBY9Voh"
Content-Disposition: inline


--WfZ7S8PLGjBY9Voh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 07, 2012 at 02:03:14AM +0900, anish kumar wrote:

> As I can see this commit has changed the log level from dev_warn to
> dev_dbg but this has caused a subtle problem.Right now we rely on this
> warning to find out issues related to "application not sending UCM

You shouldn't be relying on parsing dmesg for anything, that's never
going to be robust as you've just found.  dmesg is for humans.

> If everyone agrees then I would be more than happy to send a patch.

Please come up with a better way of identifying this; something like
information in debugfs for example or working on getting the media
controller API support merged and then using that to parse out the
routing map from that and notice the misconfiguration.  This would
be much better anyway since the same thing can happen elsewhere in DAPM
and your current mechanism.

--WfZ7S8PLGjBY9Voh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQmiBwAAoJELSic+t+oim9vVIP/AkQsROsTzCDaX/s2VRuv71b
MPgn48xAfxa3ow9ewVOLD47L873bGJ9Mwqz+D9i/cjGiR1UouXmQDWrEjWdfSbW/
X/gtq+OrSSnWGWg0wubp0LGV381Peh599ydkGzu0Fq/ukF93juHfyrBfqKXANVKK
hjGPSNXZTdlvuGxsfa8w7F0sn7u8do1ZQ/aqcRpolYqxGPHgW097S654K0SAozlE
uAJCcB8y6GUx6bZT02K5eTbSPD66UqwaYChd3rtxF/GfLMIbscp3xS7134//07YC
o9CwiAaCwk2hLKS+YXh8xNBEbeZV0IHpUcVTIeX/iOxwIcT+ahPGjVl4J7estsQU
xYY5D2x9qnW4evBiLYnW+Efk8UmqHmT2Hq9YgeOM+aGexUjaxrJoRD7xgzw5ZwEY
AtvALPtsXu/3zU1tEVN8A8fuhgz9y2bG1NKbiSknncR+qDgXxBbAefFnIox+ISea
lZSXQn+Kum8/rwLieSuurpUU8/pNG1y7TvsIwnRzvKjkScx5iBBj4FEld1Aufsde
drFscSxilbeZ27LoSr3/8gcysJNGTlmztCUyX+3XDHWmF6Aq74stPwQWv7Nut3qQ
gXv+1e/0RFLOMO7Qw3IuwawuE/m627f0bHMjWE5xKWddI+IIi6kZzmfvv4AteOOC
LJA/jN7IHwkyWY6A0Vc4
=/paJ
-----END PGP SIGNATURE-----

--WfZ7S8PLGjBY9Voh--

--===============7352981517583029209==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7352981517583029209==--
