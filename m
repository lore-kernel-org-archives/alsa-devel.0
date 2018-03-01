From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [asoc:topic/max9867 2/4]
 sound/soc/codecs/max9867.c:294:11: error: 'component' undeclared;
 did you mean 'complete'?
Date: Thu, 1 Mar 2018 22:34:37 +0100
Message-ID: <20180301213436.GB3833@lenoch>
References: <201803020314.sOjeazAH%fengguang.wu@intel.com>
 <20180301200155.GA2304@lenoch>
 <20180301200430.GA23704@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cvs.linux-mips.org (eddie.linux-mips.org [148.251.95.138])
 by alsa0.perex.cz (Postfix) with ESMTP id BD738267198
 for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2018 22:34:38 +0100 (CET)
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
 (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
 id S23992618AbeCAVeiKwFCk (ORCPT
 <rfc822;alsa-devel@alsa-project.org>); Thu, 1 Mar 2018 22:34:38 +0100
Content-Disposition: inline
In-Reply-To: <20180301200430.GA23704@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, kbuild test robot <fengguang.wu@intel.com>, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 01, 2018 at 08:04:30PM +0000, Mark Brown wrote:
> On Thu, Mar 01, 2018 at 09:01:56PM +0100, Ladislav Michl wrote:
> > On Fri, Mar 02, 2018 at 03:45:16AM +0800, kbuild test robot wrote:
> 
> > >    sound/soc/codecs/max9867.c:294:11: note: each undeclared identifier is reported only once for each function it appears in
> 
> > your topic/max9867 seems to be 4.16-rc1 based, while patch was tested
> > in today's -next. Fixing it for 4.16-rc1 would mean it fails to compile
> > once you merge topic branches.
> 
> > What am I supposed to do here?
> 
> Which other commits in my tree does this depend on?

91880a6b6ba3 ("ASoC: wm9867: replace codec to component")
Note, we have naming problem here...
