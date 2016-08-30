From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] ALSA: seq: initialize whole fields of
 automatic variable with union type
Date: Tue, 30 Aug 2016 15:34:18 +0900
Message-ID: <8e834bc7-1f12-826f-57cc-c1fdcf2ab372@sakamocchi.jp>
References: <1472515914-7703-1-git-send-email-o-takashi@sakamocchi.jp>
 <s5hbn0a4z8n.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id CF26826697E
 for <alsa-devel@alsa-project.org>; Tue, 30 Aug 2016 08:34:20 +0200 (CEST)
In-Reply-To: <s5hbn0a4z8n.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

On Aug 30 2016 14:11, Takashi Iwai wrote:
> On Tue, 30 Aug 2016 02:11:54 +0200,
> Takashi Sakamoto wrote:
>>
>> Currently, automatic variable of 'union ioctl_arg' type is initialized
>> by designated initialization. Although, the actual effect is interpretation
>> of early element of int type and initialization of 'int pversion'.
>> Therefore the first field corresponding to int type is initialized to zero.
>> This is against my expectation to initialize whole fields.
>>
>> This commit uses memset() to initialize the variable, instead of designated
>> initialization.
>>
>> Fixes: 04a56dd8ed0d ('ALSA: seq: change ioctl command operation to get data in kernel space')
>> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
>> ---
>>  sound/core/seq/seq_clientmgr.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
>> index 286394b..fd50c38 100644
>> --- a/sound/core/seq/seq_clientmgr.c
>> +++ b/sound/core/seq/seq_clientmgr.c
>> @@ -2100,7 +2100,7 @@ static long snd_seq_ioctl(struct file *file, unsigned int cmd,
>>  		struct snd_seq_client_pool	client_pool;
>>  		struct snd_seq_remove_events	remove_events;
>>  		struct snd_seq_query_subs	query_subs;
>> -	} buf = {0};
>> +	} buf;
>>  	const struct ioctl_handler *handler;
>>  	unsigned long size;
>>  	int err;
>> @@ -2114,6 +2114,9 @@ static long snd_seq_ioctl(struct file *file, unsigned int cmd,
>>  	}
>>  	if (handler->cmd == 0)
>>  		return -ENOTTY;
>> +
>> +	memset(&buf, 0, sizeof(union ioctl_arg));
>
> The common practice is to pass sizeof(buf).

OK. I'll post revised version later.


Regards

Takashi Sakamoto
