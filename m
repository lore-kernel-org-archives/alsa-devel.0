From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: [PATCH 1/1] Changing the Multi Track Peak control
 from MIXER to PCM type
Date: Tue, 06 Oct 2009 15:38:14 +0200
Message-ID: <4ACB4846.6080208@ivitera.com>
References: <1254833466-11485-1-git-send-email-pavel.hofman@ivitera.com>
	<s5hmy443cin.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.insite.cz (upc-plzen.insite.cz [84.242.100.8])
	by alsa0.perex.cz (Postfix) with ESMTP id D45EB24367
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Oct 2009 15:37:48 +0200 (CEST)
In-Reply-To: <s5hmy443cin.wl%tiwai@suse.de>
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
> At Tue,  6 Oct 2009 14:51:06 +0200,
> pavel.hofman@ivitera.com wrote:
>> From: Pavel Hofman <pavel.hofman@ivitera.com>
>>
>> * The "Multi Track Peak" control is now of PCM type, to avoid
>>   confusing users in other alsa mixers.
> 
> We still need to handle the older kernels, so it has to retry with
> IFACE_MIXER as fallback.
> 
> Could you fix and repost?

Sure, just would you please tell me which snd_ctl_elem method to use to
check for existence of the control? I have no experience with alsa-lib

Thanks a lot.

Pavel.

> 
> 
> Takashi
> 
>> Signed-off-by: Pavel Hofman <pavel.hofman@ivitera.com>
>>
>> diff --git a/envy24control/levelmeters.c b/envy24control/levelmeters.c
>> index 3bf1a94..9bdaace 100644
>> --- a/envy24control/levelmeters.c
>> +++ b/envy24control/levelmeters.c
>> @@ -262,7 +262,7 @@ void level_meters_reset_peaks(GtkButton *button, gpointer data)
>>  void level_meters_init(void)
>>  {
>>  	snd_ctl_elem_value_malloc(&peaks);
>> -	snd_ctl_elem_value_set_interface(peaks, SND_CTL_ELEM_IFACE_MIXER);
>> +	snd_ctl_elem_value_set_interface(peaks, SND_CTL_ELEM_IFACE_PCM);
>>  	snd_ctl_elem_value_set_name(peaks, "Multi Track Peak");
>>  }
>>  
>> -- 
>> 1.5.4.3
>>
