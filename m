From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH] ASoC: davinci-mcasp: set up user bits for
	S/PDIF mode
Date: Thu, 27 Mar 2014 09:39:26 +0100
Message-ID: <5333E3BE.80403@gmail.com>
References: <1395846273-26025-1-git-send-email-zonque@gmail.com>
 <5333DE63.1010205@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f52.google.com (mail-bk0-f52.google.com
 [209.85.214.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 95BF626524F
 for <alsa-devel@alsa-project.org>; Thu, 27 Mar 2014 09:39:41 +0100 (CET)
Received: by mail-bk0-f52.google.com with SMTP id my13so721576bkb.25
 for <alsa-devel@alsa-project.org>; Thu, 27 Mar 2014 01:39:41 -0700 (PDT)
In-Reply-To: <5333DE63.1010205@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, broonie@kernel.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Peter,

Thanks for your review.

On 03/27/2014 09:16 AM, Peter Ujfalusi wrote:
> On 03/26/2014 05:04 PM, Daniel Mack wrote:
>> In DIT (S/PDIF) mode, program the transmitted user bits to reflect the
>> configured sample rate, along with some other details.
>>
>> Signed-off-by: Daniel Mack <zonque@gmail.com>
>> ---
>>  sound/soc/davinci/davinci-mcasp.c | 55 +++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 53 insertions(+), 2 deletions(-)
>>
>> diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
>> index 712a7cd..ec0463a 100644
>> --- a/sound/soc/davinci/davinci-mcasp.c
>> +++ b/sound/soc/davinci/davinci-mcasp.c
>> @@ -27,6 +27,7 @@
>>  #include <linux/of_platform.h>
>>  #include <linux/of_device.h>
>>  
>> +#include <sound/asoundef.h>
>>  #include <sound/core.h>
>>  #include <sound/pcm.h>
>>  #include <sound/pcm_params.h>
>> @@ -566,8 +567,11 @@ static int mcasp_i2s_hw_param(struct davinci_mcasp *mcasp, int stream)
>>  }
>>  
>>  /* S/PDIF */
>> -static int mcasp_dit_hw_param(struct davinci_mcasp *mcasp)
>> +static int mcasp_dit_hw_param(struct davinci_mcasp *mcasp,
>> +			      unsigned int rate)
>>  {
>> +	u32 val = 0;
>> +
>>  	/* Set the TX format : 24 bit right rotation, 32 bit slot, Pad 0
>>  	   and LSB first */
>>  	mcasp_set_bits(mcasp, DAVINCI_MCASP_TXFMT_REG, TXROT(6) | TXSSZ(15));
>> @@ -589,6 +593,53 @@ static int mcasp_dit_hw_param(struct davinci_mcasp *mcasp)
>>  	/* Enable the DIT */
>>  	mcasp_set_bits(mcasp, DAVINCI_MCASP_TXDITCTL_REG, DITEN);
>>  
>> +	/* Set S/PDIF channel status bits */
>> +	mcasp_set_reg(mcasp, DAVINCI_MCASP_DITCSRA_REG + 0,
>> +		      IEC958_AES0_CON_NOT_COPYRIGHT);
> 
> I think it would be safer to set the channel status bits like:
> u32 val = 0;
> u8 *bytes = (u8*) &val;
> 
> byte[0] |= IEC958_AES0_CON_NOT_COPYRIGHT;
> byte[1] |= IEC958_AES1_CON_PCM_CODER;

No, these defines are mapped on to 32-bit values, as seen in
include/sound/asounddef.h. Over all 6 registers, 192 bits can be stored,
which is the full length of channel status bits. Hence, they really need
an individual mcasp_set_reg() each.

Also, I've measured the output of the S/PDIF port with external S/PDIF
introspectors and the result is correct :)


Thanks,
Daniel
