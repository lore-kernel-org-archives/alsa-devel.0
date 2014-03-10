From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/9] ASoC: arizona: Move calculation of
	FLL	configuration
Date: Mon, 10 Mar 2014 09:11:05 +0000
Message-ID: <20140310091105.GL8570@opensource.wolfsonmicro.com>
References: <1394210065-23941-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1394210065-23941-5-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20140309082649.GO28112@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 731E0265026
 for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2014 10:11:06 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20140309082649.GO28112@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lee.jones@linaro.org, lgirdwood@gmail.com, sameo@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Sun, Mar 09, 2014 at 08:26:49AM +0000, Mark Brown wrote:
> On Fri, Mar 07, 2014 at 04:34:20PM +0000, Charles Keepax wrote:
> > Currently the FLL configuration is calculated before it is known which
> > FLL path the configuration will be applied to. Newer versions of the IP
> > have differences in the configuration required for each FLL path, which
> > makes it complicated to calculate the FLL configuration in advance.
> > 
> > This patch simply checks the validity of a requested input and output
> > frequency before we know which FLL path they will be applied to and
> > saves the actual calculation of the configuration until we know where
> > the settings will be applied.
> 
> I'll apply this but are you sure that this validity check is actually
> accurate?  For some of the devices there were input/output
> configurations that couldn't be reached due to constraints in the system
> even though both input and output were in range.

I will look over it again to make sure.

Thanks,
Charles
