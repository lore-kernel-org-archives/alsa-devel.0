From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: core: init delayed_work for
	codec-codec links
Date: Fri, 2 Aug 2013 11:14:54 +0100
Message-ID: <20130802101454.GI9858@sirena.org.uk>
References: <20130731131627.GA32631@opensource.wolfsonmicro.com>
 <20130802100108.GA17936@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5990253107177774356=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 7BBEA265646
 for <alsa-devel@alsa-project.org>; Fri,  2 Aug 2013 12:14:57 +0200 (CEST)
In-Reply-To: <20130802100108.GA17936@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============5990253107177774356==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VcQ2MTg63lIaL1+E"
Content-Disposition: inline


--VcQ2MTg63lIaL1+E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 02, 2013 at 11:01:08AM +0100, Richard Fitzgerald wrote:

> +static void codec2codec_close_delayed_work(struct work_struct *work)
> +{
> +	/* No action required.
> +	 * C2C links only represent a hardware connection and currently
> +	 * we assume that we don't have to explicitly start or stop them
> +	 */
> +}

That's not the reason - what's happening with the stream events is that
since these links are not on the edge of the DAPM graph we don't need to
interface with the outside world.  Further since we're not dealing with
the application layer there is no need to delay the power down, the
reason that's there is to stop us powering the link down if there's just
a small gap between tracks so we don't get pops, clicks and extra gaps
if the application layer is closing the device at the end of every track
(which is quite a common pattern).

--VcQ2MTg63lIaL1+E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR+4aaAAoJELSic+t+oim9vcoP/05uOUSkkRVN7l50GoGKgDUz
p/h1s6J/I+EpSYp+5f3wFgrJkriY0BTt+fdQjCUJlNO/x3EscvbcFCJBO5YAHH3R
xWCZ+otMRRX8K2pi7gXpC0obKyvR9ODsgjpNYmmfg9yhk2YUM+47vbtDU5Ms8zqs
3aoZbpIPATX8XMNrzwAJSYEM9Zyg5CwC/crR6O9HO3slQy/KRtrdYJQjVBVtfajC
gZDGXemJlGazIT++L01qU8ul/nHhPYuxD5kQ6/0F/JD1OznOkHqFUhGzKr8bWWip
eti313mEDDvcs7s6bzB6TloMyYYVFKhdJhltK6kI6xxZnGgBjHLxC7mOLTnWkBW+
ydTQBg4Ch3tvBEouWaT3sBexG5eBM9+W1P5fL1ZVa+qdJsHhehsfnUFHVJI4U4cQ
S9Fcy9wrClvgtmymKJhBwkN/iidKRA+E2YAYikgkBOnzo+cy5LAQ9ADCUysTDCEj
idjDg9k2Y8UACsQbisIl/GnXS9HN53CojlcXqeGG1KVbJScHZowNK8X70h02EJ6+
72Jdk1knCVmswrSqR6JWrUTjg79b35NwzaXnCy5NZbz1fRigQg95ciEWD+5wEeQ/
ZOtxs+bsPj/dPS/ZuY2VFDo5Cgl4UEBgkosPJqh9i3EHRDYItHTMPO/ehf09161f
ji9vrqA3ow8K4eA/eanV
=CyIX
-----END PGP SIGNATURE-----

--VcQ2MTg63lIaL1+E--

--===============5990253107177774356==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5990253107177774356==--
