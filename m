From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: soc_jack - add function to
 determine jack type
Date: Mon, 31 Jan 2011 12:08:26 +0000
Message-ID: <20110131120826.GD5123@opensource.wolfsonmicro.com>
References: <1296234579-6622-1-git-send-email-priya.harsha@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 914AD244E4
	for <alsa-devel@alsa-project.org>; Mon, 31 Jan 2011 13:08:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1296234579-6622-1-git-send-email-priya.harsha@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Harsha Priya <priya.harsha@intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 28, 2011 at 10:39:39PM +0530, Harsha Priya wrote:

> given the mic bias value. For any codec that would give
> the mic bias value on a jack insertion, this function would
> return the type of jack based on mic bias range

I think this is too minimal as an API for this.  There's two things I'm
missing here.  The major one is that there's no handling of debounce -
jack insertion is a very slow and very analogue process relative to CPUs 
so taking a single reading is likely to give false measurements.

The other is that there's no facility for either scaling the voltages
with micbias (obviously the specific voltages read are going to vary
depending on what the micbias voltage on a given system is) or for
adding other things that can be detected.  For example, some systems
have buttons on their headset which pull micbias to ground via varying
resistances with individual buttons being detected by measuring the
different voltages resulting from the different resistances.

It'd be worth taking a look at the sec_jack stuff that Samsung have used
in at least some of their Android devices:

  http://android.git.kernel.org/?p=kernel/samsung.git;a=blob;f=include/linux/sec_jack.h

It's quite hard coded in code terms but it covers things like the
debounce.
