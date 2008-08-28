From: "Bryan Wu" <cooloney@kernel.org>
Subject: Re: [PATCH 2/4] ASOC codec: add support for SSM2602
	audio codec in ALSA SoC framework
Date: Thu, 28 Aug 2008 13:55:33 +0800
Message-ID: <386072610808272255o7ef18860u29e10727e6e11a11@mail.gmail.com>
References: <1219829968-6431-1-git-send-email-cooloney@kernel.org>
	<1219829968-6431-3-git-send-email-cooloney@kernel.org>
	<20080827105456.GA10834@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.155])
	by alsa0.perex.cz (Postfix) with ESMTP id 85302244C1
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Aug 2008 07:55:34 +0200 (CEST)
Received: by yx-out-1718.google.com with SMTP id 36so175948yxh.2
	for <alsa-devel@alsa-project.org>; Wed, 27 Aug 2008 22:55:33 -0700 (PDT)
In-Reply-To: <20080827105456.GA10834@sirena.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Bryan Wu <cooloney@kernel.org>, perex@perex.cz, lrg@kernel.org, Cliff Cai <cliff.cai@analog.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 27, 2008 at 6:54 PM, Mark Brown <broonie@sirena.org.uk> wrote:
> On Wed, Aug 27, 2008 at 05:39:26PM +0800, Bryan Wu wrote:
>
> This looks basically good, thanks - I've picked up a few things below
> but they are mostly either minor or reflect the fact that the patch
> looks like it's been developed against current release kernels but
> there's been some churn recently in the ASoC APIs which need updates.
>
>>  #define I2C_DRIVERID_CS5345  96      /* cs5345 audio processor       */
>> +#define I2C_DRIVERID_SSM2602 97      /* BF52xC built in audio codec */
>
> It should be possible to just remove this - it shouldn't be needed.
>

OK, I'll take care of this i2c stuff here.

>> --- a/sound/soc/codecs/Kconfig
>> +++ b/sound/soc/codecs/Kconfig
>
> Current kernels have a Kconfig option SND_SOC_ALL_CODECS which should
> have your codec added - this allows codec drivers to be built without
> boards for test purposes.
>
Is this option in alsa git tree or in the mainline? I fail to find it
in upstream mainline.
And do you mean I don't need to add SND_SOC_SSM2602 at all?

>> +#define SSM2602_DEBUG 0
>> +
>> +#ifdef SSM2602_DEBUG
>> +#define dbg(format, arg...) \
>> +     printk(KERN_DEBUG AUDIO_NAME ": " format "\n" , ## arg)
>> +#else
>> +#define dbg(format, arg...) do {} while (0)
>> +#endif
>> +#define err(format, arg...) \
>> +     printk(KERN_ERR AUDIO_NAME ": " format "\n" , ## arg)
>> +#define info(format, arg...) \
>> +     printk(KERN_INFO AUDIO_NAME ": " format "\n" , ## arg)
>> +#define warn(format, arg...) \
>> +     printk(KERN_WARNING AUDIO_NAME ": " format "\n" , ## arg)
>
> Please convert these to use the standard pr_ macros (or ideally the dev_
> ones where possible) for debug prints.
>

Right, I killed this local definition and replaced them to pr_xxxx.

>> +
>> +#define ssm2602_reset(c)     ssm2602_write(c, SSM2602_RESET, 0)
>> +/*Appending several "None"s just for OSS mixer use*/
>> +static const char *ssm2602_input_select[] = {"Line", "Mic", "None", "None", "None",
>> +             "None", "None", "None"};
>> +static const char *ssm2602_deemph[] = {"None", "32Khz", "44.1Khz", "48Khz"};
>
> Please keep the lines under 80 characters where reasonable.  A little
> more while space (blank lines and at the start and end of comments)
> would be nice too.
>

Yes, I will fix this issue by running checkpatch.pl. And for other API
conflicts and I2C interface upgrading stuffs,
I will leave them to Cliff.

Thanks
-Bryan
