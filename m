From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: [PATCH 0/3] add support for jack detection in mid-x86
Date: Wed,  9 Feb 2011 14:42:24 +0530
Message-ID: <1297242747-18632-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 09D8224334
	for <alsa-devel@alsa-project.org>; Wed,  9 Feb 2011 10:05:01 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

From: Vinod Koul <vinod.koul@intel.com>

This patch set adds support for jack detection in mid-x6 machine and TI sn95031
codec drivers. This also adds support to read mic bias values thru ADC 

The comments from previous submission are addressed and patches split
 
Vinod Koul (3):
  ASoC: sn95031: Add jack support in the codec
  ASoC: mfld_machine: Add support for jack detection
  ASoC: sn95031: Add support for reading mic bias

 sound/soc/codecs/sn95031.c       |  184 ++++++++++++++++++++++++++++++++-
 sound/soc/codecs/sn95031.h       |   35 ++++++
 sound/soc/mid-x86/mfld_machine.c |  211 +++++++++++++++++++++++++++++++++-----
 3 files changed, 399 insertions(+), 31 deletions(-)

-- 
1.7.2.3
