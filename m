From: Julien Danjou <julien@danjou.info>
Subject: Re: Constant noise on HDA ALC275
Date: Mon, 08 Oct 2012 14:57:23 +0200
Message-ID: <87fw5pktos.fsf@dex.adm.naquadah.org>
References: <87obl7bg02.fsf@dex.adm.naquadah.org>
 <s5h4nmrbln3.wl%tiwai@suse.de> <87wqznim1k.fsf@dex.adm.naquadah.org>
 <s5hzk4ja5hz.wl%tiwai@suse.de> <87pq5fiklg.fsf@dex.adm.naquadah.org>
 <s5hwqzna4pn.wl%tiwai@suse.de> <87haqrijiz.fsf@dex.adm.naquadah.org>
 <s5htxura31x.wl%tiwai@suse.de> <87d31fii3v.fsf@dex.adm.naquadah.org>
 <s5hmx0ja08z.wl%tiwai@suse.de> <874nmried6.fsf@dex.adm.naquadah.org>
 <s5hfw6bpen9.wl%tiwai@suse.de> <87vcf7gyl5.fsf@dex.adm.naquadah.org>
 <s5h6277pdfi.wl%tiwai@suse.de> <87r4pvgxvx.fsf@dex.adm.naquadah.org>
 <87r4pepcgo.fsf@dex.adm.naquadah.org> <s5h1uh9jfxq.wl%tiwai@suse.de>
 <87zk3xku73.fsf@dex.adm.naquadah.org> <s5hwqz1i0y0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7689977508294943861=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.naquadah.org (prometheus.naquadah.org [212.85.154.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 7BBEF2616EE
 for <alsa-devel@alsa-project.org>; Mon,  8 Oct 2012 14:58:13 +0200 (CEST)
In-Reply-To: <s5hwqz1i0y0.wl%tiwai@suse.de> (Takashi Iwai's message of "Mon,
 08 Oct 2012 14:48:55 +0200")
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============7689977508294943861==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 08 2012, Takashi Iwai wrote:

> It's interesting.  So, _unmuting_ the input from NID 0x1d removes the
> noise?  (0x80 means the channel is muted.)

Yes, that's it.

(I just unloaded and reloaded the module and rechecked).

=2D-=20
Julien Danjou
=2D- Free Software hacker & freelance
=2D- http://julien.danjou.info

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQcs2zAAoJEGEbqVCLeKXCstcP/ifykmawUUcFbAUvD/MFOUTd
DgIJb3ze5/6NiyYsc4gG7n7pUPYpnM7eH+s2UvndIuBc6+s7yXlPbdR7MJXcEkQA
MaLNxiY3BQUc2lEh7V0hSreuiWlOycrMjZm1bOKXlZjDBmHFswV4FzUWYU/HWOF4
HGXDC/RIDg4VIya8LqEXTFR7j6aw/PH5Rv5b2vtFX55DCwmPNdjhe5thYaIZwBP8
4DXiMbVv5YL6GP65OmB3Kv0pOSPiOCNCDII2Fl/sV2GHU3oOF2oFNvCO5QNnqcah
npiDAqrzIpShx14EaoFKdQUvpTdXBabyYcct/mOqBQEJa2wWD9wh7LacD99As4Jp
JND4Ed9pZcEBhqiRuLHqO2AHzEGMcwMMh5uztDqPRcwW2xCr8Wxhcq68vMOB2zfR
69axPAqqtOMW4sREjz+kP7qaoOPVLrub03Cg+JxACmcGnxc3nC0Wtxlgw393PL/0
87vBj3cwaPIUZR3nVDHCbJVfnvWoI/XRpCjumrwz+ngPGIE42uRapsOCbXLF93Gd
k7vQcR/3iXTMSZiL+4WVXNOf2M7Exyy2rU+rFfM2wLz7OC+JrT2awCgJ2jq+Ei/A
/dCCiNL2qnTZ559ctPNx/vgsq96DaINZ6BXXpb5BX18VW62SigPRRL29G8KnZTFb
g5cC3F9wpzlMSb4XWbCS
=9420
-----END PGP SIGNATURE-----
--=-=-=--

--===============7689977508294943861==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7689977508294943861==--
