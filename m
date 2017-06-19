From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 0/2] ALSA: add const to snd_ratnum structures
Date: Tue, 20 Jun 2017 00:11:52 +0530
Message-ID: <1497897714-27522-1-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f68.google.com (mail-pg0-f68.google.com [74.125.83.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 30423267168
 for <alsa-devel@alsa-project.org>; Mon, 19 Jun 2017 20:43:49 +0200 (CEST)
Received: by mail-pg0-f68.google.com with SMTP id e187so8816499pgc.3
 for <alsa-devel@alsa-project.org>; Mon, 19 Jun 2017 11:43:49 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: julia.lawall@lip6.fr, clemens@ladisch.de, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

Declare snd_ratnum structures as const as their reference is only
stored in the rate field of a snd_pcm_hw_constraint_ratnums structure.
This field is of type const, so snd_ratnum structures can be made const.

Bhumika Goyal (2):
  ALSA: sound/isa: constify snd_ratnum structures
  ALSA: sound/pci: add const to snd_ratnum structures

 sound/isa/gus/gus_pcm.c | 2 +-
 sound/isa/sb/sb8_main.c | 2 +-
 sound/pci/bt87x.c       | 2 +-
 sound/pci/ens1370.c     | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.7.4
