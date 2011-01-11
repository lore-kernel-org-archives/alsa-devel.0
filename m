From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: registering multiple cards
Date: Tue, 11 Jan 2011 16:57:14 +0530
Message-ID: <438BB0150E931F4B9CE701519A44630108443A6D8B@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 116F3245CF
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 12:28:20 +0100 (CET)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, "Bensaid,
	Selma" <selma.bensaid@intel.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hi,

Currently snd_soc_register_card is internal soc-core API and is called from 
soc-probe. And probe always assumes it is a single device, so how do we add
up two cards?

I saw a note on this that it will exposed so that drivers can register. 
What is that plan to do that, and meanwhile what can be done to solve this?

~Vinod
