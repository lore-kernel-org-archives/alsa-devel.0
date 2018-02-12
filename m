From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH v2 4/5] ALSA: emu10k1: make sure synth DMA
 pages are allocated with DMA functions
Date: Mon, 12 Feb 2018 23:14:50 +0100
Message-ID: <8df9709b-c7c5-17ac-3f15-a91e3b4903f2@maciej.szmigiero.name>
References: <619e9569-717a-1b4b-6470-4fa6b186bf41@maciej.szmigiero.name>
 <s5hh8qm5qed.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D78D26757F
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 23:14:51 +0100 (CET)
In-Reply-To: <s5hh8qm5qed.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 12.02.2018 13:44, Takashi Iwai wrote:
> On Sat, 27 Jan 2018 15:42:47 +0100,
>  Maciej S. Szmigiero  wrote:
>>
>> Commit a5003fc04113 ("[ALSA] emu10k1 - simplify page allocation for synth")
>> switched from using the DMA allocator for synth DMA pages to manually
>> calling alloc_page().
>> However, this usage has an implicit assumption that the DMA address space
>> for the emu10k1-family chip is the same as the CPU physical address space
>> which is not true for a system with a IOMMU.
>>
>> Since this made the synth part of the driver non-functional on such systems
>> let's effectively revert that commit.
> 
> Let's keep (or re-add after this revert) the simplification with
> __synth_free_pages().  Other than that I have no objection to this
> change.

Will keep the simplification via __synth_free_pages() function in a respin.

> thanks,
> 
> Takashi

Thanks,
Maciej
