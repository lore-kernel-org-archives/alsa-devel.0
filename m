From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/6] ASoC: Intel: Add trace support for
 Haswell/Broadwell SST IPC messages.
Date: Fri, 21 Feb 2014 14:19:06 +0900
Message-ID: <20140221051906.GD25940@sirena.org.uk>
References: <1392932927-9725-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <1392932927-9725-4-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4720949038713316272=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 700FD26172B
 for <alsa-devel@alsa-project.org>; Fri, 21 Feb 2014 06:19:26 +0100 (CET)
In-Reply-To: <1392932927-9725-4-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============4720949038713316272==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8w3uRX/HFJGApMzv"
Content-Disposition: inline


--8w3uRX/HFJGApMzv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 20, 2014 at 09:48:45PM +0000, Liam Girdwood wrote:
> Provide a trace mechanism for debugging Haswell/Broadwell specific SST
> IPC messages.

Applied, thanks.

> +	TP_STRUCT__entry(
> +		__field(	unsigned int,	status		)
> +		__field(	unsigned int,	mask		)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->status = status;
> +		__entry->mask = mask;
> +	),
> +
> +	TP_printk("status 0x%8.8x mask 0x%8.8x",
> +		(unsigned int)__entry->status, (unsigned int)__entry->mask)

I found out the other day that the trace infrastructure has a neat
helper called __print_symbolic which can decode things - might be
helpful for some of these, though I don't think it does bitfields it
might help with making the IPC messages more legible.

--8w3uRX/HFJGApMzv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBuHHAAoJELSic+t+oim9PMsP/RFAGBR278SalL0AfUNxgUz6
gOoTwnDv24u3SGOdf0/s4cdsNAGdWdbF5llkondtHk+Gxz8KUkQb6pJvoZRUDLJM
B+INgnSyuT3TxJuxs11Ww0eqbjwUnHhS4QJl5Gks5rguLto2bVI6YCUeyeNZwmmf
LK+HQlQkkLh688H/pU4ZgfO1kHfQXWrk/mfFHvR7o/bz3+sN0ArwVYf3/H+2Dsd1
fY113WOIbwL2bvpP7om5RES9MqOWBucbOKFMF+RelIpyh47YLrar3kCW+6g4G1Rv
V15d5+BRleMxJwABxtuK+CtlzGgdedqkHb1qu2Y3L/XY3Jip9qRSrSYyAtmQLaa1
3hzmJINhugqK8rxUAf+FCVgPzbMQFyMOkRrFQyApWBIYw+Dyt+wn/88CdVpRFPYf
FgFRchksciv3tqAovvMJguFcda1c5hqQU9WB1qR8WX7JNSd/+JizwREpvMYZW7gt
L8FuuxZjzt/yPLogKw8p9ZzVgpQ8vUX+G0pSZ2x2VMRC87zZsrFCSSxb6KcVlyn2
jwxrhBUAu2TcuA7Gf8Xv7BdAO8gf5pmp7JL8MoEZPoWB+8m97nfR4rLfoHvAGuaU
o8JJTMVPzFyFVnlbbszxFTZ/emLmhL85UxeDdv6McjFI7ZzIvKfLydbsEey1dpSI
zUA8g0T330IKUzoJuo/m
=tRmp
-----END PGP SIGNATURE-----

--8w3uRX/HFJGApMzv--

--===============4720949038713316272==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4720949038713316272==--
