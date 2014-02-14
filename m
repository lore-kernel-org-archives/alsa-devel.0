From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: Using HDA on an SoC without PCI
Date: Fri, 14 Feb 2014 11:01:14 -0700
Message-ID: <52FE59EA.2030808@wwwdotorg.org>
References: <CAEUnVG525yyj_X9c5ND6jdHA+N8YXPkfhB9=vAG_RuRPtZUKbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 0362A26171E
 for <alsa-devel@alsa-project.org>; Fri, 14 Feb 2014 19:01:19 +0100 (CET)
In-Reply-To: <CAEUnVG525yyj_X9c5ND6jdHA+N8YXPkfhB9=vAG_RuRPtZUKbA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dylan Reid <dgreid@chromium.org>, alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

On 02/14/2014 10:47 AM, Dylan Reid wrote:
> Hi,
> 
> I'm working on an system with an HDMI codec on an HDA interface, but
> that interface doesn't use PCI.  I want to re-use as much of the code
> as possible, but I want to avoid scattering ifdefs all over
> hda_intel.c.

I think the relevant APIs stub themselves out when appropriate, so you
can do this all without compile-time ifdefs.

> Would gathering the pci specific functions from hda_intel.c into an
> interface struct of some kind make sense?  If azx was probed from pci,
> then a pci interface would be used, if it was a platform driver, then
> the correct interface for the platform would be used.  It would add
> some overhead to operations such as azx_writel, but that would be
> measured to make sure it isn't detrimental to performance.

Our downstream trees do have patches to allow the HDA driver to be
instantiated from either PCI or from platform devices. You can find the
code in branch:

git://nv-tegra.nvidia.com/linux-2.6.git rel-roth-r3
e.g. ef8491346266 "ALSA: hda: Add hda platform driver support"

There are many other patches to sound/pci/hda after that. I don't recall
exactly how clean taht first patch was, and probably never saw anything
after it, but it might be a good start...

We've only recently had HDMI support upstream on Tegra, otherwise it's
possible I may have found time to try to upstream those patches before.
Not that I have spare time:-)
