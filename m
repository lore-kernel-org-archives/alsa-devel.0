From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH] ASoC: fsl_ssi: remove explicit register
	defaults
Date: Mon, 01 Feb 2016 13:07:59 +0100
Message-ID: <56AF4A9F.4060401@maciej.szmigiero.name>
References: <569D3800.2040801@maciej.szmigiero.name>
 <CAOMZO5DwQza+jDdkA80v4wkrB56y53tOjkP2-36YNq2WBLodaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vps-vb.mhejs.net (vi37-28-154-113.vibiznes.pl [37.28.154.113])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A64E260511
 for <alsa-devel@alsa-project.org>; Mon,  1 Feb 2016 13:08:11 +0100 (CET)
In-Reply-To: <CAOMZO5DwQza+jDdkA80v4wkrB56y53tOjkP2-36YNq2WBLodaA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Xiubo Li <Xiubo.Lee@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org

Hi Fabio,

On 01.02.2016 13:05, Fabio Estevam wrote:
> Hi Maciej,
> 
> On Mon, Jan 18, 2016 at 5:07 PM, Maciej S. Szmigiero
> <mail@maciej.szmigiero.name> wrote:
>> There is no guarantee that on fsl_ssi module load
>> SSI registers will have their power-on-reset values.
>>
>> In fact, if the driver is reloaded the values in
>> registers will be whatever they were set to previously.
>>
>> However, the cache needs to be fully populated at probe
>> time to avoid non-atomic allocations during register
>> access.
>>
>> Special case here is imx21-class SSI, since
>> according to datasheet it don't have SACC{ST,EN,DIS}
>> regs.
>>
>> This fixes hard lockup on fsl_ssi module reload,
>> at least in AC'97 mode.
>>
>> Fixes: 05cf237972fe ("ASoC: fsl_ssi: Add driver suspend and resume to support MEGA Fast")
>>
>> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> 
> I know I have already tested this and it worked fine on a mx6sabresd,
> but running linux-next 20160201 on a mx6sl-evk the ssi driver does not
> probe anymore:
> 
> [    2.216954] fsl-asoc-card sound: ASoC: CPU DAI (null) not registered
> [    2.223412] fsl-asoc-card sound: snd_soc_register_card failed (-517)
> [    2.230258] imx-wm8962 sound: ASoC: CPU DAI 202c000.ssi not registered
> [    2.236806] imx-wm8962 sound: snd_soc_register_card failed (-517)
> [    2.244782] snvs_rtc 20cc000.snvs:snvs-rtc-lp: setting system clock
> to 1970-01-01 00:01:14 UTC (74)
> [    2.285864] fsl-asoc-card sound: ASoC: CPU DAI (null) not registered
> [    2.292335] fsl-asoc-card sound: snd_soc_register_card failed (-517)
> [    2.299572] imx-wm8962 sound: ASoC: CPU DAI 202c000.ssi not registered
> [    2.306121] imx-wm8962 sound: snd_soc_register_card failed (-517)
> 
> Reverting this patch fixes the problem.
> 
> Wandboard also has the same issue:
> 
> http://arm-soc.lixom.net/bootlogs/next/next-20160201/wandboard-arm-imx_v6_v7_defconfig.html
> 
> Any suggestions?
> 
> Thanks
> 

Is regmap patch from 
http://www.spinics.net/lists/kernel/msg2161934.html
applied to the tested tree?

Best regards,
Maciej
