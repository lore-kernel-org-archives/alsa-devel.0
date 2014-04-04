From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 28/44] fireworks: Add command/response
 functionality into hwdep interface
Date: Fri, 04 Apr 2014 20:11:12 +0900
Message-ID: <533E9350.6090201@sakamocchi.jp>
References: <1395400229-22957-1-git-send-email-o-takashi@sakamocchi.jp>
 <1395400229-22957-29-git-send-email-o-takashi@sakamocchi.jp>
 <533E7C01.8040000@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id C9EEF2657C6
 for <alsa-devel@alsa-project.org>; Fri,  4 Apr 2014 13:11:51 +0200 (CEST)
In-Reply-To: <533E7C01.8040000@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi Clemens,

(Apr 04 2014 18:31), Clemens Ladisch wrote:
> Takashi Sakamoto wrote:
>> +++ b/include/uapi/sound/firewire.h
>>   #define SNDRV_FIREWIRE_EVENT_LOCK_STATUS	0x000010cc
>>   #define SNDRV_FIREWIRE_EVENT_DICE_NOTIFICATION	0xd1ce004e
>> +#define SNDRV_FIREWIRE_EVENT_EFW_RESPONSE	0x4e617475
>
> Why "Natu"?  ;-)

Hehe, it's my association from "Fireworks" in Japanese.
I believe cultures in Continental Europe have the similar association ;)

For practical reason, I have no other ideas to fit in the 4 bytes.

>> +/* each field should be in big endian */
>> +struct snd_efw_transaction {
>> +	uint32_t length;
>> +	uint32_t version;
>> +	uint32_t seqnum;
>> +	uint32_t category;
>> +	uint32_t command;
>> +	uint32_t status;
>> +	uint32_t params[0];
>> +};
>
> uint32_t is not guaranteed to be available in a userspace header.
> Add <linux/types.h>, and use __u32.

Can I request the reason?

Here I force users to include <stdint.h> and use types defined in ISO 
C99. I think this way is standard. (but not standard between 
kernel/user-land?)

>> +++ b/sound/firewire/fireworks/fireworks.c
>>   static int index[SNDRV_CARDS]	= SNDRV_DEFAULT_IDX;
>>   static char *id[SNDRV_CARDS]	= SNDRV_DEFAULT_STR;
>>   static bool enable[SNDRV_CARDS]	= SNDRV_DEFAULT_ENABLE_PNP;
>> +unsigned int resp_buf_size	= 1024;
>> +bool resp_buf_debug		= false;
>
> When the driver is compiled into the kernel, these variable names could
> introduce conflicts.  Use a prefix like "efw_" or "fireworks_"; the
> parameter names can then be made pretty by using module_param_named().

I never pay attension to compiling as built-in.

OK. I try to use the macro, maybe with "snd_efw" so as easily realizing 
it's in Sound subsystem.

>> +static long
>> +hwdep_write(struct snd_hwdep *hwdep, const char __user *data, long count,
>> +	    loff_t *offset)
>> +{
>> +	...
>> +	if (count < sizeof(struct snd_efw_transaction))
>> +		return -EINVAL;
>
> The size must not be larger than allowed for a single write transaction.
> This would eventually be caught by the firewire core, but checking it
> here would avoid allocating lots of memory.

I investigate the length of all commands and realize the maximum bytes 
is 304 (0x130) for isochronous channel mapping (see 
FFADO:src/fireworks/efc/efc_cmds_ioconfig.h). With leaving some space 
for this value, I think 0x140 is better for this purpose.


Thank you

Takashi Sakamoto
o-takashi@sakamocchi.jp
