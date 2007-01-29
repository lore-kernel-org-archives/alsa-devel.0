From: Greg KH <gregkh@suse.de>
Subject: [GIT PATCH] ALSA core fix for 2.6.20-rc5
Date: Mon, 29 Jan 2007 14:50:55 -0800
Message-ID: <20070129225055.GA4796@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mx1.suse.de (ns1.suse.de [195.135.220.2])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 62EA52B2
	for <alsa-devel@alsa-project.org>; Mon, 29 Jan 2007 23:51:52 +0100 (MET)
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

Takashi asked me to send you this single patch as it conflicted with his
current tree and it is needed before 2.6.20 comes out to fix a userspace
ABI breakage that I caused earlier.

This patch fixes a bug with the sound core when CONFIG_SYSFS_DEPRECATED
is enabled.  More details can be found in the patch itself, which will
follow as a reply to this message.

Please pull from:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/driver-2.6.git/

thanks,

greg k-h


 include/sound/core.h   |   18 +++++++++++++++---
 sound/core/init.c      |   18 +++++++++++-------
 sound/core/sound.c     |    4 +---
 sound/core/sound_oss.c |    4 +---
 4 files changed, 28 insertions(+), 16 deletions(-)

---------------

Takashi Iwai (1):
      ALSA: Fix sysfs breakage


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
