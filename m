From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Locking/mutex for snd_pcm_update_hw_ptr0() call
Date: Mon, 7 Nov 2016 15:15:24 +0100
Message-ID: <6a229803-cfe2-81b0-d873-902831e3314d@ladisch.de>
References: <58207934.8080006@IEE.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 7518A266B02
 for <alsa-devel@alsa-project.org>; Mon,  7 Nov 2016 15:15:26 +0100 (CET)
In-Reply-To: <58207934.8080006@IEE.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alan Young <Alan.Young@IEE.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Alan Young wrote:
> It is possible that the DMA interrupt handler could call
> snd_pcm_update_hw_ptr0() while it is part way through a call
> from snd_pcm_status(), or vice versa?

The *lock_irq* functions disable interrupts on the current CPU.


Regards,
Clemens
