From: mark gross <mgross@linux.intel.com>
Subject: [PATCH]PM_QOS-to-use-handle-based-requests 0/5
Date: Mon, 7 Dec 2009 09:05:17 -0800
Message-ID: <20091207170517.GA5463@linux.intel.com>
Reply-To: mgross@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <e1000-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/e1000-devel>,
	<mailto:e1000-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=e1000-devel>
List-Post: <mailto:e1000-devel@lists.sourceforge.net>
List-Help: <mailto:e1000-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/e1000-devel>,
	<mailto:e1000-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: e1000-devel-bounces@lists.sourceforge.net
To: linux-pm <linux-pm@lists.linux-foundation.org>
Cc: linux-wireless@vger.kernel.org, alsa-devel@alsa-project.org, e1000-devel@lists.sourceforge.net, aili@codeaurora.org, bruce.w.allan@intel.com, lkml <linux-kernel@vger.kernel.org>, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

This is a 5 patch series against linux-next-20091204 that changes pm_qos
to use a handle based access model for the kernel api.  The string
based model was shown to be slow if pm_qos parameters are updated on hot
code paths.

Most of the design changes where motivated by a patch
aili@codeaurora.org sent me, and I spent some time cleaning up the API.

Also, I couldn't resist myself in renaming the API's a bit given the fact
that the signatures changed enough that I had to touch all the pm_qos
users anyway.  I changed *requirement* to *request* in keeping with the
way PM_QOS really only does best effort.  I've felt "requirement" is too
strong a word for the way it works.

If folks would rather me do the function re-naming in a separate patch
set we can do that too.

diffstat for the series against linux-next-20091204 :
 drivers/acpi/processor_idle.c          |    2
 drivers/cpuidle/governors/ladder.c     |    2
 drivers/cpuidle/governors/menu.c       |    2
 drivers/net/e1000e/netdev.c            |   22 ++-
 drivers/net/igbvf/netdev.c             |    6 -
 drivers/net/wireless/ipw2x00/ipw2100.c |   11 +
 include/linux/netdevice.h              |    4
 include/linux/pm_qos_params.h          |   14 +-
 include/sound/pcm.h                    |    3
 kernel/pm_qos_params.c                 |  188 ++++++++++++++-------------------
 net/mac80211/mlme.c                    |    2
 sound/core/pcm.c                       |    3
 sound/core/pcm_native.c                |   14 +-
 13 files changed, 132 insertions(+), 141 deletions(-)

--mgross


------------------------------------------------------------------------------
Join us December 9, 2009 for the Red Hat Virtual Experience,
a free event focused on virtualization and cloud computing. 
Attend in-depth sessions from your desk. Your couch. Anywhere.
http://p.sf.net/sfu/redhat-sfdev2dev
