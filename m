From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2] dbri: Fix compiler warning
Date: Thu, 24 Nov 2016 11:20:57 -0500 (EST)
Message-ID: <20161124.112057.785317837336457718.davem@davemloft.net>
References: <1479957315-2517-1-git-send-email-tushar.n.dave@oracle.com>
 <s5hfumh9gpt.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 by alsa0.perex.cz (Postfix) with ESMTP id D9A672665C1
 for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2016 17:21:07 +0100 (CET)
In-Reply-To: <s5hfumh9gpt.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: sparclinux@vger.kernel.org, alsa-devel@alsa-project.org, thomas.tai@oracle.com, tushar.n.dave@oracle.com
List-Id: alsa-devel@alsa-project.org

From: Takashi Iwai <tiwai@suse.de>
Date: Thu, 24 Nov 2016 13:59:10 +0100

> On Thu, 24 Nov 2016 04:15:15 +0100,
> Tushar Dave wrote:
>> 
>> @@ -2539,7 +2545,7 @@ static int snd_dbri_create(struct snd_card *card,
>>  	if (!dbri->dma)
>>  		return -ENOMEM;
>>  
>> -	dprintk(D_GEN, "DMA Cmd Block 0x%p (0x%08x)\n",
>> +	dprintk(D_GEN, "DMA Cmd Block 0x%p (0x%08llx)\n",
>>  		dbri->dma, dbri->dma_dvma);
> 
> Better to use %pad for dma_addr_t here.
> If the config doesn't enable ATU, dma_addr_t would be still u32, and
> your change will be buggy.

dma_addr_t is unconditionally a 64-bit type on sparc64.

However, you are right in that on sparc32 it is still 32-bit.
