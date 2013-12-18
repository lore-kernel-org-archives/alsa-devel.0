From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [RFC PATCH] ASoC: wm_adsp: Change ADSPs to be
	mixer widgets	rather the PGAs
Date: Wed, 18 Dec 2013 14:14:23 +0000
Message-ID: <20131218141423.GF11138@opensource.wolfsonmicro.com>
References: <1387364024-15708-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20131218112739.GH28455@sirena.org.uk>
 <20131218131436.GE11138@opensource.wolfsonmicro.com>
 <20131218132343.GP28455@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B4924261664
 for <alsa-devel@alsa-project.org>; Wed, 18 Dec 2013 15:14:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20131218132343.GP28455@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 18, 2013 at 01:23:43PM +0000, Mark Brown wrote:
> On Wed, Dec 18, 2013 at 01:14:36PM +0000, Charles Keepax wrote:
> > Muting the output is a little tricky though as a graph walk will
> > be required to determine which output was connected, unless you
> > have any handy ideas I have not spotted? I will start having a
> > look to see what could be done on the muting front.
> 
> Not the physical output, the DSP output into the rest of the device.  It
> would be very surprising if it powered up making noise.

Regrettably, I don't believe there is a way to mute the output of
the DSP. Muting the physical output does fix the issue.  I could
look at seperating out the physical power up of the core and
starting the firmware to be seperate widgets, that might also
fix the issue and would mean the firmware wouldn't run until the
input signal was clean, but I am not sure if feels that neat a
solution.

Thanks,
Charles
