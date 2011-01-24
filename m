From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] davinci: da8xx/omap-l1xx: match codec_name
	with i2c ids
Date: Mon, 24 Jan 2011 15:00:57 -0800
Message-ID: <8739oh6h5i.fsf@ti.com>
References: <1295619896-5498-1-git-send-email-sudhakar.raj@ti.com>
	<1295620708.3348.233.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <stable-bounces@linux.kernel.org>
In-Reply-To: <1295620708.3348.233.camel@odin> (Liam Girdwood's message of
	"Fri, 21 Jan 2011 14:38:28 +0000")
List-Unsubscribe: <http://linux.kernel.org/mailman/options/stable>,
	<mailto:stable-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/mailman/private/stable/>
List-Post: <mailto:stable@linux.kernel.org>
List-Help: <mailto:stable-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/stable>,
	<mailto:stable-request@linux.kernel.org?subject=subscribe>
Sender: stable-bounces@linux.kernel.org
Errors-To: stable-bounces@linux.kernel.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: davinci-linux-open-source@linux.davincidsp.com, "Rajashekhara,
	Sudhakar" <sudhakar.raj@ti.com>, alsa-devel@alsa-project.org, dansharon@nanometrics.ca, stable@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Liam Girdwood <lrg@slimlogic.co.uk> writes:

> On Fri, 2011-01-21 at 19:54 +0530, Rajashekhara, Sudhakar wrote:
>> The codec_name entry for da8xx evm in sound/soc/davinci/davinci-evm.c
>> is not matching with the i2c ids in the board file. Without this fix the
>> soundcard does not get detected on da850/omap-l138/am18x evm.
>> 
>> Signed-off-by: Rajashekhara, Sudhakar <sudhakar.raj@ti.com>
>> Tested-by: Dan Sharon <dansharon@nanometrics.ca>
>> ---
>> This patch applies to Linus's kernel tree.
>> 
>>  sound/soc/davinci/davinci-evm.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>> 
>> diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
>> index 0c2d6ba..b36f0b3 100644
>> --- a/sound/soc/davinci/davinci-evm.c
>> +++ b/sound/soc/davinci/davinci-evm.c
>> @@ -223,7 +223,7 @@ static struct snd_soc_dai_link da8xx_evm_dai = {
>>  	.stream_name = "AIC3X",
>>  	.cpu_dai_name= "davinci-mcasp.0",
>>  	.codec_dai_name = "tlv320aic3x-hifi",
>> -	.codec_name = "tlv320aic3x-codec.0-001a",
>> +	.codec_name = "tlv320aic3x-codec.1-0018",
>>  	.platform_name = "davinci-pcm-audio",
>>  	.init = evm_aic3x_init,
>>  	.ops = &evm_ops,
>
> Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

Liam,

I'm assuming you'll merge this one via the ASoC tree?

Kevin
