From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: nau8825: non-clock jack
 detection for power saving at standby
Date: Mon, 9 May 2016 17:35:28 +0100
Message-ID: <20160509163528.GD3458@sirena.org.uk>
References: <1461917718-25211-1-git-send-email-KCHSU0@nuvoton.com>
 <20160502162715.GK6292@sirena.org.uk>
 <57286D40.6030002@nuvoton.com>
 <20160504163943.GZ6292@sirena.org.uk>
 <572C4AB6.9030106@nuvoton.com>
 <20160506181855.GZ6292@sirena.org.uk>
 <572FFCA7.8030604@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4180623225110769666=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D86A82654D4
 for <alsa-devel@alsa-project.org>; Mon,  9 May 2016 18:37:58 +0200 (CEST)
In-Reply-To: <572FFCA7.8030604@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: AP MS30 Linux ALSA <alsa-devel@alsa-project.org>, "anatol.pomozov@gmail.com" <anatol.pomozov@gmail.com>, AC30 YHChuang <YHCHuang@nuvoton.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "benzh@chromium.org" <benzh@chromium.org>, AC30 CTLin0 <CTLIN0@nuvoton.com>, MS40 MHKuo <MHKuo@nuvoton.com>, "yong.zhi@intel.com" <yong.zhi@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============4180623225110769666==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1sNVjLsmu1MXqwQ/"
Content-Disposition: inline


--1sNVjLsmu1MXqwQ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 09, 2016 at 10:57:43AM +0800, John Hsu wrote:
> On 5/7/2016 2:18 AM, Mark Brown wrote:

> > I'm not sure I fully follow the above explanation.  I appreciate that
> > power consumption is not going to be optimal when the clock is provided
> > and the chip is idle but does it actually stop anything working?

> The conditional check for the situation is limited. Only when jack dis-
> connect, the clock id just will be restricted. Do you think it is better
> to control by machine driver and codec driver not to add any restriction?

Well, the machine driver has to cope anyway.  What's not clear to me is
if the device *has* to use the internal clock when doing accessory
detection or if it's just lower power.

> > I don't see how the probe function can handle the fact that the resume
> > function is unconditionally calling enable_irq()?

> Maybe I'm not very clear about what the probe function means. Could you

The probe function is the function that runs on device probe, usually
with probe() in the name.  The relevant one here is nau8825_i2c_probe().

> tell me more detail? The codec resumption recovers the interruption func-
> tion because the function turns off when suspension. The interruption is
> managed in resume setup function after resumption. The driver will enable
> the insertion and ejection interruptions here. Let the codec to detect the
> event and do report instead of manual check the jack status.

There may not *be* an interrupt.

--1sNVjLsmu1MXqwQ/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXMLxPAAoJECTWi3JdVIfQzrIH/RTn5/5Yn4+eNjoISVE/57ZV
qpjbafLnJHbJTTrDFEnBOQxqPER1a3HwUmNswvDUFtUcJTgyIi5vNgYN5hlDbv4C
HZ2gBqfV7mWPQ+pHwR75353Cgjs1iwtvErv601C58AlvMJwhva3hndzavhA9wE6f
jYCCOgQ+4N8Zc0DGObs2I0avQMWKRvtGMDMgoMBsJeThELcv44ZEIFI3X1lDY84m
H7Y2fyGNj2cxIiJ2E5lVVnrdxfE7wkb9V941gcx/jYwBFcVv27MgFKo6UmmmgsSy
feKlEFpreYPV74Cx1mUuwDuXEcCykPLZao7INzh80NTL65BQRU6ygwwB5qgtlxA=
=yn2L
-----END PGP SIGNATURE-----

--1sNVjLsmu1MXqwQ/--

--===============4180623225110769666==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4180623225110769666==--
