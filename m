From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: dapm: Add API call to query valid
	DAPM paths.
Date: Wed, 7 Mar 2012 19:15:48 +0000
Message-ID: <20120307191547.GX3107@opensource.wolfsonmicro.com>
References: <1331142952-6502-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0496839220730122724=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9EEBB10410C
	for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2012 20:15:50 +0100 (CET)
In-Reply-To: <1331142952-6502-1-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0496839220730122724==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vavxEBoGuREFpPEl"
Content-Disposition: inline


--vavxEBoGuREFpPEl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 07, 2012 at 05:55:52PM +0000, Liam Girdwood wrote:

> +struct snd_soc_dapm_widget_list;

I might be blind but I think the hunk that actually declares the widget
list got dropped from the header...  probably in some other part of the
series you haven't pushed out yet?

> +		dev_vdbg(widget->dapm->dev," %c : %s -> %s -> %s\n",
> +			path->sink && path->connect ? '*' : ' ',
> +			widget->name, path->name, path->sink->name);
> +

This and the input user look like good candidates for a tracepoint, it's
probably pretty useful to have them around and more accessible than vdbg
is.  It's the sort of information people often look for, and it's real
time unlike the debugfs picture which isn't capturing stuff when DAPM is
looking at it.

> +	dapm_reset(card);

This function isn't in mainline, another patch series reordering thing I
expect.  It does also look like we need some locking somewhere along the
line here (even if the only thing here is a big scary comment saying the
relevant locks need to be held).

> +	dev_dbg(dai->dev, "%s: found %d paths\n",
> +			stream ? "capture" : "playback", paths);

Tracepoint again?  Much less clear for this one.  I do think we should
be dumping the stats we've been collecting for the neighbour walks, very
useful if performance blows up again.

--vavxEBoGuREFpPEl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPV7PZAAoJEBus8iNuMP3dh1IP/A6KjqZYw6EXTRkppNre4VRS
AT/8Df4MQwiZujFrTQGkPd9LE4o8wHDvgOKWUtXsV0ioB6aihp/JZzktLRdKBg7Q
uo+krg4uyIoafeXxnEyRlssFgokoutXs3mklGxZ2CgxpLL9bV17djcHhRmNyf6k1
WLw5i6R5qNlDDCcI3nCxgV+EZaCUUs5EXShv7e5Hvh1BLsek8LflZrkbiBkYHTE+
eH7K4ix0dXxIXzJVQzkyUQTcrojjWn6HP2U5NAYTAU6N5Cp/eveqBPqKsM0AG0e2
q2gbXY9FvKCZjTztBHZbW8IeWs4Yiqfk/4U/1craZ5gEGx6Jw7eLDEaTeMgcN0De
hogdsL56vIuMyWarn4F4W7O+WBd37EA+isQcGEY8Ts0jrVMPC3vJWZvXdXVRMYWG
6kxxErhdIJ6yVkXtrOuQ/X5aDyssAXO6FxcuSofg20R1eH3TAmW29j2SH3oaJAwm
EzEjWEhqmJDR4e2KvK82hB8XfXSYZgJ+tyH5e5XkQlvbIKVlzGUIGtPb1kr9ybL0
7xloaodIjrKx42nQjCwU4W7zi3R+TAc2FFV5amtfp5S3kCjQHPD4OD0EmW74vrKD
TYp0kcVYIrWRuNVKyq9sqHZR4qQW+Z616m076aJcZQlVL1Ndwpx7JN6+LrO1CvXV
hrWqg33kxrf6K4IA/8TJ
=3aqz
-----END PGP SIGNATURE-----

--vavxEBoGuREFpPEl--

--===============0496839220730122724==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0496839220730122724==--
