From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 6/8] ASoC: dapm: Implement and instantiate
 DAI widgets
Date: Thu, 23 Feb 2012 15:25:34 +0000
Message-ID: <20120223152534.GC4553@opensource.wolfsonmicro.com>
References: <1329458170-22119-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1329458170-22119-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1329468009.24656.15.camel@vkoul-udesk3>
	<1329914154.24656.95.camel@vkoul-udesk3>
	<20120222124301.GA7340@opensource.wolfsonmicro.com>
	<1329915673.24656.107.camel@vkoul-udesk3>
	<20120222132912.GI7340@opensource.wolfsonmicro.com>
	<1329979803.24656.125.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3127375507366306862=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5DFA61041C1
	for <alsa-devel@alsa-project.org>; Thu, 23 Feb 2012 16:25:37 +0100 (CET)
In-Reply-To: <1329979803.24656.125.camel@vkoul-udesk3>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============3127375507366306862==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vEao7xgI/oilGqZ+"
Content-Disposition: inline


--vEao7xgI/oilGqZ+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 23, 2012 at 12:20:03PM +0530, Vinod Koul wrote:

> Sorry but I am not able to comprehend how the core created playback and
> capture widget in the dai, which would be now used to trigger the
> stream_event instead of stream name is being associated with DAPM map.

That was essentially the entire content of the patch you're replying
to...  the actual creation happens in snd_soc_dapm_new_dai_widgets().

> Earlier we would check the stream_name and find the widgets
> corresponding to this and power up, how exactly would it work now :)

See "ASoC: dapm: Convert stream events to use DAI widgets".

--vEao7xgI/oilGqZ+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPRlpnAAoJEBus8iNuMP3dFygP/3DE+hdJvHDgKFrfsoflgD0r
erDUCKLR36nHV+eYPN4H7baOLumFkv5Z65qBotXZHZ2k7iVJ/FACyFIvqFreexb+
iWds8ho4fDG41foJuBv9Dl+GOOAPVmwuRSE0hZRVT/hIUZiWI5iGte1rV42BFA3F
B46xayGVWIDaGX1Aa+uFD5jjOfbaqB9+dJdMhy6DYkRx9acNsapJCn4UUPSvOiuS
ps507qgI89CTuJJz51jxJJdq87XNDtpLOPWoZzr8iblZ531FQCKygEgBCiC4ARrN
C+csbK+0tNDl9WR79Pph4pa7PVNboz7ITBHwzmZSARn8fIkB4F+osircr+LFn9ep
MwLSgy89HLQQXXNR0y6c2NKXyWZonCv5Rw6C7CzDDLud1WeRbvMoi7+EoOodptD3
hSpuZfd3+pQ9pJOoAViASmKu2P5Fye5ZCfudTfH/99yIxtUpl3kk9L3IlAEaKeT4
n3DHPAuB+XEnzTRjBiXXkX1hsoniAwqfX4VIjxfplc2Nv1ELazYoYO4oLzr8pfFW
zNYh1+3h/biy0WDVLSACUbiE/jG3vQ3o8hr/7ZFxS4Im8BkrK5gYz7KMUckb0Il2
NBB3DL4LOScuL0JKQykUznAths4KrFbLjQ1MRIqG4dEBrY7ho+j/zzLQGXD2PY7W
wMyWdJ2hDjirVHeMC5lX
=QybF
-----END PGP SIGNATURE-----

--vEao7xgI/oilGqZ+--

--===============3127375507366306862==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3127375507366306862==--
