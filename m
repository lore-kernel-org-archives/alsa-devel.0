From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v4 07/13] soundwire: Add stream
 configuration APIs
Date: Tue, 24 Apr 2018 14:39:10 +0530
Message-ID: <20180424090909.GE6014@localhost>
References: <cf20c1f6-0804-70df-0f2d-6ad670481321@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 3DFB0266CA1
 for <alsa-devel@alsa-project.org>; Tue, 24 Apr 2018 11:04:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <cf20c1f6-0804-70df-0f2d-6ad670481321@linux.intel.com>
 <20180423034510.GA22365@buildpc-HP-Z230>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sanyog Kale <sanyog.r.kale@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: ALSA <alsa-devel@alsa-project.org>, tiwai@suse.de, Greg KH <gregkh@linuxfoundation.org>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 23, 2018 at 09:15:10AM +0530, Sanyog Kale wrote:
> On Sat, Apr 21, 2018 at 09:43:15PM +0530, Vinod Koul wrote:
> > On Sat, Apr 21, 2018 at 06:56:26AM -0700, Pierre-Louis Bossart wrote:
> > > >+	if (!bus->params.bandwidth) {
> > > >+		bus->params.row = 0;
> > > >+		bus->params.col = 0;
> > > >+		goto exit;
> > > 
> > > What is the intent with this test+goto? Shouldn't you program the parameters
> > > if you want to change the frame shape?
> > 
> > hmmm that seems correct point to me, but then we are going idle and should
> > ideally power down. Let me check again if that is the reason.
> 
> We do not want to program parameters or change frame shape in case of bandwidth
> required is 0 on bus (ie. no stream running). The row and col values are reset
> to 0 and will be re-computed again in prepare_stream of next stream based
> on stream requirement.

Yes that is right

On Mon, Apr 23, 2018 at 08:30:47AM -0500, Pierre-Louis Bossart wrote:
> 
> what about clock stop? what about the default frame shape specified in the
> DisCo spec? I don't see the reason why we'd go to 48x2 - especially on Intel
> platforms where we'll typically use  50x2 to remain aligned with a 48kHz
> frame rate.

But as Pierre pointed out ut should be using DisCo defaults and not 48x2 in
the bus. So I will remove this check and add a TODO for using DisCo value
here

Thanks
-- 
~Vinod
