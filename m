From: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCH] ASoC: fsl_ssi: separately enable and
 disable TIE/RIE in trigger()
Date: Tue, 29 Oct 2013 19:57:11 +0800
Message-ID: <20131029115711.GA9605@MrMyself>
References: <1383044688-28596-1-git-send-email-b42378@freescale.com>
 <526FA330.3080209@tabi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C11C2608D8
 for <alsa-devel@alsa-project.org>; Tue, 29 Oct 2013 13:10:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <526FA330.3080209@tabi.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@tabi.org>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 29, 2013 at 06:59:44AM -0500, Timur Tabi wrote:
> Nicolin Chen wrote:
> >This patch enables Tx-related SIER_FLAGS only when direction is PLAYBACK
> >and does same thing for CAPTURE. Also, after TRIGGER_STOP/PAUSE, it will
> >disable SIER_xFLAGS for symmetric.
> 
> I'm okay with this patch in principle, but why bother?  The sysfs
> entry is going to display all interrupts anyway, and so the result
> will be the same.
>

Well, actually I just wanted to clear T/RDMAE to disable DMA request,
but it seems to be much easier to do it like this based on current
code and disabling unused interrupts should be better right? :)

Thank you,
Nicolin Chen
