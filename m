From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v1 4/5] ASoC: add mmp brownstone support
Date: Fri, 8 Jun 2012 06:13:26 +0800
Message-ID: <20120607221325.GB14525@opensource.wolfsonmicro.com>
References: <1338791851-21038-1-git-send-email-zhangfei.gao@marvell.com>
	<1338791851-21038-5-git-send-email-zhangfei.gao@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4413058916751926029=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1338791851-21038-5-git-send-email-zhangfei.gao@marvell.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Eric Miao <eric.y.miao@gmail.com>, Leo Yan <leoy@marvell.com>, Vinod Koul <vinod.koul@intel.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Liam Girdwood <lrg@ti.com>, Qiao Zhou <zhouqiao@marvell.com>, Chao Xie <cxie4@marvell.com>, alsa-devel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============4413058916751926029==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NDin8bjvE/0mNLFQ"
Content-Disposition: inline


--NDin8bjvE/0mNLFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 04, 2012 at 02:37:30PM +0800, Zhangfei Gao wrote:

One small thing here...

> +	ret = snd_soc_add_card_controls(dapm->card, brownstone_dapm_control,
> +				   ARRAY_SIZE(brownstone_dapm_control));
> +	if (ret < 0)
> +		return ret;

You can just set these up with the controls member of the card struct.

--NDin8bjvE/0mNLFQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP0Sd5AAoJEBus8iNuMP3dc/0QAI3rZ25RE7K0VYkZMjayJsJH
e+zHoD2NZ0uHdk9c/7baMZImR0xNqfEQY6yz6yCmvfSy7WE4my10LsvGz4mSyQKn
E21YjVFhF5m5yFy0NuOmDrbg/JdT+UOR53ZY9SMaxsIq+B/FvxYlsYwxo4urRlFY
1QVVUI05rtKQW3IcS2k2izfrfRAJbZG4ByLgQc9p8qlPutIKkaJaRgRQBT27JLaL
vovD6lwQDH0Ja/wX8RBcydsS0CZYPiLq6Hu7TxJpyCpNhkxBrrwmvXq0tS3YzRf0
SQjGK6rzoUGJ6vc0K/2U1s8/iKV/A+0+kUaGLojBiGBmhVLGxq/xzAr1gODZ/JnB
rG1Pw7WR6ovuxQXFW2lM6gMspfqJ1WJyBoSaqQVPuG8GIY+qxAWKmph13LGnUi9j
JkbGX7JU9QJBk0Wdqt/7yO8MI2jVgMsCbY+SyqtUV4nQvm8iPS0FmOTVyHMQeNKz
4M20HtdC3KobM0AVNcv/xaeNtEvPvyuZRhsLrcQH2GM0dd85zpgNaTY48/ny9PSq
Hg+/4IqYnlZsoi2PMwtaZuQWv2WpggqUObuohHWywGbIBkWtknBfTGEkeZ6Rnfne
Rn8Fi35bpzimAo5vDc7bHfFsqgPp0LxuzPAErw0pRLV60+EHqkSjEWptwOaQfaHj
gfPUK/q7mPtXQ7qVGrYE
=TW1x
-----END PGP SIGNATURE-----

--NDin8bjvE/0mNLFQ--
--
To unsubscribe from this list: send the line "unsubscribe alsa-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


--===============4413058916751926029==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4413058916751926029==--
