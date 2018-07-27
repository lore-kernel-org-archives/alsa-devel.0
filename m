From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 1/6] ASoC: rt5651: Add IN3 Boost volume
 control
Date: Fri, 27 Jul 2018 14:01:44 +0200
Message-ID: <2ea3aaa5-cba7-901b-f0cf-782ce4ebd1c5@redhat.com>
References: <20180718205542.12364-1-hdegoede@redhat.com>
 <20180718205542.12364-2-hdegoede@redhat.com>
 <20180719150234.GE27938@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D7028430F3@RTITMBSV02.realtek.com.tw>
 <f38e30f0-182b-484e-8de1-a9fd0db4663c@linux.intel.com>
 <ABFD875FF5FB574BA706497D987D48D70284323D@RTITMBSV02.realtek.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
 [209.85.208.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 709F62677B0
 for <alsa-devel@alsa-project.org>; Fri, 27 Jul 2018 14:01:47 +0200 (CEST)
Received: by mail-ed1-f66.google.com with SMTP id x5-v6so3762458edr.0
 for <alsa-devel@alsa-project.org>; Fri, 27 Jul 2018 05:01:47 -0700 (PDT)
In-Reply-To: <ABFD875FF5FB574BA706497D987D48D70284323D@RTITMBSV02.realtek.com.tw>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Carlo Caione <carlo@endlessm.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On 07/20/2018 04:53 AM, Bard Liao wrote:
>> -----Original Message-----
>> From: Pierre-Louis Bossart [mailto:pierre-louis.bossart@linux.intel.com]
>> Sent: Friday, July 20, 2018 9:40 AM
>> To: Bard Liao; Mark Brown; Hans de Goede
>> Cc: Liam Girdwood; Oder Chiou; alsa-devel@alsa-project.org; Carlo Caione
>> Subject: Re: [alsa-devel] [PATCH 1/6] ASoC: rt5651: Add IN3 Boost volume
>> control
>>
>> On 07/19/2018 08:31 PM, Bard Liao wrote:
>>>> -----Original Message-----
>>>> From: Mark Brown [mailto:broonie@kernel.org]
>>>> Sent: Thursday, July 19, 2018 11:03 PM
>>>> To: Hans de Goede
>>>> Cc: Liam Girdwood; Bard Liao; Oder Chiou; Pierre-Louis Bossart; Carlo
>> Caione;
>>>> alsa-devel@alsa-project.org
>>>> Subject: Re: [PATCH 1/6] ASoC: rt5651: Add IN3 Boost volume control
>>>>
>>>> On Wed, Jul 18, 2018 at 10:55:37PM +0200, Hans de Goede wrote:
>>>>
>>>>> +	/* IN1/IN2/IN3 Control */
>>>>>    	SOC_SINGLE_TLV("IN1 Boost", RT5651_IN1_IN2,
>>>>>    		RT5651_BST_SFT1, 8, 0, bst_tlv),
>>>>>    	SOC_SINGLE_TLV("IN2 Boost", RT5651_IN1_IN2,
>>>>>    		RT5651_BST_SFT2, 8, 0, bst_tlv),
>>>>> +	SOC_SINGLE_TLV("IN3 Boost", RT5651_IN3,
>>>>> +		RT5651_BST_SFT1, 8, 0, bst_tlv),
>>>> These should all have Volume added to the name however that's a
>>>> preexisting bug so not a blocker on this.
>>> I will add "Volume" to the name for all of them.
>> isn't this going to break userspace configs if we change the name of
>> controls?
> 
> Yes, it should be modified, too.

Or we just live with the  "Volume" part missing for these 3 and don't
break users existing setup for no good reason.

Regards,

Hans
