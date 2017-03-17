From: olivier moysan <olivier.moysan@st.com>
Subject: [RFC PATCH v2 0/2] master clock issues
Date: Fri, 17 Mar 2017 16:41:49 +0100
Message-ID: <1489765311-29857-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id D81012669D8
 for <alsa-devel@alsa-project.org>; Fri, 17 Mar 2017 16:41:55 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, olivier.moysan@st.com
Cc: arnaud.pouliquen@st.com
List-Id: alsa-devel@alsa-project.org

Hello,

I face two issues using wm8994 codec driver.
Below is a description of the use cases rising the problem.
I added the patches which allow to fix these issues.
These minimalist patches can be seen as a starting point for a discussion on the best
way to handle the use cases exposed.


- ASoC: wm8994: default master clock selection

Use case:
CPU DAI and codec are managed through simple card.
Wolson codec wm8994 is set as slave of CPU DAI and CPU DAI feeds codec with master clock.
Master clock is derived from mclk-fs property and provided to CPU DAI and codec 
through snd_soc_dai_set_sysclk API. 

Analysis:
The simple card assumes id 0 for master clock.
However wm8994 codec exposes master clock ids from 1 to 4. (MCLK1, MCLK2 ..)

The proposal in this patch is to define a default selection regarding master clock
when id 0 is provided.


- ASoC: wm8994: delay aifxclk activation

Use case:
Wolson codec wm8994 is set as slave of CPU DAI and CPU DAI feeds codec with master clock.
CPU DAI generates master clock when enabled in trigger callback.
So master clock is available only at runtime. 
Master clock is not available when configuring codec through alsa controls.

Analysis:
When we configure aifx clock while master clock is not active, related registers are not updated in wm8894 codec.
A way to go around this problem, is to delay aifxclk activation until SND_SOC_DAPM_POST_PMU DAPM stage.
The purpose of patch here is to illustrate this workaround. 

What I cannot clearly figure out, is  how this may impact other uses of wm8894 codec.
I try to know if it's worth investigating further in this direction or if it will not be applicable.
If not applicable, what maybe the other options ?

Changes in v2:
	Add change log on aifxclk delay patch.

regards
olivier

olivier moysan (2):
  ASoC: wm8994: default master clock selection
  ASoC: wm8994: delay aifxclk activation

 sound/soc/codecs/wm8994.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
1.9.1
