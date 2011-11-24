From: =?ISO-8859-1?Q?Daniel_Gl=F6ckner?= <dg@emlix.com>
Subject: Re: [PATCH] ASoC: Convert s6000 directory
	to	module_platform_driver
Date: Thu, 24 Nov 2011 11:41:33 +0100
Message-ID: <4ECE1F5D.5040909@emlix.com>
References: <1322108096.16201.17.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.emlix.com (mx1.emlix.com [193.175.82.238])
	by alsa0.perex.cz (Postfix) with ESMTP id 45FA4244B5
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2011 11:41:36 +0100 (CET)
In-Reply-To: <1322108096.16201.17.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, =?ISO-8859-1?Q?Daniel_Gl=F6ckner?= <daniel-gl@gmx.net>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 11/24/2011 05:14 AM, Axel Lin wrote:
> Factor out some boilerplate code.
> =

> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
>  sound/soc/s6000/s6000-i2s.c |   12 +-----------
>  sound/soc/s6000/s6000-pcm.c |   12 +-----------
>  2 files changed, 2 insertions(+), 22 deletions(-)

Acked-by: Daniel Gl=F6ckner <dg@emlix.com>


-- =

Dipl.-Math. Daniel Gl=F6ckner, emlix GmbH, http://www.emlix.com
Fon +49 551 30664-0, Fax +49 551 30664-11,
Bertha-von-Suttner-Stra=DFe 9, 37085 G=F6ttingen, Germany
Sitz der Gesellschaft: G=F6ttingen, Amtsgericht G=F6ttingen HR B 3160
Gesch=E4ftsf=FChrer: Dr. Uwe Kracke, Ust-IdNr.: DE 205 198 055

emlix - your embedded linux partner
