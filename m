From: Carlo Caione <carlo@caione.org>
Subject: [PATCH 0/2] rt5651: Enable platforms with int mic on
	IN2
Date: Wed, 18 Oct 2017 17:07:57 +0100
Message-ID: <20171018160759.18563-1-carlo@caione.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f66.google.com (mail-wm0-f66.google.com [74.125.82.66])
 by alsa0.perex.cz (Postfix) with ESMTP id A7292266EE0
 for <alsa-devel@alsa-project.org>; Wed, 18 Oct 2017 18:08:07 +0200 (CEST)
Received: by mail-wm0-f66.google.com with SMTP id l68so11117060wmd.5
 for <alsa-devel@alsa-project.org>; Wed, 18 Oct 2017 09:08:07 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux@endlessm.com, pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com, broonie@kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Carlo Caione <carlo@endlessm.com>
List-Id: alsa-devel@alsa-project.org

From: Carlo Caione <carlo@endlessm.com>

While working on enabling a cherry-trail laptop shipping the rt5651
codec I realized that the machine driver needed some fixup.

In particular the laptop I'm working on (KIANO SlimNote 14.2) has the
internal mic connected to the IN2 port.

All the laptop-specific work with the related quirks will follow.

Carlo Caione (2):
  ASoC: intel: byt: Enable quirk logic for custom maps
  ASoC: intel: byt: Introduce new custom IN2 map

 sound/soc/intel/boards/bytcr_rt5651.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

-- 
2.14.2
