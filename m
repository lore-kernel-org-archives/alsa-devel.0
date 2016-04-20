From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v5 2/4] ALSA: compress: Add function to
 indicate the stream has gone bad
Date: Wed, 20 Apr 2016 15:54:46 +0100
Message-ID: <20160420145446.GC1581@localhost.localdomain>
References: <1461156003-24422-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1461156003-24422-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20160420130851.GY2274@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 09534261B0A
 for <alsa-devel@alsa-project.org>; Wed, 20 Apr 2016 16:54:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20160420130851.GY2274@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, tiwai@suse.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 20, 2016 at 06:38:51PM +0530, Vinod Koul wrote:
> On Wed, Apr 20, 2016 at 01:40:01PM +0100, Charles Keepax wrote:
> > Currently, the avail IOCTL doesn't pass any error status, which
> > means typically on error it simply shows no data available. This
> > can lead to situations where user-space is waiting indefinitely
> > for data that will never come as the DSP has suffered an
> > unrecoverable error.
> > 
> > Add snd_compr_stop_error which end drivers can call to indicate
> > the stream has suffered an unrecoverable error and stop it. The
> > avail and poll IOCTLs are then updated to report if the stream is
> > in an error state to user-space. Allowing the error to propagate
> > out. Processing of the actual snd_compr_stop needs to be deferred
> > to a worker thread as the end driver may detect the errors during
> > an existing operation callback.
> 
> Acked-by: Vinod Koul <vinod.koul@intel.com>
> 
> Btw are you patching tinycompress as well to handle EPIPE?

I hadn't planned on it but I am happy to do so. The current
behaviour was sufficient for our needs in that it reports the
error and shuts the stream.

Are you thinking of just printing that a over/under run occurred
or do you want to try and add some recovery code as well?

Thanks,
Charles
