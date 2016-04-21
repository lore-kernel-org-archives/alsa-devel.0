From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v5 2/4] ALSA: compress: Add function to
 indicate the stream has gone bad
Date: Thu, 21 Apr 2016 07:55:22 +0530
Message-ID: <20160421022522.GC2274@localhost>
References: <1461156003-24422-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1461156003-24422-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20160420130851.GY2274@localhost>
 <20160420145446.GC1581@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id B1BA4264F22
 for <alsa-devel@alsa-project.org>; Thu, 21 Apr 2016 04:20:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20160420145446.GC1581@localhost.localdomain>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, tiwai@suse.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 20, 2016 at 03:54:46PM +0100, Charles Keepax wrote:
> On Wed, Apr 20, 2016 at 06:38:51PM +0530, Vinod Koul wrote:
> > On Wed, Apr 20, 2016 at 01:40:01PM +0100, Charles Keepax wrote:
> > > Currently, the avail IOCTL doesn't pass any error status, which
> > > means typically on error it simply shows no data available. This
> > > can lead to situations where user-space is waiting indefinitely
> > > for data that will never come as the DSP has suffered an
> > > unrecoverable error.
> > > 
> > > Add snd_compr_stop_error which end drivers can call to indicate
> > > the stream has suffered an unrecoverable error and stop it. The
> > > avail and poll IOCTLs are then updated to report if the stream is
> > > in an error state to user-space. Allowing the error to propagate
> > > out. Processing of the actual snd_compr_stop needs to be deferred
> > > to a worker thread as the end driver may detect the errors during
> > > an existing operation callback.
> > 
> > Acked-by: Vinod Koul <vinod.koul@intel.com>
> > 
> > Btw are you patching tinycompress as well to handle EPIPE?
> 
> I hadn't planned on it but I am happy to do so. The current
> behaviour was sufficient for our needs in that it reports the
> error and shuts the stream.
> 
> Are you thinking of just printing that a over/under run occurred
> or do you want to try and add some recovery code as well?

To start with yes adding prints would help. Adding code to handle EPIPE
would be good and propagating that to user.

>From lib, certainly we want to see this error progated so that upper layers
can do recovery

Recovery is tricky here as we are doing compressed data so essentially new
data has to be on frame boundary, so upper layers should decide.

Thanks
-- 
~Vinod
