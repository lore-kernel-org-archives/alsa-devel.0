From: David Henningsson <david.henningsson@canonical.com>
Subject: hda-compiler, was: hda-verb, hda-analyzer,
	hda-emu and codecgraph
Date: Tue, 27 Jul 2010 17:33:32 +0200
Message-ID: <4C4EFC4C.40707@canonical.com>
References: <4C4EC384.4040904@canonical.com> <s5hzkxdt6cf.wl%tiwai@suse.de>
	<alpine.LNX.2.00.1007271603010.4068@eeebox2.perex-int.cz>
	<s5hzkxdc8p6.wl%tiwai@suse.de>
	<alpine.LNX.2.00.1007271622510.4068@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 4CF00245E2
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Jul 2010 17:33:35 +0200 (CEST)
In-Reply-To: <alpine.LNX.2.00.1007271622510.4068@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010-07-27 16:57, Jaroslav Kysela skrev:
> A little off topic: hda-compiler . I'm playing with an idea to have the
> hda-intel driver behaviour description (patches) in a firmware file.

There seem to be more than one thought in that area. Recently there has
been some discussion (at least on Ubuntu Developer Summit) whether the
device-tree[1] structure could be used in this area as well.
Since we would then have separate device-tree files, we could update
them independent of the kernel.

I'll go to plumbers in November, could this be something to discuss at
that conference?

[1] http://www.devicetree.org

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
