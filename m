From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH] ASoC: fsl_ssi: separately enable and
 disable TIE/RIE in trigger()
Date: Tue, 29 Oct 2013 06:59:44 -0500
Message-ID: <526FA330.3080209@tabi.org>
References: <1383044688-28596-1-git-send-email-b42378@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by alsa0.perex.cz (Postfix) with ESMTP id DE8002608C9
 for <alsa-devel@alsa-project.org>; Tue, 29 Oct 2013 12:59:47 +0100 (CET)
In-Reply-To: <1383044688-28596-1-git-send-email-b42378@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <b42378@freescale.com>, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

Nicolin Chen wrote:
> This patch enables Tx-related SIER_FLAGS only when direction is PLAYBACK
> and does same thing for CAPTURE. Also, after TRIGGER_STOP/PAUSE, it will
> disable SIER_xFLAGS for symmetric.

I'm okay with this patch in principle, but why bother?  The sysfs entry 
is going to display all interrupts anyway, and so the result will be the 
same.
