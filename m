From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: [PATCH 0/3] ASoC: add support for jack detection in
 mid-x86 and sn95031 codec
Date: Thu, 3 Feb 2011 16:40:06 +0530
Message-ID: <98769532B4BB14429434178695419EAE08C1031900@bgsmsx501.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 70BEA103813
	for <alsa-devel@alsa-project.org>; Thu,  3 Feb 2011 12:10:14 +0100 (CET)
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

This patch set adds support for jack detection in mid-x6 machine and TI sn95031
codec drivers. Also adds a helper function in soc-jack.c for converting mic bias
values to jack types.

The comments from previous submission are addressed.

[PATCH 1/3] ASoC: soc_jack - add function to add voltage zones and determine
jack type
	This patch adds a helper functions that adds the adc voltage zones and
	determines the jack type given the mic bias value.
	When a jack is created, the voltage zones can to be added to it. Later
	when a jack is inserted, the micbias voltage can be measured and used to
	find the jack type

[PATCH 2/3] ASoC: mid-x86 machine driver - add jack detect support
 	This patch adds the jack detection in mid-86 machine driver

[PATCH 3/3] ASoC: sn95031 codec - adding jack detection/reporting
	This patch adds the jack detection logic in sn95031 codec. This also
	adds code for reading the ADC to figure out the mic bias and therby
	report jack type detected

-Harsha
