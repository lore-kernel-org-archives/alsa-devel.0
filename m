From: Quentin Lambert <lambert.quentin@gmail.com>
Subject: Re: [PATCH v2] ALSA: aoa: convert bus code to use dev_groups
Date: Thu, 11 Jun 2015 14:06:25 +0200
Message-ID: <557979C1.2060608@gmail.com>
References: <1434009818-16711-1-git-send-email-lambert.quentin@gmail.com> <5579774F.4010706@bfs.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <5579774F.4010706@bfs.de>
Sender: kernel-janitors-owner@vger.kernel.org
To: wharms@bfs.de
Cc: Johannes Berg <johannes@sipsolutions.net>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 11/06/2015 13:55, walter harms wrote:
>
> Am 11.06.2015 10:03, schrieb Quentin Lambert:
>> The dev_attrs field of struct bus_type is going away, use dev_groups instead.
>> This converts the soundbus code to use the correct field.
>>
>> Given that all other usages of the macro define the struct attribute
>> *xxx_attrs[] in the same file they assign the .dev_groups field, this patch
>> merges sysfs.c into core.c.
>>
>> These modifications were made using Coccinelle.
>>
>> Signed-off-by: Quentin Lambert <lambert.quentin@gmail.com>
>> ---
>>   Changes since v1:
>>    - Fix the commit message to actually talk about soundbus rather than MDIO
>>    - This version attempt to fix a problem resulting from the macro
>>      ATTRIBUTE_GROUPS declaring the structure as static by merging sysfs.c into
>>      core.c. I understand that this may not be the prefered solution since
>>      Takashi suggested that adding a comment line to the previous version could
>>      be acceptable.
>>
>>   sound/aoa/soundbus/Makefile   |    2 -
>>   sound/aoa/soundbus/core.c     |   44 +++++++++++++++++++++++++++++++++++++++++-
>>   sound/aoa/soundbus/soundbus.h |    2 -
>>   sound/aoa/soundbus/sysfs.c    |   42 ----------------------------------------
>>   4 files changed, 44 insertions(+), 46 deletions(-)
>>
>> --- a/sound/aoa/soundbus/Makefile
>> +++ b/sound/aoa/soundbus/Makefile
>> @@ -1,3 +1,3 @@
>>   obj-$(CONFIG_SND_AOA_SOUNDBUS) += snd-aoa-soundbus.o
>> -snd-aoa-soundbus-objs := core.o sysfs.o
>> +snd-aoa-soundbus-objs := core.o
>>   obj-$(CONFIG_SND_AOA_SOUNDBUS_I2S) += i2sbus/
>> --- a/sound/aoa/soundbus/core.c
>> +++ b/sound/aoa/soundbus/core.c
>> @@ -150,6 +150,48 @@ static int soundbus_device_resume(struct
>>   
>>   #endif /* CONFIG_PM */
>>   
>> +#define soundbus_config_of_attr(field, format_string)			\
>> +static ssize_t								\
>> +field##_show (struct device *dev, struct device_attribute *attr,	\
>> +              char *buf)						\
>> +{									\
>> +	struct soundbus_dev *mdev = to_soundbus_device (dev);		\
>> +	return sprintf (buf, format_string, mdev->ofdev.dev.of_node->field); \
>> +}
>> +
>> +static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
>> +			     char *buf)
>> +{
>> +	struct soundbus_dev *sdev = to_soundbus_device(dev);
>> +	struct platform_device *of = &sdev->ofdev;
>> +	int length;
>> +
>> +	if (*sdev->modalias) {
>> +		strlcpy(buf, sdev->modalias, sizeof(sdev->modalias) + 1);
>> +		strcat(buf, "\n");
>> +		length = strlen(buf);
>
> for my curiosity:
> why not sprintf() ? almost any other code seems to use sprintf().
I wouldn't be able to justify that as this is part is simply a copy 
paste from sysfs.c to core.c

Quentin
