From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: arizona: Exit startup early if no
	runtime
Date: Tue, 29 Dec 2015 09:46:40 +0000
Message-ID: <20151229094640.GC6058@localhost.localdomain>
References: <1450874881-31458-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20151224194105.GK579@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 33E44265512
 for <alsa-devel@alsa-project.org>; Tue, 29 Dec 2015 10:46:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20151224194105.GK579@sirena.org.uk>
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
Cc: vinod.koul@intel.com, jeeja.kp@intel.com, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 24, 2015 at 07:41:05PM +0000, Mark Brown wrote:
> On Wed, Dec 23, 2015 at 12:48:01PM +0000, Charles Keepax wrote:
> > commit 9b8ef9f6b3fc ("ASoC: dapm: Add startup & shutdown for dai_links")
> > 
> > Added support for calling startup on CODEC to CODEC links, however this
> > is called with a NULL runtime pointer. There isn't really a sensible way
> > to pass a valid runtime pointer to a CODEC to CODEC link at the moment,
> > so we need to make the startup function safe for NULL runtimes.  This
> > patch returns from the Arizona startup function early if there is no
> > runtime.
> 
> We need a bit more here about why it's safe to just skip this code - it
> is actually safe since we're just setting constraints for userspace but
> that's not something the reader can tell without looking for more
> context.

Yeah no problem I will respin and send out a new version today.

Thanks,
Charles
