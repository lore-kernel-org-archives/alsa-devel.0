From: Julian Scheel <julian@jusst.de>
Subject: Re: [PATCH] ALSA: usb-audio: Fix parameter block size
 for UAC2 control requests
Date: Fri, 14 Aug 2015 16:14:35 +0200
Message-ID: <55CDF7CB.6030300@jusst.de>
References: <1439463886-5369-1-git-send-email-julian@jusst.de>
 <s5hpp2qt3ei.wl-tiwai@suse.de> <55CDF116.8070400@jusst.de>
 <s5hk2syt1vf.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sender163-mail.zoho.com (sender163-mail.zoho.com
 [74.201.84.163])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E7482654B3
 for <alsa-devel@alsa-project.org>; Fri, 14 Aug 2015 16:14:40 +0200 (CEST)
In-Reply-To: <s5hk2syt1vf.wl-tiwai@suse.de>
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

Am 14.08.2015 um 15:51 schrieb Takashi Iwai:
> On Fri, 14 Aug 2015 15:45:58 +0200,
> Julian Scheel wrote:
>>
>> Am 14.08.2015 um 15:17 schrieb Takashi Iwai:
>>> On Thu, 13 Aug 2015 13:04:46 +0200,
>>> Julian Scheel wrote:
>>>>
>>>> @@ -469,6 +503,8 @@ int snd_usb_mixer_set_ctl_value(struct usb_mixer_elem_info *cval,
>>>>    	value_set = convert_bytes_value(cval, value_set);
>>>>    	buf[0] = value_set & 0xff;
>>>>    	buf[1] = (value_set >> 8) & 0xff;
>>>> +	buf[2] = (value_set >> 16) & 0xff;
>>>> +	buf[3] = (value_set >> 24) & 0xff;
>>>
>>> It's not smart but OK, just a subtle matter...
>>
>> Hm, what would you like better?
>
> A shorter code would be to to pass __le32 value pointer directly after
> calling cpu_to_le32(), for example.  But it's a matter of taste, so
> it's OK to keep your code as is.

Thanks, I'll leave it as is for now and keep the le32 approach in mind 
for the future.
