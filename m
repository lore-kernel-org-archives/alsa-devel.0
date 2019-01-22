From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 04/14] ASoC: SOF: Add support for IPC IO
 between DSP and Host
Date: Tue, 22 Jan 2019 19:04:25 +0000
Message-ID: <20190122190425.GJ7579@sirena.org.uk>
References: <20181211212318.28644-1-pierre-louis.bossart@linux.intel.com>
 <20181211212318.28644-5-pierre-louis.bossart@linux.intel.com>
 <20190109203720.GQ10405@sirena.org.uk>
 <876df209-c829-873e-047e-c73fb0579d68@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8260446864915129304=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <876df209-c829-873e-047e-c73fb0579d68@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, andriy.shevchenko@intel.com, tiwai@suse.de, Daniel Baluta <daniel.baluta@gmail.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, Alan Cox <alan@linux.intel.com>, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8260446864915129304==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mXDO3udm/xYWQeMQ"
Content-Disposition: inline


--mXDO3udm/xYWQeMQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 10, 2019 at 02:11:32PM -0600, Pierre-Louis Bossart wrote:

> > > +	/* attach any data */
> > > +	if (msg_bytes)
> > > +		memcpy(msg->msg_data, msg_data, msg_bytes);

> > How big do these messages get?  Do we need to hold the lock while we
> > memcpy()?

> Messages can be as big as the mailbox, which is hardware dependent. It could
> be from a few bytes to a larger e.g. 4k page or more, and indeed we need to
> keep the lock.

Is this copying into an actual mailbox or into some data structure in
memory?  It looked like it's copying into a buffer for sending rather
than the mailbox.

> > > +	/* schedule the message if not busy */
> > > +	if (snd_sof_dsp_is_ready(sdev))
> > > +		schedule_work(&ipc->tx_kwork);

> > If the DSP is idle is there a reason this has to happen in another
> > thread?

> we will rename this as snd_sof_dsp_is_ipc_ready() to avoid any confusion
> with the DSP state. We only care about IPC registers/doorbells at this
> point, not the fact that the DSP is in its idle loop.

You're missing the point - why can't we just immediately send the
message to the DSP from here, what's the benefit of scheduling some work
to do that?

> > > +	spin_unlock_irqrestore(&sdev->ipc_lock, flags);

> > The thread is also going to take an irq spinlock after all.

> didn't get this point, sorry.

One reason to bounce to another thread would be to do something that you
can't do in this context like take a lock in a place you can't take
locks but here we're taking a lock that needs thread context already.

--mXDO3udm/xYWQeMQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxHaTkACgkQJNaLcl1U
h9DO9Af/VhFhkpP3MuLWamLo6z0z3pXUSpGtFaacYoO4rko0ToCqlqnz1bhKmN1Y
6NINWRLMjzoincmeVtKZxjeB1IvEdKhfkx7WEgfBDnsXFBgaL9XENcZUZ7AqxGSM
dRdkwlCPEU23LkbBnK+8GVES8bZT2U1hl4zo9YFLlIeIPgZP9ZDVGkrUCBP67Qt7
x10XrwZRMcQJ1x+WOlA3kTgf+O9t06mNlX7rSQ8T1hTZWnXGtFMEMTasQtmiL+Dz
tJGIvixwY5/5V+eSp+AXanV1cU2QCarDlptOvyqsU8c8+s+1BwmHEeuBK/v2u+mQ
FukGrEc17VRZkOJA4WbfG535fd1JdQ==
=NgF9
-----END PGP SIGNATURE-----

--mXDO3udm/xYWQeMQ--

--===============8260446864915129304==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8260446864915129304==--
