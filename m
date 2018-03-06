From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v3 10/25] ASoC: qcom: q6asm: Add support to
 memory map and unmap
Date: Tue, 6 Mar 2018 09:26:38 +0000
Message-ID: <58bce0b7-f7bc-59d7-bf75-503d95e13671@linaro.org>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
 <20180213165837.1620-11-srinivas.kandagatla@linaro.org>
 <20180301212844.GU12864@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f43.google.com (mail-wm0-f43.google.com [74.125.82.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E2B326729C
 for <alsa-devel@alsa-project.org>; Tue,  6 Mar 2018 10:26:40 +0100 (CET)
Received: by mail-wm0-f43.google.com with SMTP id t3so21268664wmc.2
 for <alsa-devel@alsa-project.org>; Tue, 06 Mar 2018 01:26:40 -0800 (PST)
In-Reply-To: <20180301212844.GU12864@sirena.org.uk>
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

Thanks for the review,

On 01/03/18 21:28, Mark Brown wrote:
> On Tue, Feb 13, 2018 at 04:58:22PM +0000, srinivas.kandagatla@linaro.org wrote:
> 
>> +	num_regions = is_contiguous ? 1 : periods;
>> +	buf_sz = is_contiguous ? (period_sz * periods) : period_sz;
> 
> Please write normal if statements, it's much easier to read.
> 

Sure, will fix it in next version.
>> +	buf_sz = PAGE_ALIGN(buf_sz);
> 
> I don't understand what this is doing, buf_sz is a length not an address
> so why are we attempting to align it?

Yes, this is a requirement form the DSP side that the size is multiple 
of 4KB. I will fix this properly in next version.

thanks,
srini
> 
