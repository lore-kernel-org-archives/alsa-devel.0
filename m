From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Merging alsa-firmware into linux-firmware
Date: Thu, 22 Jul 2010 12:07:33 +0200
Message-ID: <4C481865.2010907@canonical.com>
References: <4C457C89.5040209@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 31D4710397A
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Jul 2010 12:07:37 +0200 (CEST)
In-Reply-To: <4C457C89.5040209@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: chase.douglas@canonical.com, david.woodhouse@intel.com
List-Id: alsa-devel@alsa-project.org

Okay, I think I got most of it sorted out:

emi_26_62 / emagic
korg1212 / korg
maestro3 / ess
sb16 / sb16
wavefront / yamaha
ymfpci / yamaha
...are already in linux-firmware so they won't be merged.

multisound / turtlebeach symlinks won't be merged for the time being,
since the original firmware isn't easily accessible.

usx2yloader however seems to put files outside the /lib/firmware path
(/usr/share/alsa/...), and I believe it has a userspace firmware loader
triggered by an udev event. I'll put it into /lib/firmware/tascam or
something like that, but we need to update the loader as well to use the
new path.

The rest should merge without trouble.

On 2010-07-20 12:38, David Henningsson wrote:
> Hi,
> 
> Chase Douglas (@canonical) and I plan to take what's left of
> alsa-firmware and try to merge it into linux-firmware, this might happen
> now or in the coming weeks. This will make alsa-firmware obsolete as all
> firmware will be provided by linux-firmware instead.
> 
> Any words of disagreement, warnings or encouragement before we do so?
> 
> --
> David Henningsson, Canonical Ltd. http://launchpad.net/~diwic
> 



-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
