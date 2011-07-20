From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH v4 01/10] ASoc: mxs: add mxs-pcm driver
Date: Thu, 21 Jul 2011 00:49:28 +0800
Message-ID: <CAA+hA=SDDdf-Px1J_0CjE57QA2-n-=+=vH0Xpnqt=E5v1L1p7A@mail.gmail.com>
References: <1311133306-9496-1-git-send-email-b29396@freescale.com>
	<1311133306-9496-2-git-send-email-b29396@freescale.com>
	<4E26FF9D.1070000@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gw0-f51.google.com (mail-gw0-f51.google.com [74.125.83.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 604F42433F
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Jul 2011 18:49:29 +0200 (CEST)
Received: by gwj17 with SMTP id 17so571100gwj.38
	for <alsa-devel@alsa-project.org>; Wed, 20 Jul 2011 09:49:28 -0700 (PDT)
In-Reply-To: <4E26FF9D.1070000@ti.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "w.sang@pengutronix.de" <w.sang@pengutronix.de>, Dong Aisheng <b29396@freescale.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

2011/7/21 Liam Girdwood <lrg@ti.com>:
> On 20/07/11 04:41, Dong Aisheng wrote:
>> Signed-off-by: Dong Aisheng <b29396@freescale.com>
>> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
>> Cc: Liam Girdwood <lrg@ti.com>
>> Cc: Sascha Hauer <s.hauer@pengutronix.de>
>> Tested-by: Wolfram Sang <w.sang@pengutronix.de>
>> ---
>> =A0sound/soc/mxs/mxs-pcm.c | =A0359 ++++++++++++++++++++++++++++++++++++=
+++++++++++
>> =A0sound/soc/mxs/mxs-pcm.h | =A0 43 ++++++
>> =A02 files changed, 402 insertions(+), 0 deletions(-)
>>
>> diff --git a/sound/soc/mxs/mxs-pcm.c b/sound/soc/mxs/mxs-pcm.c
>> new file mode 100644
>> index 0000000..f9063e7
>> --- /dev/null
>> +++ b/sound/soc/mxs/mxs-pcm.c
>> @@ -0,0 +1,359 @@
>> +/*
>
> snip
>
>> +
>> +static u64 mxs_pcm_dmamask =3D DMA_BIT_MASK(32);
>> +static int mxs_pcm_new(struct snd_card *card, struct snd_soc_dai *dai,
>> + =A0 =A0 =A0 struct snd_pcm *pcm)
>>
>
> This API has been updated to pass in the runtime data only. Can you redo =
against -next.
>

Yes, i will do that and send an updated version based on for-next branch.
BTW, please let me know if the driver has any more issues or the patch
series version may increase a lot. :)

Regards
Dong Aisheng
