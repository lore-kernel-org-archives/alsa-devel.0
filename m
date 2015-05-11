From: Shuah Khan <shuahkh@osg.samsung.com>
Subject: Re: [PATCH 2/2] sound/usb: Update ALSA driver to use media controller
 API
Date: Mon, 11 May 2015 10:09:24 -0600
Message-ID: <5550D434.6000906@osg.samsung.com>
References: <cover.1431110739.git.shuahkh@osg.samsung.com> <dd21d1282a85d620be1aae497b66ccb355e458ba.1431110739.git.shuahkh@osg.samsung.com> <20150509045109.GA6528@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <20150509045109.GA6528@dcvr.yhbt.net>
Sender: linux-media-owner@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
Cc: mchehab@osg.samsung.com, hans.verkuil@cisco.com, laurent.pinchart@ideasonboard.com, tiwai@suse.de, perex@perex.cz, agoode@google.com, pierre-louis.bossart@linux.intel.com, gtmkramer@xs4all.nl, clemens@ladisch.de, vladcatoi@gmail.com, damien@zamaudio.com, chris.j.arges@canonical.com, takamichiho@gmail.com, misterpib@gmail.com, daniel@zonque.org, pmatilai@laiskiainen.org, jussi@sonarnerd.net, fisch602@gmail.com, joe@oampo.co.uk, linux-media@vger.kernel.org, alsa-devel@alsa-project.org, Shuah Khan <shuahkh@osg.samsung.com>
List-Id: alsa-devel@alsa-project.org

On 05/08/2015 10:51 PM, Eric Wong wrote:
> Shuah Khan <shuahkh@osg.samsung.com> wrote:
>> @@ -541,13 +591,19 @@ int snd_usb_create_quirk(struct snd_usb_audio *chip,
>>  		[QUIRK_AUDIO_ALIGN_TRANSFER] = create_align_transfer_quirk,
>>  		[QUIRK_AUDIO_STANDARD_MIXER] = create_standard_mixer_quirk,
>>  	};
>> +	int ret;
>>  
>> +	if (quirk->media_device) {
>> +		/* don't want to fail when media_device_init() doesn't work */
>> +		ret = media_device_init(iface);
>> +	}
>>  	if (quirk->type < QUIRK_TYPE_COUNT) {
>> -		return quirk_funcs[quirk->type](chip, iface, driver, quirk);
>> +		ret = quirk_funcs[quirk->type](chip, iface, driver, quirk);
>>  	} else {
>>  		usb_audio_err(chip, "invalid quirk type %d\n", quirk->type);
>>  		return -ENXIO;
>>  	}
>> +	return ret;
>>  }
> 
> What is the point of saving 'ret' of media_device_init if it'll
> only be clobbered or ignored for ENXIO?
> 

Agreed. There is no point in saving it.

thanks,
-- Shuah

-- 
Shuah Khan
Sr. Linux Kernel Developer
Open Source Innovation Group
Samsung Research America (Silicon Valley)
shuahkh@osg.samsung.com | (970) 217-8978
