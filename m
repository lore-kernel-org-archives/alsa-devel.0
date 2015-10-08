From: Jiada Wang <jiada_wang@mentor.com>
Subject: Re: [PATCH 2/2] ASoC: Codec: wm8962: declare ALC
 Coefficients as 4 separate registers
Date: Thu, 8 Oct 2015 12:11:30 +0900
Message-ID: <5615DEE2.6000906@mentor.com>
References: <1444115215-4388-1-git-send-email-jiada_wang@mentor.com>
 <1444115215-4388-3-git-send-email-jiada_wang@mentor.com>
 <20151006110114.GN12635@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A00B2665BF
 for <alsa-devel@alsa-project.org>; Thu,  8 Oct 2015 05:11:35 +0200 (CEST)
In-Reply-To: <20151006110114.GN12635@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, tiwai@suse.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Hi


On 10/06/2015 08:01 PM, Mark Brown wrote:
> On Tue, Oct 06, 2015 at 04:06:55PM +0900, Jiada Wang wrote:
>
>> As ALC2 register is volatile, declare it as one of ALC Coefficients
>> register together with other non-volatile registers will cause issue,
>> in case wm8962 has enter suspend mode, and cache_only flag is set,
>> any attempt to read from ALC2 will fail.
>
>> Instead of declaring one ALC Coefficients register which contains
>> ALC1 ~ ALC3 and Noise Gate, this patch declares 4 separate registers,
>> so that regmap can handle these registers differently based on their
>> classification.
>
> I don't understand this commit log.  Why does regmap care how these
> registers are presented to userspace, and how does splitting the
> controls up address the problem with one of the registers being volatile?
> Surely that register still has the same problem?
>
.get callback function will call regmap_raw_read() to read register
value from these registers, when these 4 regsters are declared as one
"ALC coefficient" register, condition check of regmap_volatile_range()
will return false, thus regmap will go word by word for the cache from
each register of "ALC Coefficient", the failure scenario is, when
wm8962 is in suspend mode (cache_only flag is set), as ALC2 doesn't
have cached value, then any attempt to read from it fails,

By splitting these registers, regmap can handle ALC2 as a single
volatile register, and always read from HW

Thanks,
Jiada
