From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 0/3] ASoC: hda: capture-related fixes
Date: Fri, 8 Mar 2019 09:27:37 -0600
Message-ID: <ce0aff16-b3a9-fb53-ea5e-8d6b69cd7cdf@linux.intel.com>
References: <20190308083859.50026-1-rander.wang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BD66DF8072E
 for <alsa-devel@alsa-project.org>; Fri,  8 Mar 2019 16:27:41 +0100 (CET)
In-Reply-To: <20190308083859.50026-1-rander.wang@linux.intel.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Rander Wang <rander.wang@linux.intel.com>, broonie@kernel.org
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On 3/8/19 2:38 AM, Rander Wang wrote:
> There are several sources of errors fixed in this series, such as mismatch
> between TX and RX mask used to store the stream_tag, the use of hw_param
> fixups not properly handled in the hdac_hda codec and registers set on capture
> when they should only be used on playback.
>
> The first patch fixes a issue caused by tx|rx_mask for TDM.
> The Second one fixes the mismatch between BE dai format and hda codec format.
> The last one removes the register of stream id setting on capture.
>
> this series was tested successfully with the Intel Skylake driver on a Skylake
> Dell XPS13 (same as Linus), KabyLake NUC, Whiskylake laptop and Apollolake LeafHill
> board. The two soc-pcm and hdac_hda fixes are needed by the SOF driver as well, but
> SOF-specific patches will be provided in the next batch and are not included here
>
> Rander Wang (3):
>    ASoC:soc-pcm:fix a codec fixup issue in TDM case
>    ASoC:hdac_hda:use correct format to setup hda codec
>    ASoC:intel:skl:fix a simultaneous playback & capture issue on hda platform

[adding Takashi who wasn't on CC: but is required for the HDaudio part]

I reviewed and tested this series so

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Note that this series supersedes an initial fix shared on February 25, which is now included as patch2 of this series.

>
>   sound/soc/codecs/hdac_hda.c       | 53 ++++++++++++++++++++++++++++-----------
>   sound/soc/codecs/hdac_hda.h       |  1 +
>   sound/soc/intel/skylake/skl-pcm.c | 19 ++++++++++----
>   sound/soc/soc-pcm.c               |  7 ++++--
>   4 files changed, 59 insertions(+), 21 deletions(-)
>
