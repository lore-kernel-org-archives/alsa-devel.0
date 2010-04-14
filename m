From: Wu Fengguang <fengguang.wu@intel.com>
Subject: pulseaudio eats 19% CPU power in Fedora 12
Date: Wed, 14 Apr 2010 15:56:58 +0800
Message-ID: <20100414075658.GA26283@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 618C92445E
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Apr 2010 09:57:15 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lennart Poettering <lennart@poettering.net>
Cc: pulseaudio-discuss@mail.0pointer.de, "Fu, Michael" <michael.fu@intel.com>, alsa-devel@alsa-project.org, "He, Shuang" <shuang.he@intel.com>, "Bu, Long" <long.bu@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Lennart,

We found that pulseaudio eats CPU ~19% CPU time, a little more than
mplayer when playing video. This is horrible for laptop batteries.

Can we make it just work -- in green CPU mode? I can find many users
complaining about this, and it seems like some fix is available in
this link:
https://bugs.launchpad.net/ubuntu/+source/pulseaudio/+bug/207135

Thanks,
Fengguang
