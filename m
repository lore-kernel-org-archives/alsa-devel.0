From: Moise Gergaud <moise.gergaud@st.com>
Subject: Re: [PATCH 0/3] ASoC: sti: correction for HBRA support
Date: Wed, 9 Dec 2015 09:27:34 +0100
Message-ID: <5667E5F6.3060603@st.com>
References: <1449066126-19431-1-git-send-email-moise.gergaud@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D4232604A9
 for <alsa-devel@alsa-project.org>; Wed,  9 Dec 2015 09:27:39 +0100 (CET)
In-Reply-To: <1449066126-19431-1-git-send-email-moise.gergaud@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: arnaud.pouliquen@st.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, tiwai@suse.de, rmk+kernel@arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

On 12/02/2015 03:22 PM, Moise Gergaud wrote:
> This patchset is V2 of "[PATCH 2/2] ASoC: sti: correction for HBRA support"
>
> Moise Gergaud (3):
>    ALSA: pcm: add IEC958 channel status update
>    ASoC: sti: use pcm iec958 channel status helper
>    ASoC: sti: correction for HBRA (High Bit Rate Audio) support
>
>   include/sound/pcm_iec958.h      | 19 ++++++++-
>   sound/core/pcm_iec958.c         | 78 +++++++++++++++++++++++++------------
>   sound/soc/sti/Kconfig           |  1 +
>   sound/soc/sti/uniperif_player.c | 86 +++++++++++++++++------------------------
>   4 files changed, 107 insertions(+), 77 deletions(-)
>

patchset abandoned
