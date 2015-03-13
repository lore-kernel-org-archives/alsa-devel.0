From: "Jie, Yang" <yang.jie@intel.com>
Subject: Re: [PATCH 0/5] Intel SST driver restructure
Date: Fri, 13 Mar 2015 01:28:00 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A901BD6C63@SHSMSX101.ccr.corp.intel.com>
References: <1426170720-8260-1-git-send-email-yang.jie@intel.com>
 <20150312195420.GB28806@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id C50502612D0
 for <alsa-devel@alsa-project.org>; Fri, 13 Mar 2015 02:28:21 +0100 (CET)
In-Reply-To: <20150312195420.GB28806@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>, "Koul, Vinod" <vinod.koul@intel.com>, "Lin,
 Mengdong" <mengdong.lin@intel.com>, "Li, Jocelyn" <jocelyn.li@intel.com>, "Chehab, John" <john.chehab@intel.com>, "Nikula,
 Jarkko" <jarkko.nikula@intel.com>, "Jin, Yao" <yao.jin@intel.com>, "Bossart,
 Pierre-louis" <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Friday, March 13, 2015 3:54 AM
> To: Jie, Yang
> Cc: alsa-devel@alsa-project.org; Girdwood, Liam R; Koul, Vinod; Nikula,
> Jarkko; Bossart, Pierre-louis; Lin, Mengdong; Jin, Yao
> Subject: Re: [PATCH 0/5] Intel SST driver restructure
> 
> On Thu, Mar 12, 2015 at 10:31:55PM +0800, Jie Yang wrote:
> > In order to prepare for the upstreaming of Skylake drivers and to
> > allow reuse of code between different Intel audio DSP products, this
> > patch series restructures the Intel directory as follows:
> 
> This is all fine by me - I'd just like to see an ack before we do this from the
> other Intel people to make sure they're not going to get surprised, and also
[Keyon] understood. I have sent this series to Intel internal before here, and
Most Intel Linux Audio driver people should have known about this change.
Vinod(Atoms & BSW), Jarkko(Baytrail), Mengdong(BSW), Liam(Haswell), 
could you please help add 'acked-by' if it's OK for you? Thanks.
> make sure that any in flight patches (particularly bug fixes) get merged
> before the rename since this will make it easier to apply things.  Indeed, do
[Keyon] yes, I see that some patches from Jin, Yao are in flight, agree that
we should merge them before this restructuring applied.
> we have an ETA for the Skylake code?  If it's not due before the merge
[Keyon] sorry, I am not clear about this ETA, per my understanding, applying
this series sooner may help for our later work: refactor the low level common
code into generic APIs.
Hi Liam, what's your comment on this?
> window then it might be best to apply these (or changes like them) at the
> very end of this development cycle.
