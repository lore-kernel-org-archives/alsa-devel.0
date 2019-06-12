From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 0/3] ASoC: SOF: fix suspend ordering with
	runtime idle
Date: Wed, 12 Jun 2019 09:46:24 -0500
Message-ID: <ba5e42ab-7f1e-01b9-835d-52a1e42a0fe0@linux.intel.com>
References: <20190612094452.1060-1-kai.vehmanen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9ED24F80791
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2019 16:46:32 +0200 (CEST)
In-Reply-To: <20190612094452.1060-1-kai.vehmanen@linux.intel.com>
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
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>, alsa-devel@alsa-project.org, broonie@kernel.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

[Cc: Takashi]

On 6/12/19 4:44 AM, Kai Vehmanen wrote:
> Hi all,
> this series addresses issues with ordering of HDA codec and controller
> suspends in the runtime PM flows. The implemented logic for SOF is
> similar to what has been used by the Intel AZX HDA driver.
> 
> To implement this, first a fix is needed to hdac_hdmic ASoC codec
> driver. SOF framework also needs to be extended to allow SOF devices
> to implement a runtime_idle callback. Third, concrete implementation
> is in a separate patch for APL/CNL Intel hardware, for which strict
> ordering of codec-controller power down sequence needs to be
> maintained.

Looks good to me
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

but of course we'd want feedback from Takashi and other folks more 
familiar with the HDaudio history. There will be additional patches in 
the coming days where we are catching up with issues that were fixed in 
the legacy driver but either missed or not known to the SOF developers.

> 
> As this extends the SOF device interface, Pierre asked me to
> send to the list for wider review. This series has been prereviewd
> at SOF github as:
> https://github.com/thesofproject/linux/pull/1003

Indeed we want the SOF core changes and dependencies (topology and 
hdaudio typically) to be reviewed on the alsa-devel mailing list. For 
Intel-specific fixes we still want to use GitHub and provide patches 
when we've hit a decent level of validation on prototype and production 
hardware, otherwise we'll increase the traffic on this list for no good 
reason.

> Kai Vehmanen (3):
>    ASoC: hdac_hdmi: report codec link up/down status to bus
>    ASoC: SOF: add runtime idle callback
>    ASoC: SOF: Intel: implement runtime idle for CNL/APL
> 
>   sound/soc/codecs/hdac_hdmi.c  |  2 ++
>   sound/soc/sof/intel/apl.c     |  1 +
>   sound/soc/sof/intel/cnl.c     |  1 +
>   sound/soc/sof/intel/hda-dsp.c | 13 +++++++++++++
>   sound/soc/sof/intel/hda.h     |  1 +
>   sound/soc/sof/pm.c            |  8 ++++++++
>   sound/soc/sof/sof-acpi-dev.c  |  2 +-
>   sound/soc/sof/sof-pci-dev.c   |  2 +-
>   sound/soc/sof/sof-priv.h      |  2 ++
>   9 files changed, 30 insertions(+), 2 deletions(-)
> 
