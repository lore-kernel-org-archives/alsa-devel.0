From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH TINYCOMPRESS 14/14] cplay: support
 auto-configuration of fragment size and count
Date: Mon, 11 Feb 2013 02:43:57 -0800
Message-ID: <20130211104357.GF3789@intel.com>
References: <20130210002340.GN31139@opensource.wolfsonmicro.com>
 <20130211085311.GC3789@intel.com>
 <20130211095845.GA27658@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id CDA4226165E
 for <alsa-devel@alsa-project.org>; Mon, 11 Feb 2013 12:08:33 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20130211095845.GA27658@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 11, 2013 at 09:58:45AM +0000, Richard Fitzgerald wrote:
> > looks like patches you have generated against is
> > older one.
> 
> Yes this is true, which is how it should be.
> These patches and the ones from Charles Keepax
> are a single development line, and Charles's patches
> were based on top of this sequence.
> What's happened is that the patches from Charles
> have been upstreamed and applied out-of-order.
> These 14 should be applied, and then the set from
> Charles.

That is not how it works. Since Charles sent his patches first I applied those.
Now these will _need_ to based on tip of the tree you are targetting not on some
older rev.

If you have internal dependecies you should have internally sorted that out!

Now pls rebase these

--
~Vinod
