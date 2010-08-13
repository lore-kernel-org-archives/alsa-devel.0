From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 5/5] ASoC: Fix indentiation in S3C DMA
	driver
Date: Fri, 13 Aug 2010 09:44:07 +0100
Message-ID: <81B7387B-AC6F-4184-BB55-D40A76357857@opensource.wolfsonmicro.com>
References: <1281607342-13127-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1281607342-13127-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<AANLkTik=zq9ZL1bN=YcMivTNS8Lu88M9GnaQfC=39DQX@mail.gmail.com>
	(sfid-20100813_063844_270237_8FA37B71)
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 03C0F103809
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Aug 2010 10:44:10 +0200 (CEST)
In-Reply-To: <AANLkTik=zq9ZL1bN=YcMivTNS8Lu88M9GnaQfC=39DQX@mail.gmail.com>
	(sfid-20100813_063844_270237_8FA37B71)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, Seungwhan Youn <sw.youn@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 13 Aug 2010, at 06:38, Jassi Brar wrote:
> On Thu, Aug 12, 2010 at 7:02 PM, Mark Brown

>>  static struct platform_driver s3c24xx_pcm_driver = {
>>        .driver = {
>> -                       .name = "s3c24xx-pcm-audio",
>> -                       .owner = THIS_MODULE,
>> +               .name = "s3c24xx-pcm-audio",
>> +               .owner = THIS_MODULE,
>>        },
>> 
>>        .probe = s3c24xx_soc_platform_probe,
> Ok but I think we need to involve Ben too, for I have the impression
> that he is not very interested in such valid but inconsequential
> changes.
> If he agrees, maybe we can prepare a patchset for complete polish
> and overhauling the drivers.

I'm afraid I can't follow what you're saying here at all. The above change is an indentation only change in the ASoC code. I can't see why Ben would need to be involved, it doesn't touch arch/arm at all.
