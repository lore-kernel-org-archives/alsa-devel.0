From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 2/4] ASoC: s3c64xx/smartq: use dynamic
	registration
Date: Mon, 14 Jul 2014 18:18:12 +0200
Message-ID: <53C402C4.5090908@metafoo.de>
References: <1405086308-1461192-1-git-send-email-arnd@arndb.de>
 <4755712.cJmZ5fnaQH@wuerfel> <53C3CFCA.9050800@metafoo.de>
 <4494372.fAWcxQ0qku@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-084.synserver.de (smtp-out-084.synserver.de
 [212.40.185.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 2EF69261A96
 for <alsa-devel@alsa-project.org>; Mon, 14 Jul 2014 18:18:13 +0200 (CEST)
In-Reply-To: <4494372.fAWcxQ0qku@wuerfel>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: alsa-devel@alsa-project.org, Kukjin Kim <kgene.kim@samsung.com>, t.figa@samsung.com, Maurus Cuelenaere <mcuelenaere@gmail.com>, lgirdwood@gmail.com, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 07/14/2014 05:46 PM, Arnd Bergmann wrote:
[...]
>>> +static struct gpiod_lookup_table smartq_audio_gpios = {
>>> +	.dev_id = "smartq-audio",
>>> +	.table = {
>>> +		GPIO_LOOKUP("GPL", 12, "headphone detect", 0),
>>> +		GPIO_LOOKUP("GPK", 12, "amplifiers shutdown", GPIO_ACTIVE_HIGH),
>>
>> There is no such thing as GPIO_ACTIVE_HIGH, just 0 for flags.
>
> The original driver does gpio_direction_output(..., 1);
>
> For some reason I earlier concluded that this was what the '1' would need
> to get converted to. Are you sure '0' is correct then?
>

Yes. But now that you say it the gpiod_direction_output() call is missing 
from this patch.

- Lars
