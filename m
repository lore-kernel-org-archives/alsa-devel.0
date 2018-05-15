From: Sriram Periyasamy <sriramx.periyasamy@intel.com>
Subject: [PATCH 0/4] ALSA: hda: Bug fixes
Date: Tue, 15 May 2018 12:10:52 +0530
Message-ID: <1526366456-20470-1-git-send-email-sriramx.periyasamy@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id E5416266F46
 for <alsa-devel@alsa-project.org>; Tue, 15 May 2018 08:51:18 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA ML <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Sriram Periyasamy <sriramx.periyasamy@intel.com>, Patches Audio <patches.audio@intel.com>
List-Id: alsa-devel@alsa-project.org

The series contains few bug fixes and debug updates

Pardha Saradhi K (4):
  ALSA: hda: Make sure DMA is stopped by reading back the RUN bit
  ALSA: hda: Make sure DMA is started by reading back the RUN bit
  ALSA: hda: Log HDA Hardware related errors
  ALSA: hda: check if stream is stopped in snd_hdac_stream_clear

 sound/hda/hdac_stream.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

-- 
2.7.4
