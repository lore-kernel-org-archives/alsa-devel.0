From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/8] sound:asoc: Add support for synopsys
 i2s controller as per ASoC framework.
Date: Mon, 26 Mar 2012 12:10:55 +0100
Message-ID: <20120326111055.GM3098@opensource.wolfsonmicro.com>
References: <cover.1332242166.git.rajeev-dlh.kumar@st.com>
	<7692a51789abe38e7066a582d8329dc93b8eced3.1332242166.git.rajeev-dlh.kumar@st.com>
	<20120320154420.GE3445@opensource.wolfsonmicro.com>
	<4F7030DA.2090009@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5437354701849730294=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4BFF5248EF
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Mar 2012 13:09:22 +0200 (CEST)
In-Reply-To: <4F7030DA.2090009@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rajeev kumar <rajeev-dlh.kumar@st.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, spear-devel <spear-devel@list.st.com>
List-Id: alsa-devel@alsa-project.org


--===============5437354701849730294==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="P9KQiUGMzYCFwWCN"
Content-Disposition: inline


--P9KQiUGMzYCFwWCN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 26, 2012 at 02:33:22PM +0530, Rajeev kumar wrote:
> On 3/20/2012 9:14 PM, Mark Brown wrote:
> >On Tue, Mar 20, 2012 at 05:03:46PM +0530, Rajeev Kumar wrote:

> >>+		if (dev->i2s_clk_cfg(config)) {
> >>+			dev_err(dev->dev, "runtime audio clk config fail\n");
> >>+			if (cpu_dai->driver->ops->trigger) {
> >>+				int ret =
> >>+					cpu_dai->driver->ops->trigger(substream,
> >>+							SNDRV_PCM_TRIGGER_STOP,
> >>+							cpu_dai);
> >>+				if (ret<  0) {
> >>+					dev_err(dev->dev,
> >>+							"trigger stop fail\n");
> >>+					return ret;
> >>+				}
> >>+			}

> >No, return an error if you encounter an error!

> You need not to stop controller in case clock fail ?

Let the upper layers worry about that.  Don't randomly change the state
of the controller without them knowing about it.


--P9KQiUGMzYCFwWCN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPcE52AAoJEBus8iNuMP3dbgwP/2xh/VjXWQXKhUyh++7HmjfL
i1dCMhA1AqpSm50mdqhkhvOxFmBpPJ0TXi9p6L4UIXpn7h956P2C6bfhVT2v105X
7loqfbGLBaS2299i4mKnZEpy5H5vzLgsVCCtmLrvNF5q8Knj2frAlQE6sFXZ1/O+
rNfd5S8T20MTHhK8EeFM33PXXDIIeShJYOs7nJhjUM66O5UaqRt69jiWrFWcjknV
jIiftAO6fBgpSrgMVN7HmVMbw4lqEGFuJffxov79eIb66rgRt4ilA7v/kYblyXjX
eoLyDwfLydixJZaJgLJvnnPOB6TG2eN3GsUjtF/PQ2X3yccgyfHEIsCH/YcEOkSW
HU47+9t1uM4ENpeezcsp7SACMQPnaE6Smqp/W6jkmCPzFn0xXJNKV05JhGibLsCq
v7sFy9eQxLMslcxzluYe+C14mQ+n25gmrrS5Tktgp/fGWTVVcKNRS+9XI9UclLMb
S9kVSRfXuW9QmLBYh9ST0i7dQPo6KpEsGtmX668U81xnBUVBwHxrXDSllpO8Bmbb
xUkdI+gmr+f/fzy7q97YdqoDma+wwn0VtBaKtTC4nB9T5kl0oHP1j84QefTmZSou
fOLwBHOW8zFSIzXqiGgGw6WeqGyDZ2VPG09EvHjaUImSQSOQ1bKIQQK4x2WOM2gp
wZ2ZhkkctXOkhRsJQGXM
=rLxU
-----END PGP SIGNATURE-----

--P9KQiUGMzYCFwWCN--

--===============5437354701849730294==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5437354701849730294==--
