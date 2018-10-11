From: Colin Ian King <colin.king@canonical.com>
Subject: Re: [PATCH] ALSA: cs4236: fix return check from call to
 pnp_port_start
Date: Thu, 11 Oct 2018 16:47:31 +0100
Message-ID: <6149a234-b9bd-e4cd-ce72-02696dfa083e@canonical.com>
References: <20181010141542.16100-1-colin.king@canonical.com>
 <s5hd0sgfq13.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hd0sgfq13.wl-tiwai@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 11/10/18 16:42, Takashi Iwai wrote:
> On Wed, 10 Oct 2018 16:15:42 +0200,
> Colin King wrote:
>>
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> Currently the return from pnp_port_start is being checked for validity
>> by checking if it is greater or equal to zero, however, the return
>> is unsigned and hence this check is always true.  An 0 return from
>> pnp_port_start is actually an error, so fix the check by checking
>> for validity when it is non-zero.
> 
> I guess you're confused between mpu_port[] and mpu_irq[]?
> The check "mpu_irq[] >= 0" here is to see the module parameter value
> from user.

Yep, you are quite correct. I overlooked this. My bad.
> 
> 
> thanks,
> 
> Takashi
> 
>> Detected by CoverityScan, CID#1468334 ("Unsigned compared to 0")
>>
>> Fixes: a9824c868a2c ("[ALSA] Add CS4232 PnP BIOS support")
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>> ---
>>  sound/isa/cs423x/cs4236.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/sound/isa/cs423x/cs4236.c b/sound/isa/cs423x/cs4236.c
>> index 70559e59d18f..2211c39d2c18 100644
>> --- a/sound/isa/cs423x/cs4236.c
>> +++ b/sound/isa/cs423x/cs4236.c
>> @@ -292,7 +292,7 @@ static int snd_cs423x_pnp_init_mpu(int dev, struct pnp_dev *pdev)
>>  		mpu_irq[dev] = SNDRV_AUTO_IRQ;
>>  	} else {
>>  		mpu_port[dev] = pnp_port_start(pdev, 0);
>> -		if (mpu_irq[dev] >= 0 &&
>> +		if (!mpu_irq[dev] &&
>>  		    pnp_irq_valid(pdev, 0) && pnp_irq(pdev, 0) >= 0) {
>>  			mpu_irq[dev] = pnp_irq(pdev, 0);
>>  		} else {
>> -- 
>> 2.17.1
>>
>>
