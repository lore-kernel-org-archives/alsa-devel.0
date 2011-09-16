From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH v3 1/1] ASoC: mxs-saif: add record function
Date: Fri, 16 Sep 2011 10:53:51 +0800
Message-ID: <CAA+hA=QTeNuq5rCMDWjvKiRK9xX8TFKqaXN31Cpt3RU-kogn2w@mail.gmail.com>
References: <1315399910-6525-1-git-send-email-b29396@freescale.com>
	<CABS+qY12ChK=aA-eOERH5ATWKcQdp3wE48SsBNcpe0nDzXWOMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 4E0ED103C86
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Sep 2011 04:53:55 +0200 (CEST)
Received: by gyg4 with SMTP id 4so2918971gyg.38
	for <alsa-devel@alsa-project.org>; Thu, 15 Sep 2011 19:53:52 -0700 (PDT)
In-Reply-To: <CABS+qY12ChK=aA-eOERH5ATWKcQdp3wE48SsBNcpe0nDzXWOMw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Girdwood, Liam" <lrg@ti.com>, broonie@opensource.wolfsonmicro.com
Cc: alsa-devel@alsa-project.org, Dong Aisheng <b29396@freescale.com>, s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org, w.sang@pengutronix.de
List-Id: alsa-devel@alsa-project.org

Hi Mark,

2011/9/9 Girdwood, Liam <lrg@ti.com>:
> On 7 September 2011 13:51, Dong Aisheng <b29396@freescale.com> wrote:
>
>> 1. add different clkmux mode handling
>> SAIF can use two instances to implement full duplex (playback &
>> recording) and record saif may work on EXTMASTER mode which is
>> using other saif's BITCLK&LRCLK.
>>
>> The clkmux mode could be set in pdata->init() in mach-specific code.
>> For generic saif driver, it only needs to know who is his master
>> and the master id is also provided in mach-specific code.
>>
>> 2. support playback and capture simutaneously however the sample
>> rates can not be different due to hw limitation.
>>
>> Signed-off-by: Dong Aisheng <b29396@freescale.com>
>> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
>> Cc: Liam Girdwood <lrg@ti.com>
>> Cc: Sascha Hauer <s.hauer@pengutronix.de>
>> Cc: Wolfram Sang <w.sang@pengutronix.de>
>>
>> ---
>> Changes since v2:
>> =A0* remove mach-specific code(clkmux in DIGCTL) out of saif driver
>> =A0For supporting EXTMASTER mode, SAIF only nees to know who's
>> =A0its master and the master id is provided by mach layer according
>> =A0to different clkmux setting.
>> =A0So we need to add a pdata->get_master_id();
>>
>> Changes since v1:
>> =A0* calc the delay based on the rate
>> =A0* change the saif.h #ifndef micro to match the directory
>> ---
>> =A0include/sound/saif.h =A0 =A0 | =A0 16 +++++
>> =A0sound/soc/mxs/mxs-saif.c | =A0145
>> +++++++++++++++++++++++++++++++++++++++++-----
>> =A0sound/soc/mxs/mxs-saif.h | =A0 =A04 +
>> =A03 files changed, 151 insertions(+), 14 deletions(-)
>>
>>
> Acked-by Liam Girdwood <lrg@ti.com>
>
Can you apply this?

Also with the tag:
Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>

Regards
Dong Aisheng
