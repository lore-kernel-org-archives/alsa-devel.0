From: "Jie, Yang" <yang.jie@intel.com>
Subject: Re: [PATCH] ASoC: Intel: fix a compiling issue
Date: Sun, 19 Apr 2015 01:39:27 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A905513183@SHSMSX101.ccr.corp.intel.com>
References: <1428893250-21092-1-git-send-email-yang.jie@intel.com>
 <20150418121106.GM26185@sirena.org.uk>
 <CAOf5uw=x2F9AFxoFwGNh-2FbjX-E7sZuki5e6t71JH0amyAb-w@mail.gmail.com>
 <20150418170304.GW26185@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 136892612D0
 for <alsa-devel@alsa-project.org>; Sun, 19 Apr 2015 03:39:32 +0200 (CEST)
In-Reply-To: <20150418170304.GW26185@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>, Michael Trimarchi <michael@amarulasolutions.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Sunday, April 19, 2015 1:03 AM
> To: Michael Trimarchi
> Cc: alsa-devel@alsa-project.org; Jie, Yang; Girdwood, Liam R
> Subject: Re: [alsa-devel] [PATCH] ASoC: Intel: fix a compiling issue
> 
> On Sat, Apr 18, 2015 at 02:19:37PM +0200, Michael Trimarchi wrote:
> > On Apr 18, 2015 8:11 PM, "Mark Brown" <broonie@kernel.org> wrote:
> 
> > > Rather than have the ifdefs in the users it seems like it'd be
> > > better to fix this by providing static inline stub functions in the
> > > headers.  That way nothing else will run into the same trouble.
> 
> > This was my "English" suggestion
> 
> Yeah, I hadn't seen your mail when I wrote the above.
 
Thank you, Mark and Michael. Will follow it and send another patch
soon.

~Keyon
