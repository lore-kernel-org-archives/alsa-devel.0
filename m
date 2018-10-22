From: Olivier Moysan <olivier.moysan@st.com>
Subject: [PATCH 0/2] ASoC: stm32: sai: fix kbuild errors
Date: Mon, 22 Oct 2018 17:10:44 +0200
Message-ID: <1540221046-11812-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B5972677E4
 for <alsa-devel@alsa-project.org>; Mon, 22 Oct 2018 17:10:50 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org, olivier.moysan@st.com, arnaud.pouliquen@st.com, benjamin.gaignard@st.com
List-Id: alsa-devel@alsa-project.org

These patches fix following compilation errors:
- >> sound/soc/stm/stm32_sai_sub.c:260:16: error: field 'hw' has incomplete type
- >> sound/soc/stm/stm32_sai_sub.c:412:3: 
     warning: 'strncat' specified bound 6 equals source length [-Wstringop-overflow=]

Olivier Moysan (2):
  ASoC: stm32: add clock dependency for sai
  ASoC: stm32: sai: fix master clock naming

 sound/soc/stm/Kconfig         | 1 +
 sound/soc/stm/stm32_sai_sub.c | 5 ++---
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.7.4
