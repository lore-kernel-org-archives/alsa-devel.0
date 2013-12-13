From: Nenghua Cao <nhcao@marvell.com>
Subject: [PATCH V1] ASOC:DAPM: extend dapm kcontrol to support
	runtime route update
Date: Fri, 13 Dec 2013 19:20:06 +0800
Message-ID: <1386933607-828-1-git-send-email-nhcao@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by alsa0.perex.cz (Postfix) with ESMTP id C4A912615E9
 for <alsa-devel@alsa-project.org>; Fri, 13 Dec 2013 12:14:31 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Yacine Belkadi <yacine.belkadi.1@gmail.com>, alsa-devel@alsa-project.org
Cc: Henry zhao <xzhao10@marvell.com>, Nenghua Cao <nhcao@marvell.com>, cxie4@marvell.com
List-Id: alsa-devel@alsa-project.org

From: Nenghua Cao <nhcao@marvell.com>

V1 -> V0:

     refined patch, and add flag into soc_mixer_control and soc_enum 
instead of the alsa core, according to Takashi's suggestion.

>You don't need to extend the ALSA core API for such a purpose.  It's
>ASoC-specific, so rather extend struct soc_mixer_control instead, if
>such a new flag is really needed.

nhcao (1):
  ASOC:DAPM: extend dapm kcontrol to support runtime route update

 include/sound/soc-dapm.h |   14 ++++++++++++++
 include/sound/soc.h      |   19 +++++++++++++++++++
 sound/soc/soc-dapm.c     |   28 ++++++++++++++++++++++++----
 3 files changed, 57 insertions(+), 4 deletions(-)
