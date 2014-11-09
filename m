From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PATCH v2 0/2] Fix some 'const' problems
Date: Sun, 9 Nov 2014 20:40:21 +0100
Message-ID: <cover.1415562021.git.moinejf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
 by alsa0.perex.cz (Postfix) with ESMTP id 5AEAC260550
 for <alsa-devel@alsa-project.org>; Sun,  9 Nov 2014 20:47:02 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Russell King <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

A cast was often needed to call some OF functions, removing
a 'const' attribute.
This patchset removes 'const' from the device_node pointers of the
sound/soc structures and also removes some useless casts
in the sound/soc tree.

v2: remove const from the pointers instead of modifying the
    OF functions (Russell King)

Jean-Francois Moine (2):
  ASoC: Remove 'const' from the device_node pointers
  ASoC: simple-card: Remove useless casts

 include/sound/soc.h                   | 6 +++---
 sound/soc/generic/simple-card.c       | 7 ++-----
 sound/soc/samsung/odroidx2_max98090.c | 4 ++--
 sound/soc/ux500/mop500.c              | 6 ++----
 4 files changed, 9 insertions(+), 14 deletions(-)

-- 
2.1.3
