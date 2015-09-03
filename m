From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 0/2] Update v4 -> v5 for i915 -> HDA patch set
Date: Thu,  3 Sep 2015 11:51:33 +0200
Message-ID: <1441273895-31153-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 6217F26064F
 for <alsa-devel@alsa-project.org>; Thu,  3 Sep 2015 11:51:33 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Takashi mistakenly merged v4 instead of v5 of the patch set.
This updates the code changes. (Not the docbook, I'm still fighting
to get that to look right)

David Henningsson (2):
  drm/i915: Drop port_mst_index parameter from pin/eld callback
  drm/i915: Add locks around audio component bind/unbind

 drivers/gpu/drm/i915/intel_audio.c | 8 ++++++--
 include/drm/i915_component.h       | 3 +--
 2 files changed, 7 insertions(+), 4 deletions(-)

-- 
1.9.1
