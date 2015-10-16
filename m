From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: Splitting out controls
Date: Fri, 16 Oct 2015 09:49:25 -0500
Message-ID: <56210E75.70501@linux.intel.com>
References: <1444657786.2528.78.camel@loki>
 <20151012205908.GA25971@us.netrek.org> <561CADA8.3040903@canonical.com>
 <561D1B7D.9080307@linux.intel.com> <561D2997.1090401@canonical.com>
 <561D2C88.5050505@linux.intel.com> <56209C2A.1010602@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 063B52606A2
 for <alsa-devel@alsa-project.org>; Fri, 16 Oct 2015 16:49:28 +0200 (CEST)
In-Reply-To: <56209C2A.1010602@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>, James Cameron <quozl@laptop.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


> We actively enable and advocate that people with limited knowledge can
> 'mess around mixer controls'. That's why we have an alsamixer
> application in the first place, and teach people how to use it.

What you are describing is the traditional approach where the number of 
controls is limited, a couple of switches here and a set of volume 
controls there.
With new devices having mixers all over the place, be it in codecs or 
DSPs, it's not uncommon to have several hundred controls. There is no 
way users will be able to find out on their own what values they should 
use and it would be misleading to think developers are able to identify 
all lethal combinations of settings. We've also moved all these control 
settings from kernel to userspace to avoid hardcoding values that are 
platform specific.
Bottom line we have to move to profiles, stop guessing values based on 
control names or avoid letting users poke random values in alsamixer. 
This just doesn't scale any more. thinking that the alsamixer 
command-line remains the default user-facing interface moving forward is 
just not right, it's a developer tool.
