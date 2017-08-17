From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 00/15] constify pnp_device_id and
	pnp_card_device_id
Date: Thu, 17 Aug 2017 15:36:15 +0530
Message-ID: <1502964390-6927-1-git-send-email-arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f66.google.com (mail-pg0-f66.google.com [74.125.83.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 7071B266DBE
 for <alsa-devel@alsa-project.org>; Thu, 17 Aug 2017 12:07:00 +0200 (CEST)
Received: by mail-pg0-f66.google.com with SMTP id t80so2984279pgb.2
 for <alsa-devel@alsa-project.org>; Thu, 17 Aug 2017 03:07:00 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, tiwai@suse.com, dhowells@redhat.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

*_device_id are not supposed to change at runtime. All functions
working with *_device_id provided by <linux/pnp.h> work with
const *_device_id. So mark the non-const structs as const.

Arvind Yadav (15):
  [PATCH 01/15] ALSA: drivers: mpu401: constify pnp_device_id
  [PATCH 02/15] ALSA: es18xx: constify pnp_device_id and pnp_card_device_id
  [PATCH 03/15] ALSA: opl3sa2: constify pnp_device_id and pnp_card_device_id
  [PATCH 04/15] ALSA: ad1816a: constify pnp_card_device_id
  [PATCH 05/15] ALSA: als100: constify pnp_card_device_id
  [PATCH 06/15] ALSA: azt2320: constify pnp_card_device_id
  [PATCH 07/15] ALSA: cmi8330: constify pnp_card_device_id
  [PATCH 08/15] ALSA: cs4236: constify pnp_card_device_id
  [PATCH 09/15] ALSA: es1688: constify pnp_card_device_id
  [PATCH 10/15] ALSA: gus: constify pnp_card_device_id
  [PATCH 11/15] ALSA: msnd: constify pnp_card_device_id
  [PATCH 12/15] ALSA: opti9xx: constify pnp_card_device_id
  [PATCH 13/15] ALSA: sb16: constify pnp_card_device_id
  [PATCH 14/15] ALSA: sscape: constify pnp_card_device_id
  [PATCH 15/15] ALSA: wavefront: constify pnp_card_device_id

 sound/drivers/mpu401/mpu401.c      | 2 +-
 sound/isa/ad1816a/ad1816a.c        | 2 +-
 sound/isa/als100.c                 | 2 +-
 sound/isa/azt2320.c                | 2 +-
 sound/isa/cmi8330.c                | 2 +-
 sound/isa/cs423x/cs4236.c          | 2 +-
 sound/isa/es1688/es1688.c          | 2 +-
 sound/isa/es18xx.c                 | 4 ++--
 sound/isa/gus/interwave.c          | 2 +-
 sound/isa/msnd/msnd_pinnacle.c     | 2 +-
 sound/isa/opl3sa2.c                | 4 ++--
 sound/isa/opti9xx/miro.c           | 2 +-
 sound/isa/opti9xx/opti92x-ad1848.c | 2 +-
 sound/isa/sb/sb16.c                | 2 +-
 sound/isa/sscape.c                 | 2 +-
 sound/isa/wavefront/wavefront.c    | 2 +-
 16 files changed, 18 insertions(+), 18 deletions(-)

-- 
2.7.4
