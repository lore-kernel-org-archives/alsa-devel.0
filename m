From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 1/2] ALSA: usb: fix corrupted pointers due
 to interface setting change
Date: Fri, 14 Aug 2015 11:05:50 -0500
Message-ID: <55CE11DE.1000201@linux.intel.com>
References: <1439505753-3532-1-git-send-email-pierre-louis.bossart@linux.intel.com>	<1439505753-3532-2-git-send-email-pierre-louis.bossart@linux.intel.com>
 <s5hlhddsw10.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id DCB592654C4
 for <alsa-devel@alsa-project.org>; Fri, 14 Aug 2015 18:05:53 +0200 (CEST)
In-Reply-To: <s5hlhddsw10.wl-tiwai@suse.de>
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

On 8/14/15 10:57 AM, Takashi Iwai wrote:
> On Fri, 14 Aug 2015 00:42:32 +0200,
> Pierre-Louis Bossart wrote:
>>
>> --- a/sound/usb/pcm.c
>> +++ b/sound/usb/pcm.c
>> @@ -395,6 +395,19 @@ static int set_sync_endpoint(struct snd_usb_substream *subs,
>>   	if (err < 0)
>>   		return err;
>>
>> +	if ((is_playback && (attr != USB_ENDPOINT_SYNC_ASYNC)) ||
>> +		(!is_playback && (attr != USB_ENDPOINT_SYNC_ADAPTIVE))) {
>> +
>> +		/*
>> +		 * Clean-up subs pointers to make sure sync_endpoint is never
>> +		 * configured. This is needed in case of a transition between
>> +		 * alternate settings using different synchronization modes
>> +		 * where the previous sync_endpoint may no longer be valid.
>> +		 */
>> +		subs->sync_endpoint = NULL;
>> +		subs->data_endpoint->sync_master = NULL;
>> +	}
>
> I think this initialization can be put unconditionally on top, not in
> a separate like below, as this is just overlooked leaks.
> The comment can be better in more details, of course.

I wasn't sure about side effects. I don't know what exactly the 
set_sync_ep_implicit_fb_quick() does and I was worried about changing 
the behavior on devices I didn't test. But if this is fine then I can 
change it, no issue.
Yes the comment isn't clear. I should be something like
"in these modes there is no sync_endpoint and the pointers need to be 
reset to avoid using stale information from previous settings"

Agree on the other changes, will provide an update. Thanks for the quick 
review!

>
>
> Takashi
>
> diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
> index b4ef410e5a98..0d935369d641 100644
> --- a/sound/usb/pcm.c
> +++ b/sound/usb/pcm.c
> @@ -391,6 +391,10 @@ static int set_sync_endpoint(struct snd_usb_substream *subs,
>   	 */
>   	attr = fmt->ep_attr & USB_ENDPOINT_SYNCTYPE;
>
> +	/* Clean-up subs sync and master pointers at first */
> +	subs->sync_endpoint = NULL;
> +	subs->data_endpoint->sync_master = NULL;
> +
>   	err = set_sync_ep_implicit_fb_quirk(subs, dev, altsd, attr);
>   	if (err < 0)
>   		return err;
>
