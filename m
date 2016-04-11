From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 2/4] ALSA: compress: Add function to
 indicate the stream has gone bad
Date: Mon, 11 Apr 2016 16:13:41 +0100
Message-ID: <20160411151341.GP31814@localhost.localdomain>
References: <1460384855-10567-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1460384855-10567-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <s5hpotw2ooc.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 0FBE826580E
 for <alsa-devel@alsa-project.org>; Mon, 11 Apr 2016 17:14:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hpotw2ooc.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 11, 2016 at 04:41:23PM +0200, Takashi Iwai wrote:
> On Mon, 11 Apr 2016 16:27:33 +0200,
> Charles Keepax wrote:
> > +	switch (stream->runtime->state) {
> > +	case SNDRV_PCM_STATE_OPEN:
> > +	case SNDRV_PCM_STATE_XRUN:
> > +		return -EBADFD;
> 
> One question is whether we want a dedicated error code for XRUN or
> such a DSP error.  On PCM, for example, we return -EPIPE traditionally
> for XRUN state.  This is a clear indicator for user what to do at
> next.
> 
> Other than that, the patch series looks good to me.

I think it probably makes sense to copy what the PCM framework
does here, I will respin and use EPIPE.

Thanks,
Charles
