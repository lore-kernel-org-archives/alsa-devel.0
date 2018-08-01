From: Colin King <colin.king@canonical.com>
Subject: [PATCH 0/9] ALSA: remove redundant variables
Date: Wed,  1 Aug 2018 11:47:33 +0100
Message-ID: <20180801104742.4328-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D51E2677CE
 for <alsa-devel@alsa-project.org>; Wed,  1 Aug 2018 12:47:49 +0200 (CEST)
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

Clean up code by removing redundant variables that were
detected by clang

Colin Ian King (9):
  ALSA: asihpi: remove redundant variable max_streams
  ALSA: cs5535audio: remove redundant pointer 'dma'
  ALSA: emu10k1: remove redundant variable attn
  ALSA: ens137x: remove redundant array pcm_devs
  ALSA: sonicvibes: remove redundant pointer 'dir'
  ASoC: nau8540: remove redundant variable osrate
  ASoC: stm32: remove redundant pointers 'priv' and 'rtd'
  ALSA: usb-audio: remove redundant pointer 'urb'
  ALSA: intel_hdmi: remove redundant variable cfg_val

 sound/pci/asihpi/hpi6205.c          | 5 -----
 sound/pci/cs5535audio/cs5535audio.c | 7 +------
 sound/pci/emu10k1/emupcm.c          | 3 +--
 sound/pci/ens1370.c                 | 3 +--
 sound/pci/sonicvibes.c              | 2 --
 sound/soc/codecs/nau8540.c          | 3 ---
 sound/soc/stm/stm32_adfsdm.c        | 8 +-------
 sound/usb/endpoint.c                | 2 --
 sound/x86/intel_hdmi_audio.c        | 2 --
 9 files changed, 4 insertions(+), 31 deletions(-)

-- 
2.17.1
