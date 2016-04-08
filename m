From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 2/6] ALSA: compress: Add function to
 indicate the stream has gone bad
Date: Fri, 8 Apr 2016 11:58:24 +0100
Message-ID: <20160408105824.GN31814@localhost.localdomain>
References: <1459938115-25456-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1459938115-25456-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1459989603.3136.95.camel@intel.com>
 <20160407082842.GL31814@localhost.localdomain>
 <1460070431.23155.75.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C308260867
 for <alsa-devel@alsa-project.org>; Fri,  8 Apr 2016 12:58:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1460070431.23155.75.camel@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Koul, Vinod" <vinod.koul@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "tiwai@suse.com" <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 07, 2016 at 11:07:12PM +0000, Koul, Vinod wrote:
> On Thu, 2016-04-07 at 09:28 +0100, Charles Keepax wrote:
> > On Thu, Apr 07, 2016 at 12:40:03AM +0000, Koul, Vinod wrote:
> > > On Wed, 2016-04-06 at 11:21 +0100, Charles Keepax wrote:
> > > Also if we do this, then why should pointer return error?
> > 
> > The first patch in the chain could indeed be changed to have
> > pointer calls not return an error status. But I feel that would
> > be making the code worse. Ok the situation I am most interested
> > here indicates a failure of the stream, but its a very small leap
> > to imagine situations where pointer fails temporarily and the
> > stream is still good.
> 
> The point here is that we are anyway propagating error by invoking the
> new API so why return error here.
> Btw can you please explain how this makes code worse?

So if I make pointer return void, the two possible error paths
are either return zero available data or call xrun. Xrun will
stop the stream so I only want to do that if I think the stream
is dead. But that likely leaves various catagories of errors I
don't want to do that for. Returning zero on the other hand hides
the error so no one will ever know an error occurs (well except by
inspecting the kernel log). It feels to me like someone is going
to hit a case where they need to do that at some point. So
removing the return type seems wrong, but at the moment you have
two functions that return ints but don't propogate their values
though which just looks odd in the code.

Thanks,
Charles
