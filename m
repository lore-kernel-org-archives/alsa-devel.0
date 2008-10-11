From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: Re: [PATCH] hda: add mixers for analog mixer on
	92hd75xx codecs
Date: Sat, 11 Oct 2008 12:31:44 -0400
Message-ID: <48F0D4F0.3070205@embeddedalley.com>
References: <48EF538B.4020809@embeddedalley.com> <s5hiqrzp2b8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (unknown [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id 613DB1037FF
	for <alsa-devel@alsa-project.org>;
	Sat, 11 Oct 2008 18:32:13 +0200 (CEST)
In-Reply-To: <s5hiqrzp2b8.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Fri, 10 Oct 2008 09:07:23 -0400,
> Matthew Ranostay wrote:
>> Add support for mixers on the analog mixer on some 92hd75xx codecs,
>> along with adding a 'Mixer' entry for it's connection on the dmux.
>>
>> Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
> 
> Thanks, I applied it as is now, but...
> 
>> @@ -1095,8 +1090,17 @@ static struct snd_kcontrol_new stac92hd71bxx_analog_mixer[] = {
>>  	HDA_CODEC_MUTE("PC Beep Switch", 0x17, 0x2, HDA_INPUT),
>>  	*/
>>
>> -	HDA_CODEC_MUTE("Analog Loopback 1", 0x17, 0x3, HDA_INPUT),
>> -	HDA_CODEC_MUTE("Analog Loopback 2", 0x17, 0x4, HDA_INPUT),
>> +	HDA_CODEC_MUTE("Import0 Mux Capture Switch", 0x17, 0x3, HDA_INPUT),
>> +	HDA_CODEC_VOLUME("Import0 Mux Capture Volume", 0x17, 0x3, HDA_INPUT),
>> +
>> +	HDA_CODEC_MUTE("Import1 Mux Capture Switch", 0x17, 0x3, HDA_INPUT),
>> +	HDA_CODEC_VOLUME("Import1 Mux Capture Volume", 0x17, 0x3, HDA_INPUT),
>> +
>> +	HDA_CODEC_MUTE("DAC0 Capture Switch", 0x17, 0x3, HDA_INPUT),
>> +	HDA_CODEC_VOLUME("DAC0 Capture Volume", 0x17, 0x3, HDA_INPUT),
>> +
>> +	HDA_CODEC_MUTE("DAC1 Capture Switch", 0x17, 0x4, HDA_INPUT),
>> +	HDA_CODEC_VOLUME("DAC1 Capture Volume", 0x17, 0x4, HDA_INPUT),
> 
> This rename worries me.  One may wonder what the hell is "Import* Mux"
> at all.
>
Good question, I just noticed the typos in that code. I'll submit the changes shortly.
But the Import Mux's are 0x1a and 0x1b which have a path into the analog mixer.

Let me know if I can name the mixers somehow better.


>> @@ -4391,6 +4408,10 @@ again:
>>  	spec->multiout.num_dacs = 1;
>>  	spec->multiout.hp_nid = 0x11;
>>  	spec->multiout.dac_nids = stac92hd71bxx_dac_nids;
>> +	if (spec->dinput_mux)
>> +		spec->private_dimux.num_items +=
>> +			spec->num_dmics -
>> +				(ARRAY_SIZE(stac92hd71bxx_dmic_nids) - 1);
> 
> And, this looks a bit tricky.
> The relation between these variables is unclear in the patch...
> 
Ok I can explain this as well. If there isn't any dmics defined as in some laptops,
or if there is only one, this then removes the unneeded items from the mux. I realize
there has to be a better way to do this but seems like overkill since only one codec to
date has analog mixer.

Thanks,

Matt Ranostay

> 
> thanks,
> 
> Takashi
> 
