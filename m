From: Lu Guanqun <guanqun.lu@intel.com>
Subject: Re: [PATCH 3/3] ALSA: core: set kcontrol's count field
	correctly
Date: Wed, 24 Aug 2011 20:46:38 +0800
Message-ID: <20110824124638.GC1811@guanqun-laptop.ccr.corp.intel.com>
References: <20110824031234.5279.46501.stgit@localhost6.localdomain6>
	<20110824031243.5279.93859.stgit@localhost6.localdomain6>
	<s5hy5yjpclx.wl%tiwai@suse.de>
	<20110824061757.GF3551@guanqun-laptop.sh.intel.com>
	<s5hsjorpbo8.wl%tiwai@suse.de> <s5hfwkrp5eq.wl%tiwai@suse.de>
	<20110824114613.GA1811@guanqun-laptop.ccr.corp.intel.com>
	<s5hsjor9fq3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id AA7EF103910
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Aug 2011 14:46:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hsjor9fq3.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA <alsa-devel@alsa-project.org>, "clemens@ladisch.de" <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 24, 2011 at 08:05:56PM +0800, Takashi Iwai wrote:
> > Hi Takashi,
> > 
> > I don't how this approach can solve this problem.
> 
> There is no problem.  You can't copy the data from ELEM_INFO for
> ELEM_ADD/REPLACE.  It was a wrong assumption to reuse the data.
> Instead, you had to set up the struct field manually.
> That is, the test procedure was simply wrong.
> 
> > There's still an
> > implicit assumption here that user space application will clear
> > info->elem_count to zero before it issues the REPLACE ioctl, right?
> 
> Yes, the point is that it's no longer same structure.  So, you can't
> copy from the result from ELEM_INFO ioctl any more.  Instead, you need
> to set up the struct field manually.

Thanks Takashi, that's the info I'm looking for. We need to state this
requirements explicitly, it seems we lack these kind of documentation and
thus it results in poorly written test cases in user space.

Is there any man pages or documentation we can state this clearly? I can
help to contribute some documentation or even add some sample programs
there.

-- 
guanqun
