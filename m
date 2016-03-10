From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/4] ASoC: wm_adsp: Improve DSP error
	handling
Date: Thu, 10 Mar 2016 16:41:31 +0000
Message-ID: <20160310164131.GG1490@localhost.localdomain>
References: <1457606694-10985-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1457606694-10985-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 04EB6260564
 for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2016 17:41:41 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1457606694-10985-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, tiwai@suse.com
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 10, 2016 at 10:44:54AM +0000, Charles Keepax wrote:
> If we encounter an error on the DSP side whilst user-space is waiting on
> the poll we should call snd_compr_fragment_elapsed, although data is
> not actually available we want to wake user-space such that the error
> can be propagated out quickly. Additionally some versions of the DSP
> firmware are not super consistent about actually generating an IRQ if
> they encounter an error, as such we will check the DSP error status
> every time we run out of available data as well, to ensure we catch it.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> ---

Apologies please drop this last change I need to do a respin.
This will ping the poll for spurious interrupts which is not very
desirable. I will fix that and send a rev 2 but the rest of the
chain is good to merge as is.

Thanks,
Charles
