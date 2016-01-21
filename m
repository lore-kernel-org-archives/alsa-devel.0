From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: Discarding the first few frames inside the kernel
Date: Thu, 21 Jan 2016 11:18:44 +0900
Message-ID: <56A04004.1020206@sakamocchi.jp>
References: <CACaQK7CtpKQK_j5q+F6ekK_j+w3SLQ=RQ0yR76+81ETvsg1Qdg@mail.gmail.com>
 <569D9DFE.5000503@sakamocchi.jp>
 <CACaQK7DCUx7=2t-SBZQ6vjU4OJ+Le0YcOK_D-0q4RqFczTO9Zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id E908A260439
 for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2016 03:18:47 +0100 (CET)
In-Reply-To: <CACaQK7DCUx7=2t-SBZQ6vjU4OJ+Le0YcOK_D-0q4RqFczTO9Zg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ankhit Vivekananda <ankhit.vivekananda@biscotti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Jan 21 2016 02:24, Ankhit Vivekananda wrote:
> I am not sure as to how the wait for 4.5ms can be applied there?

I think you asked about the way to achieve the idea.

Call kernel's process scheduler in the .prepare() implementation of your 
driver. For example, msleep() in <linux/delay.h> (More geneous logic is 
preferrable, I think.)

Don't do this in .trigger() implementation, because this can be called 
in interrupt context, or between 
spin_lock_irqsave()/spin_lock_irqstore() in process context.

> Alternatively, does calling snd_pcm_format_set_silence(), be a safe
> method to silence the first few samples coming out of the buffer?

I don't know exactly because I have no supplemental information about 
your driver and hardware design.


Regards

Takashi Sakamoto
