From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH v2 0/2] ASoC: Intel: IPC framework updates
Date: Tue, 23 Jul 2019 16:43:39 +0200
Message-ID: <20190723144341.21339-1-cezary.rojewski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7BA2CF800E8
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2019 16:44:01 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: lgirdwood@gmail.com, Cezary Rojewski <cezary.rojewski@intel.com>, broonie@kernel.org, tiwai@suse.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Existing IPC framework omits crucial part of the entire communication:
reply header. Some IPCs cannot function at all without the access to
said header. Update the sst-ipc with new sst_ipc_message structure to
represent both request and reply allowing reply-processing handlers to
save received responses.

Despite the range of changes required for model to be updated, no
functional changes are made for core hanswell, baytrail and skylake
message handlers. Reply-processing handlers now save received response
header yet no usage is added by default.

To allow for future changes, righful kings of IPC kingdom need to be put
back on the throne. This update addresses one of them: LARGE_CONFIG_GET.

Changes since v1:
- Combined first four patches into single one
- Rebased onto v5.4

Cezary Rojewski (2):
  ASoC: Intel: Update request-reply IPC model
  ASoC: Intel: Skylake: large_config_get overhaul

 sound/soc/intel/baytrail/sst-baytrail-ipc.c |  65 ++++----
 sound/soc/intel/common/sst-ipc.c            |  69 ++++----
 sound/soc/intel/common/sst-ipc.h            |  27 ++--
 sound/soc/intel/haswell/sst-haswell-ipc.c   | 164 +++++++++++---------
 sound/soc/intel/skylake/cnl-sst.c           |   6 +-
 sound/soc/intel/skylake/skl-messages.c      |   3 +-
 sound/soc/intel/skylake/skl-sst-ipc.c       | 152 ++++++++++--------
 sound/soc/intel/skylake/skl-sst-ipc.h       |   3 +-
 8 files changed, 260 insertions(+), 229 deletions(-)

-- 
2.17.1
