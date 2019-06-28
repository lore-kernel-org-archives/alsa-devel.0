From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH 41/87] sound: ppc: remove memset after dma_alloc_coherent
Date: Fri, 28 Jun 2019 10:53:14 +0200
Message-ID: <b5f24a12-7fcf-63d3-4ca0-578aabbcbb8f@c-s.fr>
References: <20190627174018.4015-1-huangfq.daxian@gmail.com>
 <s5htvca6qp1.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5htvca6qp1.wl-tiwai@suse.de>
Content-Language: fr
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, Fuqian Huang <huangfq.daxian@gmail.com>
Cc: Rob Herring <robh@kernel.org>, alsa-devel@alsa-project.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org



Le 28/06/2019 à 10:48, Takashi Iwai a écrit :
> On Thu, 27 Jun 2019 19:40:17 +0200,
> Fuqian Huang wrote:
>>
>> In commit af7ddd8a627c
>> ("Merge tag 'dma-mapping-4.21' of git://git.infradead.org/users/hch/dma-mapping"),
>> dma_alloc_coherent has already zeroed the memory.
>> So memset is not needed.
>>
>> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
> 
> Applied, thanks.
> 

Euh ... looks like a v2 of this series was sent out.

Christophe
