From: Dylan Reid <dgreid@chromium.org>
Subject: Using HDA on an SoC without PCI
Date: Fri, 14 Feb 2014 09:47:14 -0800
Message-ID: <CAEUnVG525yyj_X9c5ND6jdHA+N8YXPkfhB9=vAG_RuRPtZUKbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f46.google.com (mail-qa0-f46.google.com
 [209.85.216.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 955612617A4
 for <alsa-devel@alsa-project.org>; Fri, 14 Feb 2014 18:47:35 +0100 (CET)
Received: by mail-qa0-f46.google.com with SMTP id k15so5382793qaq.33
 for <alsa-devel@alsa-project.org>; Fri, 14 Feb 2014 09:47:35 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

Hi,

I'm working on an system with an HDMI codec on an HDA interface, but
that interface doesn't use PCI.  I want to re-use as much of the code
as possible, but I want to avoid scattering ifdefs all over
hda_intel.c.

Would gathering the pci specific functions from hda_intel.c into an
interface struct of some kind make sense?  If azx was probed from pci,
then a pci interface would be used, if it was a platform driver, then
the correct interface for the platform would be used.  It would add
some overhead to operations such as azx_writel, but that would be
measured to make sure it isn't detrimental to performance.

Any other ideas on how to approach this?

Thanks,

Dylan
