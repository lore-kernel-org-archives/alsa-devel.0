From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] ALSA: drivers: make array 'names' const,
 reduces object code size
Date: Tue, 28 Nov 2017 19:39:24 +0900
Message-ID: <7ac4b078-5c9a-5285-1bc1-8c02adfd56c0@sakamocchi.jp>
References: <20171127125851.10076-1-colin.king@canonical.com>
 <11bbcc13-2ff9-68ed-6331-f65c2247b4db@sakamocchi.jp>
 <s5h7eubmrev.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 89160266B80
 for <alsa-devel@alsa-project.org>; Tue, 28 Nov 2017 11:39:26 +0100 (CET)
In-Reply-To: <s5h7eubmrev.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: Colin King <colin.king@canonical.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, wharms@bfs.de
List-Id: alsa-devel@alsa-project.org

On Nov 28 2017 04:51, Takashi Iwai wrote:
> On Mon, 27 Nov 2017 18:34:17 +0100,
> Takashi Sakamoto wrote:
>>
>> Hi,
>>
>> On Nov 27 2017 21:58, Colin King wrote:
>>> From: Colin Ian King <colin.king@canonical.com>
>>>
>>> Don't populate array 'names' on the stack but instead make them static.
>>> Makes the object code smaller by 50 bytes:
>>>
>>> Before:
>>>      text	   data	    bss	    dec	    hex	filename
>>>     21237	   9192	   1120	  31549	   7b3d	linux/sound/drivers/dummy.o
>>>
>>> After:
>>>      text	   data	    bss	    dec	    hex	filename
>>>     21095	   9280	   1120	  31495	   7b07	linux/sound/drivers/dummy.o
>>>
>>> (gcc version 7.2.0 x86_64)
>>>
>>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>>> ---
>>>    sound/drivers/dummy.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/sound/drivers/dummy.c b/sound/drivers/dummy.c
>>> index 7b2b1f766b00..69db45bc0197 100644
>>> --- a/sound/drivers/dummy.c
>>> +++ b/sound/drivers/dummy.c
>>> @@ -830,7 +830,7 @@ static int snd_dummy_capsrc_put(struct snd_kcontrol *kcontrol, struct snd_ctl_el
>>>    static int snd_dummy_iobox_info(struct snd_kcontrol *kcontrol,
>>>    				struct snd_ctl_elem_info *info)
>>>    {
>>> -	const char *const names[] = { "None", "CD Player" };
>>> +	static const char *const names[] = { "None", "CD Player" };
>>>      	return snd_ctl_enum_info(info, 1, 2, names);
>>>    }
>>
>> Total size of snd-dummy.ko increases but this patch has an advantage
>> to have the symbol in read-only section.
> 
> The total size decreases :)

Ah, yes. The state of my local build tree is not good to calculate it... 
In fact, the relocatable object decreases its size when built with a 
header package from Ubuntu repository.


Thanks

Takashi Sakamoto
