From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 0/3] constify snd_soc_dai_ops structures
Date: Sat, 27 Oct 2018 15:34:41 +0200
Message-ID: <1540647284-26728-1-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B67D2679FD
 for <alsa-devel@alsa-project.org>; Sat, 27 Oct 2018 16:10:03 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The snd_soc_dai_ops structures are only stored in the ops field of a
snd_soc_dai_driver structure, so make the snd_soc_dai_ops structures
const as well.

Done with the help of Coccinelle.

---

 drivers/soundwire/intel.c        |    4 ++--
 sound/soc/codecs/ak4458.c        |    2 +-
 sound/soc/codecs/ak5558.c        |    2 +-
 sound/soc/codecs/hdac_hda.c      |    2 +-
 sound/soc/codecs/tas6424.c       |    2 +-
 sound/soc/qcom/qdsp6/q6afe-dai.c |    8 ++++----
 6 files changed, 10 insertions(+), 10 deletions(-)
