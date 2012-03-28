From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v5 2/8] ASoC: imx: merge sound/soc/imx into
	sound/soc/fsl
Date: Wed, 28 Mar 2012 10:42:18 +0800
Message-ID: <CAAQ0ZWSPJ-5gAJGEYwbyUzjM_Ho851RAHSTBYKgcMtYNRn6ktQ@mail.gmail.com>
References: <1331888204-27058-1-git-send-email-shawn.guo@linaro.org>
	<1331888204-27058-3-git-send-email-shawn.guo@linaro.org>
	<2976261.6mYHfHvpym@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lpp01m010-f51.google.com (mail-lpp01m010-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 0DF8F103EDF
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Mar 2012 04:42:18 +0200 (CEST)
Received: by laap9 with SMTP id p9so672546laa.38
	for <alsa-devel@alsa-project.org>; Tue, 27 Mar 2012 19:42:18 -0700 (PDT)
In-Reply-To: <2976261.6mYHfHvpym@laptop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?ISO-8859-1?Q?Philippe_R=E9tornaz?= <philippe.retornaz@epfl.ch>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

2012/3/27 Philippe R=E9tornaz <philippe.retornaz@epfl.ch>:
> Le vendredi 16 mars 2012 16:56:38 Shawn Guo a =E9crit :
>> Freescale PowerPC and ARM/IMX families share the same SSI IP block.
>> The patch merges sound/soc/imx into sound/soc/fsl, so that the possible
>> code sharing and consolidation can happen.
>>
>> This is a plain merge, except that menuconfig SND_POWERPC_SOC is added
>> in Kconfig for PowerPC platform as a correspondence to SND_IMX_SOC for
>> IMX platform.
>>
>> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
>> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
>
> This patch has been merged ? If yes in which tree is it available ?
>
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-3.5

Regards,
Shawn
