From: Luis de Bethencourt <luisbg@kernel.org>
Subject: Re: [PATCH] ALSA: pcm: Fix trailing semicolon
Date: Tue, 16 Jan 2018 13:28:32 +0000
Message-ID: <9f26c3ec-75fe-2dce-05ee-a26fea0bcfd6@kernel.org>
References: <20180115181857.32105-1-luisbg@kernel.org>
 <s5hk1wjc4mk.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 5BC44266E7C
 for <alsa-devel@alsa-project.org>; Tue, 16 Jan 2018 14:28:36 +0100 (CET)
In-Reply-To: <s5hk1wjc4mk.wl-tiwai@suse.de>
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
Cc: Joe Perches <joe@perches.com>, alsa-devel@alsa-project.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 01/15/2018 07:18 PM, Takashi Iwai wrote:
> On Mon, 15 Jan 2018 19:18:57 +0100,
> Luis de Bethencourt wrote:
>>
>> From: Ubuntu <luisbg@kernel.org>
> 
> Is this from address intentional?  It'd be taken as is via git-am.
> 
> 
> thanks,
> 
> Takashi
> 
>> The trailing semicolon is an empty statement that does no operation.
>> Removing it since it doesn't do anything.
>>
>> Signed-off-by: Luis de Bethencourt <luisbg@kernel.org>
>> ---
>>
>>
>> Hi,
>>
>> After fixing the same thing in drivers/staging/rtl8723bs/, Joe Perches
>> suggested I fix it treewide [0].
>>
>> Best regards 
>> Luis
>>
>>
>> [0] http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2018-January/115410.html
>> [1] http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2018-January/115390.html
>>
>>  sound/core/pcm_native.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
>> index 3f13e8da0812..51104df924e1 100644
>> --- a/sound/core/pcm_native.c
>> +++ b/sound/core/pcm_native.c
>> @@ -3446,7 +3446,7 @@ EXPORT_SYMBOL_GPL(snd_pcm_lib_default_mmap);
>>  int snd_pcm_lib_mmap_iomem(struct snd_pcm_substream *substream,
>>  			   struct vm_area_struct *area)
>>  {
>> -	struct snd_pcm_runtime *runtime = substream->runtime;;
>> +	struct snd_pcm_runtime *runtime = substream->runtime;
>>  
>>  	area->vm_page_prot = pgprot_noncached(area->vm_page_prot);
>>  	return vm_iomap_memory(area, runtime->dma_addr, runtime->dma_bytes);
>> -- 
>> 2.15.1
>>
>>

Hi Takashi,

Sorry. Not sure how git send-email added that line to the commit message.
I have sent a v2 correcting it.

Thanks,
Luis
