From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: Re: [PATCH] hda: Add STAC_DELL_M4_3 quirk
Date: Thu, 20 Nov 2008 21:02:04 -0500
Message-ID: <4926169C.1080709@embeddedalley.com>
References: <4924D013.2020107@embeddedalley.com>	<s5h8wreooic.wl%tiwai@suse.de>	<49260F64.5040303@embeddedalley.com>
	<s5hk5ax2745.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id 87741243BF
	for <alsa-devel@alsa-project.org>; Fri, 21 Nov 2008 03:02:12 +0100 (CET)
In-Reply-To: <s5hk5ax2745.wl%tiwai@suse.de>
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
> At Thu, 20 Nov 2008 20:31:16 -0500,
> Matthew Ranostay wrote:
>> Takashi Iwai wrote:
>>> At Wed, 19 Nov 2008 21:48:51 -0500,
>>> Matthew Ranostay wrote:
>>>> Add PCI quirk STAC_DELL_M4_3 for 92hd71bxx based laptops.
>>> Which laptops, more exactly?  Recently I received bug reports about
>>> Dell Studio laptops, and wondering whether it's for such models.
>>>
>>>
>>>> @@ -4650,14 +4661,20 @@ again:
>>>>
>>>>  	switch (spec->board_config) {
>>>>  	case STAC_HP_M4:
>>>> -		spec->num_dmics = 0;
>>>> -		spec->num_smuxes = 0;
>>>> -		spec->num_dmuxes = 0;
>>>> -
>>>>  		/* enable internal microphone */
>>>>  		stac92xx_set_config_reg(codec, 0x0e, 0x01813040);
>>>>  		stac92xx_auto_set_pinctl(codec, 0x0e,
>>>>  			AC_PINCTL_IN_EN | AC_PINCTL_VREF_80);
>>> Please add a comment about fall-through here.
>>>
>>> Also, update Documentation/*/ALSA-Configuration.txt as well.
>>>
>>>
>>> thanks,
>>>
>>> Takashi
>>>
>> Add PCI quirk STAC_DELL_M4_3 for 92hd71bxx based laptops and desktops.
>>
>> Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
> 
> Thanks.  Now another questions about the patch.
> 
>> @@ -4650,14 +4661,21 @@ again:
>>
>>  	switch (spec->board_config) {
>>  	case STAC_HP_M4:
>> -		spec->num_dmics = 0;
>> -		spec->num_smuxes = 0;
>> -		spec->num_dmuxes = 0;
>> -
> 
> Any reason to remove these....
> 
Because it falls through below.

>>  		/* enable internal microphone */
>>  		stac92xx_set_config_reg(codec, 0x0e, 0x01813040);
>>  		stac92xx_auto_set_pinctl(codec, 0x0e,
>>  			AC_PINCTL_IN_EN | AC_PINCTL_VREF_80);
>> +		/* fallthru */
>> +	case STAC_DELL_M4_2:
>> +		spec->num_dmics = 0;
>> +		spec->num_smuxes = 0;
>> +		spec->num_dmuxes = 0;
>> +		break;
>> +	case STAC_DELL_M4_1:
>> +	case STAC_DELL_M4_3:
>> +		spec->num_dmics = 1;
>> +		spec->num_smuxes = 0;
>> +		spec->num_dmuxes = 0;
> 
> ... and adding these?
> 
> That is, the patch introduces more changes than its description.
> If you change or fix the behavior of other models, please split, or
> at least give a proper changelog.
> 
> 
I'll give a more descriptive changelog.

> thanks,
> 
> Takashi
> 
