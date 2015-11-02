From: Zidan Wang <zidan.wang@freescale.com>
Subject: Re: wm8960 sleep time is too long when system suspend
Date: Mon, 2 Nov 2015 18:49:23 +0800
Message-ID: <20151102104921.GA4769@shlinux2>
References: <20151102084402.GA7603@shlinux2> <20151102091855.GO10520@ck-lbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0110.outbound.protection.outlook.com [65.55.169.110])
 by alsa0.perex.cz (Postfix) with ESMTP id DDC1B2607C8
 for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2015 11:51:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20151102091855.GO10520@ck-lbox>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 02, 2015 at 09:18:55AM +0000, Charles Keepax wrote:
> On Mon, Nov 02, 2015 at 04:44:04PM +0800, Zidan Wang wrote:
> > Hi Mark,
> > 
> > In wm8960 codec driver, suspend_bias_off has been enabled. So when system suspend, the wm8960 codec will go to bias off,
> > it will disable VMID and VREF, then sleep 600ms. It seems that 600ms is too long for system suspend.
> > 
> > Because the wm8960 datasheet don't mentioned the sleep time, so i want to check with you if we can shorten the sleep time.
> 
> I can't say that I am explicit familiar with the required delay
> there, but the comment in the code says that we are letting VMID
> and VREF discharge, which I certainly could believe would take a
> while. My guess would be that we likely weren't super excited
> about putting a 600mS delay in, which probably means it was
> necessary for some reason.
> 
> How much where you hoping to reduce it by? I can see if I can
> find a hardware engineer who still remembers enough about the
> part to discuss it with.
> 

Some customer can't accept such long system suspend time. It's better to spend less than 100ms for system suspend.
Codec suspend is a part of system suspend, so it should be less than 100ms, and as short as possible.


Best Regards,
Zidan Wang

> Thanks,
> Charles
