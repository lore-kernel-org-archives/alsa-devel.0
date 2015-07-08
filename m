From: "Jin, Yao" <yao.jin@linux.intel.com>
Subject: Re: [PATCH v2 07/13] topology: Add private data parser
Date: Wed, 08 Jul 2015 21:31:27 +0800
Message-ID: <559D262F.20403@linux.intel.com>
References: <1435758275-4047-1-git-send-email-liam.r.girdwood@linux.intel.com>	
 <1435758275-4047-7-git-send-email-liam.r.girdwood@linux.intel.com>	
 <s5ha8vflui3.wl-tiwai@suse.de> <1436284442.7271.30.camel@loki>	
 <s5h7fqchrde.wl-tiwai@suse.de> <1436345852.2474.10.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 8ADEC2606B0
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2015 15:31:32 +0200 (CEST)
In-Reply-To: <1436345852.2474.10.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Takashi Iwai <tiwai@suse.de>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org



On 2015/7/8 16:57, Liam Girdwood wrote:
> On Tue, 2015-07-07 at 18:19 +0200, Takashi Iwai wrote:
>> On Tue, 07 Jul 2015 17:54:02 +0200,
>> Liam Girdwood wrote:
>>>
>>> On Wed, 2015-07-01 at 18:20 +0200, Takashi Iwai wrote:
>>>
>>>>
>>>>> +static int get_hex_num(const char *str)
>>>>> +{
>>>>> +	char *tmp, *s = NULL;
>>>>> +	int i = 0;
>>>>> +
>>>>> +	tmp = strdup(str);
>>>>> +	if (tmp == NULL)
>>>>> +		return -ENOMEM;
>>>>> +
>>>>> +	s = strtok(tmp, ",");
>>>>> +	while (s != NULL) {
>>>>> +		s = strtok(NULL, ",");
>>>>> +		i++;
>>>>> +	}
>>>>> +
>>>>> +	free(tmp);
>>>>> +	return i;
>>>>
>>>> Hmm, this just counts the number of comma + 1, so you don't need to
>>>> duplicate the string?
>>>>
>>>
>>> The string here is duplicated since strtok is destructive (it overwrites
>>> the delimiters with NULL) and the string is being used later on by the
>>> calling function.
>>
>> Yes, but what I meant is something like below:
>>
>> static int get_hex_num(const char *str)
>> {
>> 	int i = 0;
>>
>> 	if (!*str)
>> 		return 0;
>> 	for (;;) {
>> 		i++;
>> 		str = strchr(str, ',');
>> 		if (!str)
>> 			return i;
>> 		str++;
>> 	}
>> }
>>
>> ... so that it works without strdup().
>>
>> But it seems that strtok() skips the starting delimiter or handles
>> multiple delimiters as a single, so the result will become
>> inconsistent.  That is, all the following strings will give "a" and
>> "b" via strtok():
>> 	a,b
>> 	a,,b
>> 	,a,b
>> 	a,b,
>>
>> I guess you don't want to have an empty list element, right?
>>
> 
> Lets ask the author :) but IMO an empty list should be skipped here.
> 
> Yao, what's your rational behind this code ?

Sorry for replying late, I just see this mail.

The get_hex_num() returns the number of hexadecimal in string.

Say the string is "0x12,0x34,0x56,0x78" or "0x12,0x34,0x56,0x78,",
the get_hex_num() returns 4.

But if I use strchr, for above string, I get different number (3 or 4).
That's the reason I choose the strtok().

I do this is because I think user may append the comma at the end of
string.

> 
> Liam
> 
