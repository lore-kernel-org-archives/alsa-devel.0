From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re:
 =?utf-8?q?=5BPATCH_v6_0/7=5D_Enable_HDA_Codec_suppor?=
 =?utf-8?q?t_on_Intel_Platforms=E2=80=8B?=
Date: Fri, 17 Aug 2018 15:34:49 -0500
Message-ID: <4d492312-c759-7f23-abe7-21e56795b338@linux.intel.com>
References: <20180816214653.11797-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id B129E2676C9
 for <alsa-devel@alsa-project.org>; Fri, 17 Aug 2018 22:34:54 +0200 (CEST)
In-Reply-To: <20180816214653.11797-1-pierre-louis.bossart@linux.intel.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

Please ignore this v6, I found an annoying issue with headless boards 
and will resend a v7.

Apologies for the noise.


On 08/16/2018 04:46 PM, Pierre-Louis Bossart wrote:
> Many Intel platforms (SKL, KBL) etc. in the market supports enhanced
> audio capabilities which also includes DSP processing. The default
> HDaudio legacy driver does not allow for the use of the DSP, this
> patch set makes it possible while reusing existing code for HDAudio
> codecs and without significant changes to the legacy driver.
>
> This v6 is based on Marks' for-next branch - the merge of
> topic/drm_audio_component is not included here.
>
> Tests were run successfully on multiple platforms (Dell XPS13, KBL
> NUC, APL NUC and LeafHill reference board). Both the HDaudio and HDMI
> outputs were tested.
>
> Credits: all the initial code was written by Rakesh Ughreja, the
> rebase to broonie/for-next, cleanups and additional tests were done by
> Pierre Bossart.
>
> TODO in future update:
> 1. fix the HDMI jack detection which only works after the mixer values
> are set, which isn't practical for headless devices always connected
> (this is a problem in the hdac_hdmi codec that was present before this
> series was submitted)
> 2. when the screen goes blank, HDMI playback stops. This isn't related
> to this patchset since we rely on the existing hdac_hdmi codec, but
> will need additional investigations.
>
> Changes v6 (comments from Mark and Takashi)
> - simplify Kconfig options, remove FORCE for now and make code simpler
> - change SPDIX style to C++ for C files
> - add log message if invalid configuration reached
> - remove static int counter, added private counter in context instead
> - fixed a couple of indendation issues to make checkpatch.pl --strict happy
>
> Changes v5 (comments from Vinod)
> - fix SPDIF style across patches
> - patch 1: update commit message to remove reference to "fix"
> - patch 3: remove platform name assignment and Xmas tree style
> - patch 7: simplify error handling, add missing _put() on errors,
>    	   remove tests on ops, add switch statement, fix alignment
> - patch 8: fix indentation issues, use bool instead of tristate
>
> Changes v4:
> - rebase/update on Takashi's topic/drm_audio_component branch
> - changes in the HDaudio detection to avoid adding a fake ACPI ID
> - new Kconfigs to control HDaudio detection
>
> Changes v3:
> - port to component model
> - additional tests on ApolloLake and KabyLake NUC devices
> - cleanups (alignment, typos, etc)
>
> Changes v2:
> - Resolved review comments and rebased to latest kernel.
> - added module load support for codec drivers.
>
> Pierre-Louis Bossart (2):
>    ASoC: Intel: common: add table for HDA-based platforms
>    ASoC: Intel: Skylake: add option to control HDAudio + DSP usage
>
> Rakesh Ughreja (5):
>    ASoC: Intel: Boards: Machine driver for SKL+ w/ HDAudio codecs
>    ASoC: Intel: Skylake: use HDAudio if ACPI enumeration fails
>    ASoC: Intel: Skylake: add HDA BE DAIs
>    ASoC: Intel: Skylake: use hda_bus instead of hdac_bus
>    ASoC: hdac_hda: add asoc extension for legacy HDA codec drivers
>
>   include/sound/soc-acpi-intel-match.h          |   6 +
>   sound/pci/hda/hda_bind.c                      |  12 +
>   sound/soc/codecs/Kconfig                      |   5 +
>   sound/soc/codecs/Makefile                     |   2 +
>   sound/soc/codecs/hdac_hda.c                   | 485 ++++++++++++++++++
>   sound/soc/codecs/hdac_hda.h                   |  24 +
>   sound/soc/intel/Kconfig                       |   9 +
>   sound/soc/intel/boards/Kconfig                |   9 +
>   sound/soc/intel/boards/Makefile               |   2 +
>   sound/soc/intel/boards/skl_hda_dsp_common.c   | 127 +++++
>   sound/soc/intel/boards/skl_hda_dsp_common.h   |  38 ++
>   sound/soc/intel/boards/skl_hda_dsp_generic.c  | 181 +++++++
>   sound/soc/intel/common/Makefile               |   3 +-
>   .../intel/common/soc-acpi-intel-hda-match.c   |  40 ++
>   sound/soc/intel/skylake/skl-pcm.c             |  70 ++-
>   sound/soc/intel/skylake/skl.c                 | 104 +++-
>   sound/soc/intel/skylake/skl.h                 |  12 +-
>   17 files changed, 1102 insertions(+), 27 deletions(-)
>   create mode 100644 sound/soc/codecs/hdac_hda.c
>   create mode 100644 sound/soc/codecs/hdac_hda.h
>   create mode 100644 sound/soc/intel/boards/skl_hda_dsp_common.c
>   create mode 100644 sound/soc/intel/boards/skl_hda_dsp_common.h
>   create mode 100644 sound/soc/intel/boards/skl_hda_dsp_generic.c
>   create mode 100644 sound/soc/intel/common/soc-acpi-intel-hda-match.c
>
