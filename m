From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: system suspend and live audio streams
Date: Sun, 15 Apr 2012 22:18:11 +0300
Message-ID: <4F8B1EF3.9040802@bitmer.com>
References: <CANOLnON2pL5tF2pDHzZ+UEBhtTG1cUmonv5pvs3SrwdtWxcJUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bitmer.com (bitmer.com [213.157.87.50])
	by alsa0.perex.cz (Postfix) with ESMTP id 3BC7524902
	for <alsa-devel@alsa-project.org>;
	Sun, 15 Apr 2012 21:19:39 +0200 (CEST)
In-Reply-To: <CANOLnON2pL5tF2pDHzZ+UEBhtTG1cUmonv5pvs3SrwdtWxcJUw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 04/14/2012 06:40 PM, Grazvydas Ignotas wrote:
> Hi,
> 
> Currently on OMAP the system fails to suspend properly if there are
> audio streams active (PER and CORE don't enter low power states). I
> wonder if this is expected to be handled by the driver and can be
> considered a bug, or is it audio daemon's/system's responsibility to
> stop all audio streams before kernel to is asked to start suspending?
> 
Hmm.. this is actually something which is not implemented.

Before arch/arm/plat-omap/mcbsp: omap_mcbsp_request used to enable
clocks and keep them active until omap_mcbsp_free. I.e.
omap_mcbsp_stop/_start which are called during suspend-resume cycle
don't change the clock state.

I don't actually remember why it used to be so. Might be related to SPI
mode use on OMAP1?

But as now the SPI support is dropped (no users and not supported in
later omaps) and mcbsp is merged with omap-mcbsp (no other users than
audio) I don't see why the clocks (or runtime pm) should be active
before omap_mcbsp_start.

I don't know immediately does this require any major changes for McBSP
register access that are done in function calls before omap_mcbsp_start
(IRCC hwmod might set already ICLK gating for register access) but some
code is needed to deal with McBSP register cache restore (due OMAP
OFFMODE that might be hit) and most probably for McBSP FIFO draining as
well.

-- 
Jarkko
