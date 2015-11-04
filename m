From: Libin Yang <libin.yang@linux.intel.com>
Subject: Re: [RFC PATCH 1/2] ALSA: hda - add hda_dev_t typedef
 for DP MST audio
Date: Wed, 4 Nov 2015 10:37:52 +0800
Message-ID: <56396F80.6000004@linux.intel.com>
References: <1446538973-109373-1-git-send-email-libin.yang@linux.intel.com>
 <1446538973-109373-2-git-send-email-libin.yang@linux.intel.com>
 <s5hvb9jnj39.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 02800265086
 for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2015 03:39:14 +0100 (CET)
In-Reply-To: <s5hvb9jnj39.wl-tiwai@suse.de>
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
Cc: Libin Yang <libin.yang@intel.com>, alsa-devel@alsa-project.org, mengdong.lin@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On 11/04/2015 12:28 AM, Takashi Iwai wrote:
> On Tue, 03 Nov 2015 09:22:52 +0100,
> libin.yang@linux.intel.com wrote:
>>
>> From: Libin Yang <libin.yang@intel.com>
>>
>> Signed-off-by: Libin Yang <libin.yang@intel.com>
>> ---
>>   include/sound/hdaudio.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
>> index e2b712c..1f54964 100644
>> --- a/include/sound/hdaudio.h
>> +++ b/include/sound/hdaudio.h
>> @@ -15,6 +15,7 @@
>>
>>   /* codec node id */
>>   typedef u16 hda_nid_t;
>> +typedef u8 hda_dev_t;
>
> This isn't used in any ABI, so we don't have to define the type.
> Just use int instead.
>
> NID was defined there because it's used in ABI and it can represent
> the purpose more clearly.  (Also at the early time of driver writing,
> the size itself wasn't 100% clear; we started writing it before
> HD-audio spec got solid.)

OK. I will use int type directly.

Best Regards,
Libin

>
>
> thanks,
>
> Takashi
>
