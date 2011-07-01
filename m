From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: alsa-lib rate plugins - float samples - patches
Date: Fri, 01 Jul 2011 11:50:17 +0200
Message-ID: <4E0D9859.5050009@ivitera.com>
References: <4DFEF830.6040400@ivitera.com>
	<4E097E86.3020001@ivitera.com>	<s5hliwjwkmp.wl%tiwai@suse.de>
	<4E0D92E7.1020907@ivitera.com> <s5hei2a8hsj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (twistwrist.pilsfree.net [78.108.108.109])
	by alsa0.perex.cz (Postfix) with ESMTP id 2CA2B103800
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Jul 2011 11:50:20 +0200 (CEST)
In-Reply-To: <s5hei2a8hsj.wl%tiwai@suse.de>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Dne 1.7.2011 11:35, Takashi Iwai napsal(a):
> At Fri, 01 Jul 2011 11:27:03 +0200,
>>
>> Hi Takashi, thanks a lot for your reply. Would moving the new method to
>> the end of snd_pcm_rate_ops struct suffice?
> 
> This is needed together with the API version bump.
> Increase SND_PCM_RATE_PLUGIN_VERSION, change rate_open_func() to call
> all older versions, and don't use the new methods for older versions.

OK, I will fight it :)

> 
>> Or do I have to create a new
>> API number with corresponding checks? I am afraid the latter is the case :)
>>
>>>
>>> - From the performance POV, we may need to have the built-in
>>>   float conversion in rate plugin indeed.  Anyway, if rate plugin
>>>   supports float, it should add FLOAT as the supported format.
>>>   This needs changes in the parameter setup in rate plugin.
>>>   Then it should accept the float format as is without conversions.
>>
>> If I understand correctly, the rate plugin accepts only linear formats
>> now. What was the original reason to exclude float?
> 
> Because the existing rate-converter are only for linear formats :)

OK, I will try to provide automatic conversion to/from floats in the
rate converters in alsa-plugin git for the new API version to include
float support.

> 
>> The "convert" API
>> method is generic enough, perhaps I should add float support to all the
>> rate converters using the API "convert" method. Again there is the
>> question of new API version - the new one would offer convert_float and
>> allow float samples in the generic convert method.
>>
>> The specific convert_s16/float methods in pcm_rate.c can be modified to
>> accept float too.
> 
> I don't mind how it'll be implemented as long as the backward
> compatibility is kept somehow.

Backward compatibility - I assume you mean any combination of alsa-lib
and alsa-plugins :) OK, I will try.


> 
> HAVE_SOFT_FLOAT is a bit confusing name.  It means actually NO_FLOAT,
> or better to say, NO_FLOAT_CALCULATION.  Thus ifndef is correct
> below.

OK, how about if I rename the constant accordingly?

>>
>> Well, the libsamplerate is using float internally, I am afraid the
>> float-less case would require disabling this rate converter alltogether.
> 
> Currently yes, but who knows in future?  The library internal can
> change.

OK. I will make patches for alsa-lib first and then we will see.

Regards,


Pavel.
