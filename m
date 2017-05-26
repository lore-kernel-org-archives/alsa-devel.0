From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 2/2] ALSA: pcm: add arrangement for
	applying appl_ptr
Date: Fri, 26 May 2017 15:42:41 +0900
Message-ID: <d4f82e6e-d402-cc5f-92ef-f37e67fc0682@sakamocchi.jp>
References: <20170526003047.17721-1-o-takashi@sakamocchi.jp>
 <20170526003047.17721-3-o-takashi@sakamocchi.jp>
 <s5ha860jf2o.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id C21F8266B6D
 for <alsa-devel@alsa-project.org>; Fri, 26 May 2017 08:42:45 +0200 (CEST)
In-Reply-To: <s5ha860jf2o.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On May 26 2017 15:40, Takashi Iwai wrote:
> On Fri, 26 May 2017 02:30:47 +0200,
> Takashi Sakamoto wrote:
>>
>> In callgraphs from below kernel APIs, position of application pointer on
>> PCM buffer is changes, according to given parameters.
>>
>>   - snd_pcm_lib_read()
>>   - snd_pcm_lib_readv()
>>   - snd_pcm_lib_write()
>>   - snd_pcm_lib_writev()
>>
>> This operation corresponds to application of new position to runtime of
>> PCM substream and callback of driver's implementation for
>> 'struct snd_pcm_ops.ack'.
>>
>> In a former commit, a new local function is added, 'apply_appl_ptr'. The
>> above code block can be replaced with this function.
>>
>> This commit replaces the code block with call of the function. The function
>> is renamed to be shared by several objects.
>>
>> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> 
> Queued now, but will be likely declined later due to the rewrites of
> the code.

Due to your recent work under reviewing?


Regards

Takashi Sakamoto
