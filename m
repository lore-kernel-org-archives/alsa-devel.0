From: Ross Zwisler <zwisler@google.com>
Subject: Correct git tree for ALSA development
Date: Mon, 29 Apr 2019 14:29:18 -0600
Message-ID: <20190429202918.GA35915@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it1-x142.google.com (mail-it1-x142.google.com
 [IPv6:2607:f8b0:4864:20::142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AF9D1F80641
 for <alsa-devel@alsa-project.org>; Mon, 29 Apr 2019 22:29:24 +0200 (CEST)
Received: by mail-it1-x142.google.com with SMTP id z4so1158474itc.3
 for <alsa-devel@alsa-project.org>; Mon, 29 Apr 2019 13:29:24 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I'm trying to ramp up a bit on ALSA development, and I noticed that many
sound-related entries in MAINTAINERS still refer to alsa-kernel.git hosted on
alsa-project.org, i.e.:

BT87X AUDIO DRIVER
M:      Clemens Ladisch <clemens@ladisch.de>
L:      alsa-devel@alsa-project.org (moderated for non-subscribers)
T:      git git://git.alsa-project.org/alsa-kernel.git
S:      Maintained
F:      Documentation/sound/cards/bt87x.rst
F:      sound/pci/bt87x.c

>From the alsa-project.org pages:

https://alsa-project.org/wiki/Download#Developers:_GIT_access
https://alsa-project.org/wiki/GIT_Server#For_developers_-_kernel_drivers

it seems like current development/maintenance actually happens somewhere else,
possibly on Mark Brown's kernel.org tree?

https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/

If so, should we update those stale MAINTAINERS entries?

Thanks,
- Ross
