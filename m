From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH v2 0/13] topology support for alsa-lib
Date: Wed, 01 Jul 2015 14:45:16 +0100
Message-ID: <1435758316.29665.23.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 18931260654
 for <alsa-devel@alsa-project.org>; Wed,  1 Jul 2015 15:45:25 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, "Koul,
 Vinod" <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

This patch series adds the topology text parser support to alsa-lib. The
topology parser converts text topology data to the binary ABI format
read by the kernel topology core.

Changes since V1 :-

 o Terminate all strncpy() strings with NULL.
 o Use snd_pcm_format_value() instead of local lookup.
 o Set a maximum size for private data files.
 o Set capture/playback stream direction for new PCMs
 o Only set TLV access flags for TLV CTLs.

Liam
  
