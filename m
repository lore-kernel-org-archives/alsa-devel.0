From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2 2.6.38] ASoC: soc-cache: Introduce
	the	cache_bypass option
Date: Fri, 11 Feb 2011 15:46:54 +0000
Message-ID: <20110211154654.GA32441@opensource.wolfsonmicro.com>
References: <1297436042-18324-1-git-send-email-dp@opensource.wolfsonmicro.com>
	<20110211151825.GA23687@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 70C87245D1
	for <alsa-devel@alsa-project.org>; Fri, 11 Feb 2011 16:46:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20110211151825.GA23687@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 11, 2011 at 03:18:26PM +0000, Mark Brown wrote:
> On Fri, Feb 11, 2011 at 02:54:01PM +0000, Dimitris Papastamos wrote:
> > This is primarily needed to avoid writing back to the cache
> > whenever we are syncing the cache with the hardware.  This gives a
> > performance benefit especially for large register maps.
> 
> Hrm, this is a rather large and invasive patch to be applying as part of
> a bug fix for a specific driver this late in the release process.  Can
> we do something driver specific for the 2.6.38 release?

Would this be acceptable?  In wm8994_resume():

/* force a HW read */
val = wm8994_reg_read(codec->control_data, WM8994_POWER_MANAGEMENT_5);

instead of the call to snd_soc_read().

Thanks,
Dimitris
