From: Tim Howe <tim.howe@cirrus.com>
Subject: Re: [PATCH] ASoC: cs4349: Fix setting digital
	interface format
Date: Thu, 30 Jul 2015 16:33:49 -0500
Message-ID: <alpine.DEB.2.10.1507301631430.8028@ChromiumBuilder>
References: <1437316969.9569.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-858915358-1438292035=:8028"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from m0077473.ppops.net (mx0a-001ae601.pphosted.com [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 70E1126071A
 for <alsa-devel@alsa-project.org>; Thu, 30 Jul 2015 23:34:19 +0200 (CEST)
In-Reply-To: <1437316969.9569.1.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: alsa-devel@alsa-project.org, Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Tim Howe <tim.howe@cirrus.com>
List-Id: alsa-devel@alsa-project.org

--8323329-858915358-1438292035=:8028
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Sun, 19 Jul 2015, Axel Lin wrote:

> Mode Control - Register 02h
>=20
> Digital Interface Format (DIF[2:0]) Bits 6-4
>=20
> DIF2    DIF1    DIF0    Description
> 0       0       0       Left-Justified, up to 24-bit data
> 0       0       1       I=C2=B2S, up to 24-bit data
> 0       1       0       Right-Justified, 16-bit data
> 0       1       1       Right-Justified, 24-bit data
> 1       0       0       TDM slot 0
> 1       0       1       TDM slot 1
> 1       1       0       TDM slot 2
> 1       1       1       TDM slot 3
>=20
> The DIF_MASK is 0x70, so current code does not correctly set the DIFx
> setting. Fix it.
>=20
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
> I assume the path "ASoC: cs4349: Don't use rtd->codec" will be applied
> first, so this patch is on top of that patch.
>=20
>  sound/soc/codecs/cs4349.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>=20
Good catch, thanks!
Acked-by: Tim Howe <tim.howe@cirrus.com>
--8323329-858915358-1438292035=:8028
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--8323329-858915358-1438292035=:8028--
