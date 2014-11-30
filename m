From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 21/30] ALSA: oxfw: Change the way to name
	card
Date: Sun, 30 Nov 2014 13:33:31 +0900
Message-ID: <547A9E1B.7060004@sakamocchi.jp>
References: <1417190379-4172-1-git-send-email-o-takashi@sakamocchi.jp>
 <1417190379-4172-22-git-send-email-o-takashi@sakamocchi.jp>
 <s5hbnnpbxxs.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 8134526046F
 for <alsa-devel@alsa-project.org>; Sun, 30 Nov 2014 05:33:34 +0100 (CET)
In-Reply-To: <s5hbnnpbxxs.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: clemens@ladisch.de, alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Nov 30 2014 04:37, Takashi Iwai wrote:
>> diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
>> index 951d9a4..3308253 100644
>> --- a/sound/firewire/oxfw/oxfw.c
>> +++ b/sound/firewire/oxfw/oxfw.c
>> @@ -25,14 +25,34 @@ MODULE_AUTHOR("Clemens Ladisch <clemens@ladisch.de>");
>>  MODULE_LICENSE("GPL v2");
>>  MODULE_ALIAS("snd-firewire-speakers");
>>  
>> -static u32 oxfw_read_firmware_version(struct fw_unit *unit)
>> +static int name_card(struct snd_oxfw *oxfw)
>>  {
>> -	__be32 data;
>> +	struct fw_device *fw_dev = fw_parent_device(oxfw->unit);
>> +	const char *d, *v, *m;
>> +	u32 firmware;
>>  	int err;
>>  
>> -	err = snd_fw_transaction(unit, TCODE_READ_QUADLET_REQUEST,
>> -				 OXFORD_FIRMWARE_ID_ADDRESS, &data, 4, 0);
>> -	return err >= 0 ? be32_to_cpu(data) : 0;
>> +	err = snd_fw_transaction(oxfw->unit, TCODE_READ_QUADLET_REQUEST,
>> +				 OXFORD_FIRMWARE_ID_ADDRESS, &firmware, 4, 0);
>> +	if (err < 0)
>> +		goto end;
>> +	be32_to_cpus(&firmware);
>> +
>> +	d = oxfw->device_info->driver_name;
>> +	v = oxfw->device_info->vendor_name;
>> +	m = oxfw->device_info->driver_name;
>> +
>> +	strcpy(oxfw->card->driver, d);
>> +	strcpy(oxfw->card->shortname, m);
>> +	strcpy(oxfw->card->mixername, m);
> 
> So, this ends up with the identical strings for both driver and
> shortname?  This doesn't sound like an improvement.

Basically, hard-coded strings can be replaced by strings read from
config-rom on the devices. My original intension of this commit is
following to this.

But FWSpeakers/FireWave has long strings for vendor/model strings on
config-rom, therefore his commit can obsolete long name only.

Actually this patch is a help for later patch:
[PATCH 26/30] ALSA: oxfw: Add support for Behringer/Mackie devices
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-November/084818.html


Regards

Takashi Sakamoto
o-takashi@sakamocchi.jp
