From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: [PATCH TINYCOMPRESS 14/14] cplay:
	support	auto-configuration of fragment size and count
Date: Mon, 11 Feb 2013 09:58:45 +0000
Message-ID: <20130211095845.GA27658@opensource.wolfsonmicro.com>
References: <20130210002340.GN31139@opensource.wolfsonmicro.com>
 <20130211085311.GC3789@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CCC8C260325
 for <alsa-devel@alsa-project.org>; Mon, 11 Feb 2013 11:08:01 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20130211085311.GC3789@intel.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> looks like patches you have generated against is
> older one.

Yes this is true, which is how it should be.
These patches and the ones from Charles Keepax
are a single development line, and Charles's patches
were based on top of this sequence.
What's happened is that the patches from Charles
have been upstreamed and applied out-of-order.
These 14 should be applied, and then the set from
Charles.
