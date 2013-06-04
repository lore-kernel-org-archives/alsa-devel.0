From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [RFC PATCH] ALSA: hda - Ignore default pin config
 on Haswell HDMI codecs
Date: Tue, 04 Jun 2013 12:19:57 +0200
Message-ID: <51ADBF4D.30407@canonical.com>
References: <1370332965-3489-1-git-send-email-david.henningsson@canonical.com>
 <F46914AEC2663F4A9BB62374E5EEF8F80123BA2C@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 65E552650D7
 for <alsa-devel@alsa-project.org>; Tue,  4 Jun 2013 12:19:59 +0200 (CEST)
In-Reply-To: <F46914AEC2663F4A9BB62374E5EEF8F80123BA2C@SHSMSX101.ccr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Lin, Mengdong" <mengdong.lin@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>, "tiwai@suse.de" <tiwai@suse.de>, "Wang,
 Xingchao" <xingchao.wang@intel.com>, "Li, Jocelyn" <jocelyn.li@intel.com>, "daniel@ffwll.ch" <daniel@ffwll.ch>, James M Leddy <james.leddy@canonical.com>
List-Id: alsa-devel@alsa-project.org

On 06/04/2013 12:10 PM, Lin, Mengdong wrote:
> Hi David,
>
> Do you mean that a pin's default configuration may tell "No physical connection" by mistake?

A pin's default configuration can be set to "No physical connection". 
I've seen this on one machine that we're trying to enable.

Whether that is a mistake or not, that's the million dollar question here:

If it is not a mistake, then the graphics driver/stack should pay 
attention to this value, and not route audio to that pin.

If it is a mistake, then the bspec [1] should mention that programming 
of this value should not be allowed (so we can tell the OEM to correct 
their BIOS).

I'm still trying to get a clear answer from someone at Intel, and it's 
becoming a bit frustrating not to get that.


>
> Thanks
> Mengdong
>
>> -----Original Message-----
>> From: David Henningsson [mailto:david.henningsson@canonical.com]
>> Sent: Tuesday, June 04, 2013 4:03 PM
>> To: alsa-devel@alsa-project.org
>> Cc: tiwai@suse.de; Wang, Xingchao; daniel@ffwll.ch; Lin, Mengdong; Girdwood,
>> Liam R; Li, Jocelyn; David Henningsson
>> Subject: [RFC PATCH] ALSA: hda - Ignore default pin config on Haswell HDMI
>> codecs
>>
>> According to Daniel Vetter, these pin configs should be ignored, because the
>> graphics driver/userspace could route audio to these pins even if they are
>> disabled by BIOS.
>>
>> Signed-off-by: David Henningsson <david.henningsson@canonical.com>
>> ---
>>   sound/pci/hda/patch_hdmi.c |   10 ++++++----
>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> It would be good to have this acked by someone at Intel before committing.
>>
>> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c index
>> e12f7a0..8c1bede 100644
>> --- a/sound/pci/hda/patch_hdmi.c
>> +++ b/sound/pci/hda/patch_hdmi.c
>> @@ -1307,12 +1307,14 @@ static int hdmi_add_pin(struct hda_codec *codec,
>> hda_nid_t pin_nid)
>>   	if (!(caps & (AC_PINCAP_HDMI | AC_PINCAP_DP)))
>>   		return 0;
>>
>> -	config = snd_hda_codec_get_pincfg(codec, pin_nid);
>> -	if (get_defcfg_connect(config) == AC_JACK_PORT_NONE)
>> -		return 0;
>> -
>>   	if (codec->vendor_id == 0x80862807)
>>   		intel_haswell_fixup_connect_list(codec, pin_nid);
>> +	else {
>> +		/* On Haswell, default pin config should be ignored */
>> +		config = snd_hda_codec_get_pincfg(codec, pin_nid);
>> +		if (get_defcfg_connect(config) == AC_JACK_PORT_NONE)
>> +			return 0;
>> +	}
>>
>>   	pin_idx = spec->num_pins;
>>   	per_pin = snd_array_new(&spec->pins);
>> --
>> 1.7.9.5
>



-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic

[1] Or some other document. I don't have access to the bspec, so I can't 
check this for myself.
