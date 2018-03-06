From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v3 11/25] ASoC: qcom: q6asm: add support to
 audio stream apis
Date: Tue, 6 Mar 2018 09:26:34 +0000
Message-ID: <d76a271d-707c-3f5c-9327-d7f43da3cc92@linaro.org>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
 <20180213165837.1620-12-srinivas.kandagatla@linaro.org>
 <20180301213356.GV12864@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
 by alsa0.perex.cz (Postfix) with ESMTP id F40752671A3
 for <alsa-devel@alsa-project.org>; Tue,  6 Mar 2018 10:26:36 +0100 (CET)
Received: by mail-wm0-f67.google.com with SMTP id x7so20768286wmc.0
 for <alsa-devel@alsa-project.org>; Tue, 06 Mar 2018 01:26:36 -0800 (PST)
In-Reply-To: <20180301213356.GV12864@sirena.org.uk>
Content-Language: en-US
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, rohkumar@qti.qualcomm.com, linux-arm-msm@vger.kernel.org, plai@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com, david.brown@linaro.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, spatakok@qti.qualcomm.com, andy.gross@linaro.org, linux-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Thanks for the review comments.

sorry for delay, for some reason these emails endup in my SPAM folder.

On 01/03/18 21:33, Mark Brown wrote:
> On Tue, Feb 13, 2018 at 04:58:23PM +0000, srinivas.kandagatla@linaro.org wrote:
> 
>>   	uint32_t used;
>> @@ -131,7 +191,7 @@ static int q6asm_apr_send_session_pkt(struct q6asm *a, struct audio_client *ac,
>>   
>>   	rc = wait_event_timeout(a->mem_wait, (a->mem_state <= 0), 5 * HZ);
>>   	if (!rc) {
>> -		dev_err(a->dev, "CMD timeout \n");
>> +		dev_err(a->dev, "CMD timeout\n");
>>   		rc = -ETIMEDOUT;
>>   	} else if (a->mem_state < 0) {
>>   		rc =  q6dsp_errno(a->mem_state);
> 
> This should be folded into whatever patch is being fixed.
> 

My Bad, I will fix this in next version.

>> +	open.hdr.opcode = ASM_STREAM_CMD_OPEN_WRITE_V3;
>> +	open.mode_flags = 0x00;
>> +	open.mode_flags |= ASM_LEGACY_STREAM_SESSION;
> 
> What is a legacy stream and why are we using it in new code?

This is basically Ensures backward compatibility to the original 
behavior of ASM_STREAM_CMD_OPEN_WRITE_V2 command.

I will take a closer look and see if its possible to remove this in the 
first place.

thanks,
srini

> 
