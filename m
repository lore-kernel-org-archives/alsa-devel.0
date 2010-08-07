From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [Uclinux-dist-devel] [PATCH 5/6] ASoC: new
	ADAU1761 codec driver
Date: Sat, 7 Aug 2010 23:36:48 +0100
Message-ID: <DE733C15-5D63-4470-8124-238563F4629B@opensource.wolfsonmicro.com>
References: <1281212905-12957-1-git-send-email-vapier@gentoo.org>
	<1281212905-12957-5-git-send-email-vapier@gentoo.org>
	<B3F28327-BBE5-489F-B077-C865B0F21332@opensource.wolfsonmicro.com>
	<AANLkTinZd8KPqF+6r-sdZKkoSWF4tFVhxNV4B0xzwVqJ@mail.gmail.com>
	(sfid-20100807_233001_599816_0748AEC1)
Mime-Version: 1.0 (iPad Mail 7B405)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 50947103806
	for <alsa-devel@alsa-project.org>;
	Sun,  8 Aug 2010 00:36:28 +0200 (CEST)
In-Reply-To: <AANLkTinZd8KPqF+6r-sdZKkoSWF4tFVhxNV4B0xzwVqJ@mail.gmail.com>
	(sfid-20100807_233001_599816_0748AEC1)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: "uclinux-dist-devel@blackfin.uclinux.org" <uclinux-dist-devel@blackfin.uclinux.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

On 7 Aug 2010, at 23:29, Mike Frysinger <vapier.adi@gmail.com> wrote:

>>> +static ssize_t adau1371_dsp_load(struct device *dev,
>>> +                               struct device_attribute *attr,
>>> +                               const char *buf, size_t count)
>>> +{
>>> +     struct snd_soc_device *socdev = dev_get_drvdata(dev);
>>> +     struct snd_soc_codec *codec = socdev->card->codec;
>>> +     int ret = 0;
>>> +
>>> +     ret = adau1761_setprogram(codec);
>>> +     if (ret)
>>> +             return ret;
>>> +     else
>>> +             return count;
>>> +}
>>> +static DEVICE_ATTR(dsp, 0644, NULL, adau1371_dsp_load);

>> This looks redundant - it doesn't offer any opportunity to configure the firmware to download and you're already (as one one would expect) automatically downloading the firmware. If this is being exposed at all it should be via debugfs.

> SigmaDSP parts have the ability to change firmwares on the fly.  this
> isnt a debug feature, it's somewhat core to these parts.  idea being
> that you can load up different mini signal processing engines based on
> the current needs.

Right, but see my point about there being no opportunity to configure the firmware - if you were allowing the user to select between multiple firmwares available then I expect that the value written into the sysfs file would be parsed as the name of the new firmware file to load or otherwise select a new firmware. With the current code the value written is totally ignored and the application layer has to overwrite the firmware in the filesystem (or have a custom helper program which does the equivalent thereof) so as far as the kernel is concerned it's going to reload the same firmware which isn't ideal.
