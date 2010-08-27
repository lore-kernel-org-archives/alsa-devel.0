From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v5] ASoC/2.6.37: fix au1x platform
Date: Fri, 27 Aug 2010 14:07:38 +0100
Message-ID: <1365302F-4C5D-4075-8D38-94DEEEF2583E@opensource.wolfsonmicro.com>
References: <1282827231-17323-1-git-send-email-manuel.lauss@googlemail.com>
	<1282913484.3025.25.camel@odin>
	(sfid-20100827_135129_330231_1544C48C)
Mime-Version: 1.0 (iPad Mail 7B500)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C94BF245DE
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Aug 2010 15:07:44 +0200 (CEST)
In-Reply-To: <1282913484.3025.25.camel@odin>
	(sfid-20100827_135129_330231_1544C48C)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Manuel Lauss <manuel.lauss@googlemail.com>, Ian Lartey <ian@opensource.wolfsonmicro.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "alsa-devel@vger.kernel.org" <alsa-devel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 27 Aug 2010, at 13:51, Liam Girdwood <lrg@slimlogic.co.uk> wrote:

> On Thu, 2010-08-26 at 14:53 +0200, Manuel Lauss wrote:
>> This patch fixes up the au1x audio platform after the multi-component
>> merge:
>> - compile fixes and updates to get DB1200 platform audio working again,
>> - removal of global variables in AC97/I2S/DMA(PCM) modules.
>> 
>> The AC97 part is limited to one instance only for now due to issues
>> with getting at driver data in the soc_ac97_ops.
>> 
>> Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
>> ---
>> v5: smaller patch
>> v4: fixed a bug in the previous bugfix, and added DAI drvdata accessors.
>> v3: fixed a bug which caused cat /proc/iomem to loop endlessly.
>> v2: prepare PCM,I2S for multiple card operation, use dev_name() for DAI name.
>> 
>> Against Liam's asoc/for-2.6.37 branch.
>> 
>> Tested on DB1200 and DB1300 (here both I2S and AC97 operate as
>> independent cards),  please fold this into the other Au1x multi-component
>> patches.
>> 
> 
> This all looks fine
> 
>> Issues I observed with AC97:
>> * AC97 is limited to a single instance since I cannot get at the driver
>>  data in the AC97 callbacks at all time (or did I miss anything?):
>>  when the AC97 codec calls snd_ac97_mixer(), it calls into the soc_ac97_ops
>>  callbacks; however ac97->bus->card->private_data (suggested by Mark)
>>  is _always_ NULL, so no way to get at the dai and ultimately driver data.
>> 
>> * generic AC97 codec use spits out this kobject warning, which is caused by the
>>  "device_register()" in soc-core.c::soc_ac97_dev_register():
>> 
> 
> Although I'm curious about these issues. I didn't see them when testing
> on my now non working Zylonite with WM9713 (AC97), so I'm suspecting
> it's related to the generic AC97 somehow.

Yeah, the generic AC97 code doesn't really know what's going on with ASoC so we're probably upsetting it again. Most likely we need to redo the stuff to suppress the card registration for AC97 cards.

> Unfortunately, this will need someone with working AC97 hardware to fix
> this issue. 
> 
> Is the AC97 DAI being probed before the generic AC97 codec driver in
> this case ?
> 
> Liam
> 
> 
> 
