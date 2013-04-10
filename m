From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ALSA: compress_core: Update calc_avail
 to use cumulative values
Date: Wed, 10 Apr 2013 14:03:12 +0100
Message-ID: <20130410130312.GB9243@opensource.wolfsonmicro.com>
References: <1364991209-24653-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20130409110230.GE31193@intel.com>
 <20130410100757.GC24051@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0767325611889188332=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C00C3265F7D
 for <alsa-devel@alsa-project.org>; Wed, 10 Apr 2013 15:13:46 +0200 (CEST)
In-Reply-To: <20130410100757.GC24051@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org


--===============0767325611889188332==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QQyEkJ+v1X6lF3FS"
Content-Disposition: inline


--QQyEkJ+v1X6lF3FS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 10, 2013 at 11:07:57AM +0100, Charles Keepax wrote:
> On Tue, Apr 09, 2013 at 04:32:30PM +0530, Vinod Koul wrote:
> > What is this patch based off< certainly not asoc/sound-next as I dont remember
> > this comment. IIRC comment was to test this for capture case!

> This patch is based off Mark's asoc/for-next tree, apologies I
> guess I should have based this of Takashi's for-next tree.
> Although I wouldn't have thought they would have differed here as
> there haven't been any updates recently appart from the meta-data
> stuff.

Thie FIXMEs appear to come from your initial commit, must've been dealt
with since.

--QQyEkJ+v1X6lF3FS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRZWMGAAoJELSic+t+oim9EEMP/3j8z+3Khnp13K09E3DVoZuL
3LjozSX/EGWbBP6/aK8AgHzkJzsIhNi2NYxfW2fAcmcZ9nvIzXLiWuPBTbhvOGtn
ppZqIeflaqUqso8kfPHqSw8AOJvc9fnZf826jlHi5B/mKmEuzuc2cGuOd25zGmeZ
z69F3HgTwxnmCP5T0361nfXlVYt4i6BAR3hKUPRCnPEm/YBrvhNoQnWxev4pRlMB
HG/2karBpjz9F336PIFN+6ODRtLKi9Vrs7XPW7mWaNPeKj6HQcD1sjBXiPECQfu3
gu7kbvkiYNel8yhQIImShfrmGuCcZAkRIbwtfUcSC1aOUh9SCUcy7v3iXiADgwp5
zial7X1LyQAcu8XF1Ki7qR3X3ROlJUxDSD5IGFUc6nHCn4tNiUhJJ0r+sH8sndra
Nqu3+cySnn6w5jWsYP/O7wvHK4ciImBQYzVxYdouSZhtwKhzHFrRBR3He3H73UB1
F7133RQ9rLOJjCwqCeepQv3F1QFO9ZtMA5fSZ4zg47mKkA06QEr0tiGm3PHQJSjM
YMTamZYKxAnAE7ZTKM/YuHpoUC/Zok0iB/M1Xc4iuT70DyXp6ztPZXsgyye4YG3j
s7SYEdSq7ouMc+/wGut2WjJmPropts/jEPGs7uTO30rA11SE7+O4tPgAUaxqdVCK
dyBmI/aMcQXx+fIC1wdA
=UF/g
-----END PGP SIGNATURE-----

--QQyEkJ+v1X6lF3FS--

--===============0767325611889188332==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0767325611889188332==--
