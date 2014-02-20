From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 007/102] ASoC: mc13783: Remove superfluous
	const
Date: Thu, 20 Feb 2014 10:56:35 +0900
Message-ID: <20140220015635.GV2669@sirena.org.uk>
References: <1392723148-12597-1-git-send-email-tiwai@suse.de>
 <1392723148-12597-5-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7156248708095484892=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 2400A26538A
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2014 02:56:49 +0100 (CET)
In-Reply-To: <1392723148-12597-5-git-send-email-tiwai@suse.de>
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


--===============7156248708095484892==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gqv2CREQkBUQQDmZ"
Content-Disposition: inline


--gqv2CREQkBUQQDmZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:32:19PM +0100, Takashi Iwai wrote:
> As SOC_ENUM_SINGLE_DECL() itself contains const modifier now, we can
> reduce const from its users.

Applied, thanks.

--gqv2CREQkBUQQDmZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBWDQAAoJELSic+t+oim9ii0P/iQajzhDBm92Aw1+UXqKgLYW
J4LJZhqStfIOZmWL3/0C4l6Chi1t1sUW+z0oDUIY4Sxbd2w4mAUqzugKs3faE2jm
wubL9UQe6Ni5EEWkrm3gmDROP2Oir0cDCTI01Jf8FnOyEnfRfg912C26VZjjH0Cv
WwjnDVJ5qNo/4KIUt7QdV5Fd5PwdC1il1XyrKICjLEyT4Wgk061s1+JHf7cMSnbl
GhARnULFTS9/FpllevFzt6cyZzYWc02wp63uzbw5wfZbaKKhSFfR8NdUS/gh5hQ+
s69TPD6oqiGLj7fB42zn87zNUwHpMWebOlhhRW+HRDVFg81Z8HZUS1lbQycv+jKY
Hx0jCIvhGdxpp22OOsHPa1neUy3qExBwI+z1JygToFPrm1btXL5u9uJg8tvjthvH
MV7i9S28sL6l66asSv9lvPBRxWL+R66ud7eCt1KSiCDzg4CLvH+t3FdvuaD0usS8
Fq2MSM7CMlCo4bE8xBEY4p7QhnnVdY2gveOZ1TbMU74+dIPbrTd3TLPCw/6hb2kN
03lZ4OSVhOvELTBYMzSCH4eAct+LnVfsnGWCY2kxVNVx6tsdmBn1M3qNrOXuR79Q
AmhGfWx5BYHh9/qw995/o5248KISuXE0mVilNofCL94h00djK7lraX9y5Xiiu30I
PmiAbJTm/TVVhfrQr6/Y
=rrgj
-----END PGP SIGNATURE-----

--gqv2CREQkBUQQDmZ--

--===============7156248708095484892==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7156248708095484892==--
