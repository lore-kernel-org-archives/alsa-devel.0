From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: system suspend and live audio streams
Date: Mon, 16 Apr 2012 19:10:44 +0300
Message-ID: <4F8C4484.5000605@bitmer.com>
References: <CANOLnON2pL5tF2pDHzZ+UEBhtTG1cUmonv5pvs3SrwdtWxcJUw@mail.gmail.com>
	<4F8B1EF3.9040802@bitmer.com> <4F8BF729.20906@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bitmer.com (bitmer.com [213.157.87.50])
	by alsa0.perex.cz (Postfix) with ESMTP id C5C6E104128
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Apr 2012 18:11:48 +0200 (CEST)
In-Reply-To: <4F8BF729.20906@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Grazvydas Ignotas <notasas@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 04/16/2012 01:40 PM, Peter Ujfalusi wrote:
> Because we need to write registers (configure McPBSP).
> 
>> I don't know immediately does this require any major changes for McBSP
>> register access that are done in function calls before omap_mcbsp_start
>> (IRCC hwmod might set already ICLK gating for register access) but some
>> code is needed to deal with McBSP register cache restore (due OMAP
>> OFFMODE that might be hit) and most probably for McBSP FIFO draining as
>> well.
> 
I meant above if hwmod has already set ICLK so (was it autogating?) that
manual enable/disable cycle for ICLK may not be needed for register
access if clock is automatically gated. I have vague memory that I saw
something like this in hwmod for some block but I'm not sure about this.

But that reminds me that did we have some use-case where FCLK was needed
during register access?

> What we need to do is to have proper register store/restore for McBSP to
> support suspend during audio activity. But. Even with that if the McBSP
> is hitting OFF mode we will loose the McBSP FIFO content (invalidated).
> This means we are going to have missing samples. Probably the user will
> not going to notice it, but it is going to happen.

For register store/restore there is already much implemented thanks to
Janusz's register cache workaround for OMAP1510 :-)

For FIFO I was thinking, if possible, to drain it out before going to
suspend.

-- 
Jarkko
