From: Alan Young <consult.awy@gmail.com>
Subject: Re: [PATCH] [updated] pcm: rate: Add capability to
 pass configuration node to plugins
Date: Tue, 14 Feb 2017 07:30:22 +0000
Message-ID: <a15b8e68-a9b5-2ed2-29b2-a0ab5b997d7e@gmail.com>
References: <bdb7665c-5747-8888-fa2e-552e852fa375@IEE.org>
 <6d7c74b7-da90-5ae9-c355-c6884b2edf09@gmail.com>
 <s5hy3xg8zkp.wl-tiwai@suse.de>
 <e1ebb06d-6f43-fde8-7b9e-653d247a4a19@gmail.com>
 <s5h4lzxxn9c.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f65.google.com (mail-wm0-f65.google.com [74.125.82.65])
 by alsa0.perex.cz (Postfix) with ESMTP id AB86E26583C
 for <alsa-devel@alsa-project.org>; Tue, 14 Feb 2017 08:30:24 +0100 (CET)
Received: by mail-wm0-f65.google.com with SMTP id v77so2118385wmv.0
 for <alsa-devel@alsa-project.org>; Mon, 13 Feb 2017 23:30:24 -0800 (PST)
In-Reply-To: <s5h4lzxxn9c.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 14/02/17 07:08, Takashi Iwai wrote:
> On Mon, 13 Feb 2017 18:20:01 +0100,
> Alan Young wrote:
>> Here is a revised patch.
>>
>> It is useful for the converter used by a rate plugin to be capable of
>> receiving configuration. This patch enables the "converter" node of
>> the configuration of a "type rate" plugin to be specified as a
>> compound and passed to open func of the converter plugin.
>>
>> The SND_PCM_RATE_PLUGIN_CONF_ENTRY macro is used to define a rate
>> converter plugin entry point that takes the additional snd_config_t
>> *conf parameter. If a rate converter plugin also supports the existing
>> SND_PCM_RATE_PLUGIN_ENTRY entry point, or if passed conf parameter is
>> NULL then it is up to the plugin to determine whether or not this is a
>> fatal condition.
>>
>> Alan.
> The changes look almost good, but one uncertain change:
>
>>   	else if (snd_config_get_type(converter) == SND_CONFIG_TYPE_COMPOUND) {
>>   		snd_config_iterator_t i, next;
>>   		snd_config_for_each(i, next, converter) {
>>   			snd_config_t *n = snd_config_iterator_entry(i);
>> +			const char *id;
>>   			if (snd_config_get_string(n, &type) < 0)
>>   				break;
>> -			err = rate_open_func(rate, type, 0);
>> +			err = rate_open_func(rate, type, converter, 0);
>>   			if (!err)
>>   				break;
>> +			if (snd_config_get_id(n, &id) >= 0 && id && strcmp(id, "0") != 0)
>> +				break; /* not a simple array of types */
> What does this check exactly...?
>

In the case that snd_config_get_type(converter) == 
SND_CONFIG_TYPE_COMPOUND, this could be for one of two reasons:

 1. Where the configuration contains something like converter {name xxx,
    other stuff ...}, or
 2. where configuration contains something like [first second third].

In the later case, the id fields will be digit strings, with the first 
entry having the id "0". The test simply stops going around the loop 
looking for further alternatives if the first did not have id "0".

However, looking at that again now, I see that the test is flawed 
because it has no marker to check that it is only applied on the first 
iteration, so the loop would always stop after testing the second 
alternative. I could fix that or remove the test altogether - what do 
you think?

Alan.
