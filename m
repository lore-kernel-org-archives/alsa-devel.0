From: Alan Young <Alan.Young@IEE.org>
Subject: Re: Locking/mutex for snd_pcm_update_hw_ptr0() call
Date: Mon, 7 Nov 2016 14:56:00 +0000
Message-ID: <58209600.1090908@IEE.org>
References: <58207934.8080006@IEE.org>
 <6a229803-cfe2-81b0-d873-902831e3314d@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f48.google.com (mail-wm0-f48.google.com [74.125.82.48])
 by alsa0.perex.cz (Postfix) with ESMTP id ABEE4266B02
 for <alsa-devel@alsa-project.org>; Mon,  7 Nov 2016 15:56:02 +0100 (CET)
Received: by mail-wm0-f48.google.com with SMTP id p190so188044799wmp.1
 for <alsa-devel@alsa-project.org>; Mon, 07 Nov 2016 06:56:02 -0800 (PST)
In-Reply-To: <6a229803-cfe2-81b0-d873-902831e3314d@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 07/11/16 14:15, Clemens Ladisch wrote:
> Alan Young wrote:
>> It is possible that the DMA interrupt handler could call
>> snd_pcm_update_hw_ptr0() while it is part way through a call
>> from snd_pcm_status(), or vice versa?
> The *lock_irq* functions disable interrupts on the current CPU.
>
>

But only on the current CPU? So that would imply that multiple threads 
could execute snd_pcm_update_hw_ptr0() simultaneously on multi-CPU systems.

Even on a single-CPU system, I presume that the interrupt handler cannot 
be pre-empted by a user-space call such as snd_pcm_status(). Is that 
correct?

Alan.
