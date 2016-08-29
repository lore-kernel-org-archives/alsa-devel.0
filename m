From: Vaishali Thakkar <vaishali.thakkar@oracle.com>
Subject: Re: [PATCH 0/2] ALSA: fireworks/firewire-tascam:
 accessing to user space outside spinlock
Date: Mon, 29 Aug 2016 23:02:04 +0530
Message-ID: <57C47194.40201@oracle.com>
References: <1472244609-31830-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by alsa0.perex.cz (Postfix) with ESMTP id ECDF7266881
 for <alsa-devel@alsa-project.org>; Mon, 29 Aug 2016 19:32:16 +0200 (CEST)
In-Reply-To: <1472244609-31830-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org



On Saturday 27 August 2016 02:20 AM, Takashi Sakamoto wrote:
> Hi,
> 
> In ALSA fireworks driver and firewire-tascam driver, current implementation
> for hwdep interface have issues for page fault handling. For example,
> when using single core processor, after executing lock_page() in page fault
> handler and call task scheduler, then the context never run again, because
> any interrupts are disabled by these drivers and the context can't catch
> waiting event. This patchset fixes the issues.
> 
> The issues were reported by Vaishali Thakkar, with a help of coccinelle.
> Thanks a lot for his care to these minor drivers.
> http://mailman.alsa-project.org/pipermail/alsa-devel/2016-August/111887.html

Hi,

Just a minor correction here. 'his -> her' :)

> Takashi Sakamoto (2):
>   ALSA: fireworks: accessing to user space outside spinlock
>   ALSA: firewire-tascam: accessing to user space outside spinlock
> 
>  sound/firewire/fireworks/fireworks_hwdep.c | 20 ++++++++++++++-----
>  sound/firewire/tascam/tascam-hwdep.c       | 32 ++++++++++--------------------
>  2 files changed, 25 insertions(+), 27 deletions(-)
> 

-- 
Vaishali
