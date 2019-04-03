From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: alc295_fixup_chromebook function
Date: Wed, 3 Apr 2019 11:18:22 +0200
Message-ID: <875e2521-e24a-7cb3-ae16-2d13eaa7b350@perex.cz>
References: <6FAB7C47BCF00940BB0999A99BE3547A18DBAE8F@RTITMBSVM07.realtek.com.tw>
 <s5hv9zykwga.wl-tiwai@suse.de>
 <6FAB7C47BCF00940BB0999A99BE3547A18DBB118@RTITMBSVM07.realtek.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 402F5F80714
 for <alsa-devel@alsa-project.org>; Wed,  3 Apr 2019 11:18:25 +0200 (CEST)
In-Reply-To: <6FAB7C47BCF00940BB0999A99BE3547A18DBB118@RTITMBSVM07.realtek.com.tw>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kailang <kailang@realtek.com>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dne 03. 04. 19 v 10:28 Kailang napsal(a):
> Hi Takashi,
> 
> This patch also changed model name as 'alc-chrome-book'.
> It also tested by Intel Chrome audio team.

Note that I suggested this split here:

https://mailman.alsa-project.org/pipermail/alsa-devel/2019-March/146227.html

Then it took several iterations (Takashi, me, Kailang) and we finally moved to my suggestion.

I believe that this process should be much more simpler ;-)

					Jaroslav

> 
> BR,
> Kailang
> 
> -----Original Message-----
> From: Takashi Iwai <tiwai@suse.de> 
> Sent: Monday, April 1, 2019 3:37 PM
> To: Kailang <kailang@realtek.com>
> Cc: (alsa-devel@alsa-project.org) <alsa-devel@alsa-project.org>
> Subject: Re: alc295_fixup_chromebook function
> 
> On Mon, 01 Apr 2019 09:29:35 +0200,
> Kailang wrote:
>>
>> Hi Takashi,
>>
>> You applied below patch.
>> https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/commit
>> /?h=for-next&id=c8a9afa632f0fd45731d3353525faf1fdb362c89
>>
>> But I think ALC225_FIXUP_HEADSET_JACK will applicate for enable for headset button.
>> It was not only use for Chrome OS.
>> So, ALC225_FIXUP_HEADSET_JACK and alc295_fixup_chromebook separation were be better.
>>
>> Intel test https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/commit/?h=for-next&id=10f5b1b85ed10a80d45bc2db450e65bd792efaad this patch.
>> Mic JD was also not stable. (I don't know why. It passed with Ubuntu 
>> OS.) It need to change to initial state would be better. (original was 
>> HDA_FIXUP_ACT_PRE_PROBE)
>>
>> +static void alc295_fixup_chromebook(struct hda_codec *codec,
>> +				    const struct hda_fixup *fix, int action) {
>> +
>> +	switch (action) {
>> +	case HDA_FIXUP_ACT_INIT:
>> +		switch (codec->core.vendor_id) {
>> +		case 0x10ec0295:
>> +			alc_update_coef_idx(codec, 0x4a, 0x8000, 1 << 15); /* Reset HP JD */
>> +			alc_update_coef_idx(codec, 0x4a, 0x8000, 0 << 15);
>> +			break;
>> +		case 0x10ec0236:
>> +			alc_update_coef_idx(codec, 0x1b, 0x8000, 1 << 15); /* Reset HP JD */
>> +			alc_update_coef_idx(codec, 0x1b, 0x8000, 0 << 15);
>> +			break;
>> +		}
>> +		break;
>> +	}
>> +}
>>
>> How could I create a fix patch for this?
> 
> The Chromebook quirk name was chosen so that the quirk implementation won't be used by any random user as a generic solution.  If it can be used for real solutions, feel free to rename / split the quirk for easy adaption.  I have no big preference, but would like to judge from the actual patches.
> 
> 
> thanks,
> 
> Takashi
> 
> ------Please consider the environment before printing this e-mail.
> 
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
