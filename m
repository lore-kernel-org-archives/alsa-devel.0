From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH] ASoC: max98090: Simplify
	max98090_readable_register implementation
Date: Mon, 27 Jul 2015 13:08:31 +0300
Message-ID: <55B6031F.6080305@linux.intel.com>
References: <1437961183.10891.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 67B5826078A
 for <alsa-devel@alsa-project.org>; Mon, 27 Jul 2015 12:08:35 +0200 (CEST)
In-Reply-To: <1437961183.10891.1.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc: "Fang, Yang A" <yang.a.fang@intel.com>, alsa-devel@alsa-project.org, Jerry Wong <jerry.wong@maximintegrated.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 07/27/2015 04:39 AM, Axel Lin wrote:
> The readable registers are in consecutive ranges:
> 	0x01 ~ 0x03, 0x0D ~ 0xD1, 0xFF
> So simplify the implementation by specifying a range of consecutive values
> in a single case label.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>   sound/soc/codecs/max98090.c | 71 ++-------------------------------------------
>   1 file changed, 2 insertions(+), 69 deletions(-)
>
Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

One minor comment below.

> -	case M98090_REG_DMIC34_BIQUAD_BASE ... M98090_REG_DMIC34_BIQUAD_BASE + 0x0E:
> +	case M98090_REG_DEVICE_STATUS ... M98090_REG_INTERRUPT_S:
> +	case M98090_REG_LINE_INPUT_CONFIG ... 0xD1:
>   	case M98090_REG_REVISION_ID:
>   		return true;

I'd have preserved that magic M98090_REG_DMIC34_BIQUAD_BASE + 0x0E here. 
Last register before 0xff is 0xbd in the specification, 
M98090_REG_DMIC34_BIQUAD_BASE is 0xc3 in the max98090.h so it seems to 
me that 0xc3 ~ 0xd1 are undocumented registers.

-- 
Jarkko
