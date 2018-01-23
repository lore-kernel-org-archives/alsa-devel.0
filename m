From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH] sound: emu10k1: Replace GFP_ATOMIC with
 GFP_KERNEL in synth_alloc_pages
Date: Tue, 23 Jan 2018 15:28:07 +0100
Message-ID: <e47f14fc-f823-ddca-5aa1-e099edb04a25@maciej.szmigiero.name>
References: <1516700268-26923-1-git-send-email-baijiaju1990@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E2D8267044
 for <alsa-devel@alsa-project.org>; Tue, 23 Jan 2018 15:28:10 +0100 (CET)
In-Reply-To: <1516700268-26923-1-git-send-email-baijiaju1990@gmail.com>
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
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

On 23.01.2018 10:37, Jia-Ju Bai wrote:
> The function synth_alloc_pages is not called in atomic context.
> Thus GFP_ATOMIC is not necessary, and it can be replaced with GFP_KERNEL.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  sound/pci/emu10k1/memory.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I've submitted a patch last Sunday that removes this whole code anyway,
see: "[PATCH 4/5] ALSA: emu10k1: make sure synth DMA pages are allocated with DMA functions".

Maciej
