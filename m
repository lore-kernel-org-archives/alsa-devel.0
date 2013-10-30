From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/9] ASoC: wm0010: Fix possible
	out-of-bounds array read
Date: Wed, 30 Oct 2013 09:38:57 -0700
Message-ID: <20131030163857.GF2493@sirena.org.uk>
References: <1383118507-21503-1-git-send-email-tiwai@suse.de>
 <1383118507-21503-6-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6220891287775631429=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 570042654B7
 for <alsa-devel@alsa-project.org>; Wed, 30 Oct 2013 18:09:29 +0100 (CET)
In-Reply-To: <1383118507-21503-6-git-send-email-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6220891287775631429==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l+goss899txtYvYf"
Content-Disposition: inline


--l+goss899txtYvYf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 30, 2013 at 08:35:03AM +0100, Takashi Iwai wrote:
> Spotted by coverity CID 744701.

Applied, thanks, though once more please do CC the people working on the
code.

--l+goss899txtYvYf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJScTYeAAoJELSic+t+oim94XoP/iusUWCuu4PN0UVnkl2IG/dg
0yOMWUCCwsIiUWl54frBvoqYbsxeQFf906htuhSKMEja53ZFOfH/CdjY2f0QD5q/
bPZxFvPevfZYExX4e/Ceh/jTh3QIq11Rt0U/wMv1Epsk0Jr9Vbhr0zYrzylJYTfx
r8x55HFE73LUh+uhOKZpLluYsWLeqCZFqsxRwOZPRx5OzvYbCahhkAI3rGs1YwpZ
3GMFep9D/lpoWUghYXGLgKMr/37MsIa7k3OoTu/4dbKsYq865VAg9V7M8/xsG9/k
2l4blI1GO+bYFgErKdxp45zsYEcmDluWRts9/X12LrCWfgLvmGXH2WF9maRPekcg
PXZrmI0t2RbCWitv32rHKeZp0hMTqcooUM/WdnYZee1fsZZCYAwA5YyZJz5yXOf8
Ko6RITQU6CQcDH8x+W4DCU2kgLXJUbGe5JAcoWZ4hvuEzhQ//nl2JUepYil+nooh
liing/17lPuj31NPmfCelsDmbZLxTnwszoX5GiJ4kfQxD4Z3ZhUeQtrI5rnstwiy
gisE6ipfsOB6wdkj26hU+diyj7EqZf5s2p7mr6+ZjLULnXl+F42bZjJJjHIrwp4k
WBW9xM/MaeKli2zjHixUS3884qVBdwB8oYP1qrJKJTT+8CBxCUG3ricLKzBYlyM8
SrFuQTiT9n+QHCdGTUTK
=lVsv
-----END PGP SIGNATURE-----

--l+goss899txtYvYf--

--===============6220891287775631429==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6220891287775631429==--
