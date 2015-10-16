From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: Splitting out controls
Date: Fri, 16 Oct 2015 16:24:02 +0100
Message-ID: <1445009042.3536.7.camel@rf-debian.wolfsonmicro.main>
References: <1444657786.2528.78.camel@loki>
 <20151012205908.GA25971@us.netrek.org> <561CADA8.3040903@canonical.com>
 <561D1B7D.9080307@linux.intel.com> <561D2997.1090401@canonical.com>
 <561D2C88.5050505@linux.intel.com> <56209C2A.1010602@canonical.com>
 <56210E75.70501@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B6642606F5
 for <alsa-devel@alsa-project.org>; Fri, 16 Oct 2015 17:24:12 +0200 (CEST)
In-Reply-To: <56210E75.70501@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, James Cameron <quozl@laptop.org>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2015-10-16 at 09:49 -0500, Pierre-Louis Bossart wrote:
> > We actively enable and advocate that people with limited knowledge can
> > 'mess around mixer controls'. That's why we have an alsamixer
> > application in the first place, and teach people how to use it.
> 
> What you are describing is the traditional approach where the number of 
> controls is limited, a couple of switches here and a set of volume 
> controls there.
> With new devices having mixers all over the place, be it in codecs or 
> DSPs, it's not uncommon to have several hundred controls. There is no 
> way users will be able to find out on their own what values they should 
> use and it would be misleading to think developers are able to identify 
> all lethal combinations of settings. We've also moved all these control 
> settings from kernel to userspace to avoid hardcoding values that are 
> platform specific.
> Bottom line we have to move to profiles, stop guessing values based on 
> control names or avoid letting users poke random values in alsamixer. 
> This just doesn't scale any more. thinking that the alsamixer 
> command-line remains the default user-facing interface moving forward is 
> just not right, it's a developer tool.

I believe that you are misunderstanding David's point. Yes, there can be
a large number of controls (the Wolfson WM8280 has over 400 controls,
some Cirrus Logic codecs have nearly 900). The point was not whether the
users should understand the meaning of all these controls but that they
should be able to "play around and see what happens" without any risk of
bricking their hardware. Regardless of whether what they are doing is
meaningful or whether it's really feasible to set hundreds of controls
correctly from the command line, they shouldn't damage the hardware. Not
even root should have the ability to actually damage the hardware.
