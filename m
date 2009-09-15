From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: [PATCH 5/6] adding support for multiple external
 clock types
Date: Tue, 15 Sep 2009 15:09:08 +0200
Message-ID: <4AAF91F4.2050501@ivitera.com>
References: <1252968303-29334-1-git-send-email-pavel.hofman@ivitera.com>	<1252968303-29334-2-git-send-email-pavel.hofman@ivitera.com>	<1252968303-29334-3-git-send-email-pavel.hofman@ivitera.com>	<1252968303-29334-4-git-send-email-pavel.hofman@ivitera.com>	<1252968303-29334-5-git-send-email-pavel.hofman@ivitera.com>
	<s5hmy4wbgc6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.insite.cz (upc-plzen.insite.cz [84.242.100.8])
	by alsa0.perex.cz (Postfix) with ESMTP id 45095103867
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Sep 2009 15:08:48 +0200 (CEST)
In-Reply-To: <s5hmy4wbgc6.wl%tiwai@suse.de>
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
> At Tue, 15 Sep 2009 00:45:02 +0200,
> pavel.hofman@ivitera.com wrote:
>> From: Pavel Hofman <pavel.hofman@ivitera.com>
>>
>>
>> Signed-off-by: Pavel Hofman <pavel.hofman@ivitera.com>
>>
>> diff --git a/pci/ice1712/ice1712.h b/pci/ice1712/ice1712.h
>> --- a/pci/ice1712/ice1724.c
>> +++ b/pci/ice1712/ice1724.c
>> @@ -120,7 +122,7 @@ static inline int stdclock_is_spdif_master(struct snd_ice1712 *ice)
>>  
>>  static inline int is_pro_rate_locked(struct snd_ice1712 *ice)
>>  {
>> -	return ice->is_spdif_master(ice) || PRO_RATE_LOCKED;
>> +	return (!ice->is_spdif_master(ice)) && PRO_RATE_LOCKED;
> 
> What is the reason of this change of logic?

The original code comes from times when the sole use of
is_pro_rate_locked in snd_vt1724_set_pro_rate was simple:

if (!force && is_pro_rate_locked(ice))
	return 0;

I.e. if the RATE_LOCK control is activated, no change in rate was allowed.

Later in
http://git.alsa-project.org/?p=alsa-kmirror.git;a=commitdiff;h=f1abd41e000348151d02d9ece830a0039fac3bbe
the code was changed to

if (!force && is_pro_rate_locked(ice)) {
		return (rate == ice->cur_rate) ? 0 : -EBUSY;

The extra check rate == ice->cur_rate does not make sense for
external-clock modes and sometimes I experienced EBUSY when testing the
external-clock functionality.


> 
>> @@ -210,6 +212,16 @@ static void snd_vt1724_set_gpio_mask(struct snd_ice1712 *ice, unsigned int data)
>>  		outb((data >> 16) & 0xff, ICEREG1724(ice, GPIO_WRITE_MASK_22));
>>  	inw(ICEREG1724(ice, GPIO_WRITE_MASK)); /* dummy read for pci-posting */
>>  }
>> +static unsigned int snd_vt1724_get_gpio_mask(struct snd_ice1712 *ice)
>> +{
>> +	unsigned int mask;
>> +	if (!ice->vt1720)
>> +		mask = (unsigned int)inb(ICEREG1724(ice, GPIO_WRITE_MASK_22));
>> +	else
>> +		mask = 0;
>> +	mask = (mask << 16) | inw(ICEREG1724(ice, GPIO_WRITE_MASK));
>> +	return mask;
>> +}
> 
> Put this into the previous patch.

Sorry, I will move it.

> 
>> @@ -661,12 +673,16 @@ static int snd_vt1724_set_pro_rate(struct snd_ice1712 *ice, unsigned int rate,
>>  		return (rate == ice->cur_rate) ? 0 : -EBUSY;
>>  	}
>>  
>> -	old_rate = ice->get_rate(ice);
>> -	if (force || (old_rate != rate))
>> -		ice->set_rate(ice, rate);
>> -	else if (rate == ice->cur_rate) {
>> -		spin_unlock_irqrestore(&ice->reg_lock, flags);
>> -		return 0;
>> +	if (force || !ice->is_spdif_master(ice)) {
>> +		/* force means the rate was switched by ucontrol, otherwise
>> +		 * setting clock rate for internal clock mode */
>> +		old_rate = ice->get_rate(ice);
>> +		if (force || (old_rate != rate))
>> +			ice->set_rate(ice, rate);
>> +		else if (rate == ice->cur_rate) {
>> +			spin_unlock_irqrestore(&ice->reg_lock, flags);
>> +			return 0;
>> +		}
> 
> This should be related with the change above...
> 
> 
> thanks,
> 
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
