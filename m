From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: [PATCH 0/3] ASoC: patch series to add support for
 capture in mid-x86 and sn95031 codec
Date: Fri, 28 Jan 2011 22:08:41 +0530
Message-ID: <98769532B4BB14429434178695419EAE08C0F3E93E@bgsmsx501.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 4B22224159
	for <alsa-devel@alsa-project.org>; Fri, 28 Jan 2011 17:38:48 +0100 (CET)
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

This patch set adds support for capture in mid-x6 platform, machine and TI
sn95031 codec drivers.

[PATCH 1/3] ASoC: sn95031: add capture support
	This patch adds support for capture codec dais and widgets 

[PATCH 2/3] ASoC: sst_platform: add support for capture stream on headset dai
 	This patch adds mid-x86 sst platform driver support for capture on
 	headset dai

[PATCH 3/3] ASoC: mid-x86: Add support for capture in machine driver
	This patch configures the capture unused pins

-Harsha
