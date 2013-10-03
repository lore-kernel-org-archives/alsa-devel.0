From: =?ISO-8859-1?Q?Philippe_R=E9tornaz?= <philippe.retornaz@epfl.ch>
Subject: Re: [PATCH 1/2] ASoC: fsl: imx-ssi: fix probe on imx31
Date: Thu, 03 Oct 2013 18:07:27 +0200
Message-ID: <524D963F.5080507@epfl.ch>
References: <1380630971-11431-1-git-send-email-philippe.retornaz@epfl.ch>
 <1380630971-11431-2-git-send-email-philippe.retornaz@epfl.ch>
 <20131003155954.GV27287@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.epfl.ch (smtp4.epfl.ch [128.178.224.219])
 by alsa0.perex.cz (Postfix) with ESMTP id 8311D26557F
 for <alsa-devel@alsa-project.org>; Thu,  3 Oct 2013 18:07:29 +0200 (CEST)
In-Reply-To: <20131003155954.GV27287@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: fabio.estevam@freescale.com, s.hauer@pengutronix.de, shawn.guo@linaro.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Le 03/10/2013 17:59, Mark Brown a =E9crit :
> On Tue, Oct 01, 2013 at 02:36:10PM +0200, Philippe R=E9tornaz wrote:
>> On imx31 with mc13783 codec the FIQ is not necessary and not
>> enabled as DMA transfer is available. Change the probe() function
>> to fail only if both FIQ and DMA are not available.
>
> Is this something that used to work but has been broken or is this
> enabling a new feture?  Just wondering if this needs to be sent to
> Linus as a fix.
>

It was working but it is broken since a few release.
There is no need to rush for a fix, both patches can follow the standard
process.
Anyway, there is a pending fix on the imx-sdma driver in order to have the
sound fully working again on my board:
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-October/201498.h=
tml

Thanks !

Philippe
