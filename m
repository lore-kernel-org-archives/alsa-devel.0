From: Colin King <colin.king@canonical.com>
Subject: [PATCH 1/9] ALSA: asihpi: remove redundant variable
	max_streams
Date: Wed,  1 Aug 2018 11:47:34 +0100
Message-ID: <20180801104742.4328-2-colin.king@canonical.com>
References: <20180801104742.4328-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id AB66B267803
 for <alsa-devel@alsa-project.org>; Wed,  1 Aug 2018 12:47:49 +0200 (CEST)
In-Reply-To: <20180801104742.4328-1-colin.king@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Jaya Kumar <jayakumar.alsa@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Olivier Moysan <olivier.moysan@st.com>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

Variable max_streams is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
warning: variable 'max_streams' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/pci/asihpi/hpi6205.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/pci/asihpi/hpi6205.c b/sound/pci/asihpi/hpi6205.c
index 8d5abfa4e24b..2864698436a5 100644
--- a/sound/pci/asihpi/hpi6205.c
+++ b/sound/pci/asihpi/hpi6205.c
@@ -635,7 +635,6 @@ static u16 create_adapter_obj(struct hpi_adapter_obj *pao,
 	{
 		struct hpi_message hm;
 		struct hpi_response hr;
-		u32 max_streams;
 
 		HPI_DEBUG_LOG(VERBOSE, "init ADAPTER_GET_INFO\n");
 		memset(&hm, 0, sizeof(hm));
@@ -660,10 +659,6 @@ static u16 create_adapter_obj(struct hpi_adapter_obj *pao,
 		pao->type = hr.u.ax.info.adapter_type;
 		pao->index = hr.u.ax.info.adapter_index;
 
-		max_streams =
-			hr.u.ax.info.num_outstreams +
-			hr.u.ax.info.num_instreams;
-
 		HPI_DEBUG_LOG(VERBOSE,
 			"got adapter info type %x index %d serial %d\n",
 			hr.u.ax.info.adapter_type, hr.u.ax.info.adapter_index,
-- 
2.17.1
