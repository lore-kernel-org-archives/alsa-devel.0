From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: [PATCH 0/4] ASoC: patch series to add support for
 capture and jack sense in mid-x86 drivers
Date: Wed, 19 Jan 2011 18:22:01 +0530
Message-ID: <98769532B4BB14429434178695419EAE08C0D41CEB@bgsmsx501.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 901BA24469
	for <alsa-devel@alsa-project.org>; Wed, 19 Jan 2011 13:52:08 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "Koul, Vinod" <vinod.koul@intel.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "Harsha,
	Priya" <priya.harsha@intel.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

This patch set adds support for capture and jack sense in mid-x6 platform,
machine and TI sn95031 codec drivers.

[PATCH 1/4] ASoC: sn95031: add capture support
	This patch adds support for capture codec dais and widgets
[PATCH 2/4] ASoC: sst_platform: add support for capture stream on headset dai
 	This patch adds mid-x86 sst platform driver support for capture on
 	headset dai
[PATCH 3/4] ASoC: mid-x86: Add support for capture in machine driver
	This patch adds support for enabling capture in mfld machine driver
[PATCH 4/4] ASoC: mid-x86 add jack detect support
	This patch adds support for jack detection and reporting support in
	sn95031 codec and mfld_machine driver

-Harsha
