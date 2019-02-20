From: Mark Brown <broonie@kernel.org>
Subject: Re: [Sound-open-firmware] [PATCH v4 04/14] ASoC: SOF:
 Add support for IPC IO between DSP and Host
Date: Wed, 20 Feb 2019 17:31:47 +0000
Message-ID: <20190220173147.GE9878@sirena.org.uk>
References: <20190213220734.10471-1-pierre-louis.bossart@linux.intel.com>
 <20190213220734.10471-5-pierre-louis.bossart@linux.intel.com>
 <s5hef8aziwh.wl-tiwai@suse.de>
 <f44964a2-9339-6cd8-c30e-c139316dc7ad@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3715363500696685090=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <f44964a2-9339-6cd8-c30e-c139316dc7ad@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Daniel Baluta <daniel.baluta@gmail.com>, andriy.shevchenko@intel.com, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, sound-open-firmware@alsa-project.org, Alan Cox <alan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============3715363500696685090==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qFgkTsE6LiHkLPZw"
Content-Disposition: inline


--qFgkTsE6LiHkLPZw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 14, 2019 at 08:56:42AM -0600, Pierre-Louis Bossart wrote:
> On 2/14/19 5:52 AM, Takashi Iwai wrote:
> > Pierre-Louis Bossart wrote:

> > > +		ret = snd_sof_dsp_get_reply(sdev, msg);
> > > +		if (msg->reply_size)
> > > +			memcpy(reply_data, msg->reply_data, msg->reply_size);

> > I'd add a sanity check here for avoiding a buffer overflow.
> > The reply buffer seems to be allocated in PAGE_SIZE.  Will it be more
> > than that?

> Good point, we'll check all the info returned by the DSP and see if they
> need to be range-checked or size-checked.

I think it's better to just do the range checks even if they're not
needed right now, it's safer in case someone adds bigger messages or
there's some bug that corrupts the size.

--qFgkTsE6LiHkLPZw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxtjwIACgkQJNaLcl1U
h9Azrgf8DeWrIA0h29MUDYNs4F1kTtgpMki7/mLlu3rpXmq4udSCZxZy2/3QqKyz
lHhrMPAzEHLH8nLuJH8uJuxfBFu5ZfkYgNufKqsHr7uXwtyhxgbu09+37hAqZlYE
QVvzweBnObgPDKVE/p0xQoCDf2Ts77ZGBLVot0nU3/RKLBZuKy0kYqcAs+X1Q5Cn
565zAmITLsAQdqwsmiNZ/m7/FJqFs2XchNlyE5y2Xzf5Xohkg4VwZYg26rZTwa8o
5nsFpCHIhkjaU9PzZFgbTwVxJs/FyKxh6wV+xaOGnC++Da6HeqZtqVNU3uysUOZW
3vLEusBM+CeGiYrY8nsp+OiE7N+lXA==
=pKeo
-----END PGP SIGNATURE-----

--qFgkTsE6LiHkLPZw--

--===============3715363500696685090==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3715363500696685090==--
