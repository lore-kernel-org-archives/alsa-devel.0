From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: wm8960 sleep time is too long when system suspend
Date: Mon, 2 Nov 2015 09:18:55 +0000
Message-ID: <20151102091855.GO10520@ck-lbox>
References: <20151102084402.GA7603@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id A89B4260691
 for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2015 10:34:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20151102084402.GA7603@shlinux2>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@freescale.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 02, 2015 at 04:44:04PM +0800, Zidan Wang wrote:
> Hi Mark,
> 
> In wm8960 codec driver, suspend_bias_off has been enabled. So when system suspend, the wm8960 codec will go to bias off,
> it will disable VMID and VREF, then sleep 600ms. It seems that 600ms is too long for system suspend.
> 
> Because the wm8960 datasheet don't mentioned the sleep time, so i want to check with you if we can shorten the sleep time.

I can't say that I am explicit familiar with the required delay
there, but the comment in the code says that we are letting VMID
and VREF discharge, which I certainly could believe would take a
while. My guess would be that we likely weren't super excited
about putting a 600mS delay in, which probably means it was
necessary for some reason.

How much where you hoping to reduce it by? I can see if I can
find a hardware engineer who still remembers enough about the
part to discuss it with.

Thanks,
Charles
