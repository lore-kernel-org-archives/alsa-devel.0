From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: [RFC PATCH 0/3] Fixes for component unregister and
	remove
Date: Thu,  4 Apr 2019 17:30:37 -0700
Message-ID: <20190405003040.8709-1-ranjani.sridharan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3E162F8075B
 for <alsa-devel@alsa-project.org>; Fri,  5 Apr 2019 02:30:44 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, broonie@kernel.org, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

This set of patches aims to fix the problems seen during
module unloading with the skylake driver and also with SOF.
The sequence seen during snd_soc_skl module unload is that the
machine driver in unregistered first which frees the snd_card.
When the component driver is unregistered following this
and the topology is unloaded, a null pointer dereference
is encountered while removing the kcontrols because the snd_card
has already been freed.

The first 2 patches fix this by removing the topology unloading
from component_unregister() and moving it to the component
remove() callback. This also makes the register_component()
and unregister_component() calls balanced.

But this still doesnt solve the problem entirely because
the component driver's remove() callback is invoked
after soc_cleanup_card_resources() which frees the snd_card.
And we encounter the same null pointer dereference seen
while remving the kcontrols added to the snd_card.

In order to avoid this problem, the third patch proposes to
remove the link components in snd_soc_unbind_card() before
soc_cleanup_card_resources(). This way, the snd_card()
will remain valid when the topology is unloaded.

Ranjani Sridharan (3):
  ASoC: core: do not unload topology in unregister_component()
  ASoC: intel: skylake: add remove() callback for component driver
  ASoC: core: remove link components before cleaning up card resources

 sound/soc/intel/skylake/skl-pcm.c |  7 +++++++
 sound/soc/soc-core.c              | 13 +++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

-- 
2.17.1
