From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ALSA: PCM - Add PCM creation API for
 internal PCMs.
Date: Wed, 8 Feb 2012 22:57:34 +0000
Message-ID: <20120208225728.GA6596@sirena.org.uk>
References: <1328733211-3234-1-git-send-email-lrg@ti.com>
	<s5hk43xypmq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5624042071117179980=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 357D9103894
	for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2012 23:57:43 +0100 (CET)
In-Reply-To: <s5hk43xypmq.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============5624042071117179980==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 08, 2012 at 10:35:57PM +0100, Takashi Iwai wrote:
> At Wed,  8 Feb 2012 20:33:31 +0000,
> Liam Girdwood wrote:

> > The new ASoC dynamic PCM core needs to create PCMs and substreams that are
> > for use by internal ASoC drivers only and not visible to userspace for
> > direct IO. These new PCMs are similar to regular PCMs expect they have no
> > device nodes or procfs entries. The ASoC component drivers use them in exactly
> > the same way as regular PCMs for PCM and DAI operations.

> The changes look OK to me, but could you fix a few errors/warnings
> by checkpatch.pl?

Since Liam's got a whole raft of ASoC changes depending on this one can
you please either apply it to a branch or ack it for merge via ASoC?

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPMv3JAAoJEBus8iNuMP3dR6QP/RPgLdtRUF6pcDIzGITxJNJL
T3V2vCPW4w4Lr1qvWaX5WMjzu93TJcznKu4A8hPpo4YJdjnozSlL1yo0GKyKNL5/
eh45cpL45EaEmPYPGH5CXdR5QtS8bPwgoYmWnLMeytdWzAuvEGuAcUjaRqQJU2Iq
JJpm5HcLyJuUaUReodiGMWT2VMquJa3GHFH0rcB4SQoazTLa2ME5J+0ZXK/Hmrjd
35eyJ66PxWny8YZYeHFpd6SYpXDnAes+nHJDrIZ272fIifIihjDpuX34sQDBPrKi
DdMGjnO8aN/L89F4NzcVZsWwgecZ8jNQ3TVEBm5L9FL5g3DZ/mdSCZIcV67tLVF+
sJ/BNiDPUgVsLdckXCFSweEthkVLQhyrV4579dYzmleqwLUfOLXh9HyvtLWNI/xj
EWqInD2pbH3smQfs3SyuRE5nUXZ67JgJM+OOZju3FAO8iLT/HXRYRD+oRNf2YUbA
RYx21p+HZLvubj65wOH4tyr0V6/uIsOyG6pJohOsCJ6ueWdyRANI11jXzL7VTJmj
I2SNnpZtdwvvTQFvX/lr6jzaWANIPyFQ/yiKMuWI1EJCC9zdOMJzO+pppsxJaerw
nqGgtU/q9T+jtxKgRNBU6PqP1fj7I5vPBm4dVOIQV2+BUwG6TrIPr5kqreW4Og5f
HroMpaj1fCKEgc7l4NkT
=6Qs0
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--

--===============5624042071117179980==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5624042071117179980==--
