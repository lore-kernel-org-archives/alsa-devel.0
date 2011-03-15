From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: codec power question
Date: Tue, 15 Mar 2011 15:10:23 +0530
Message-ID: <1300182023.1497.7.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id D26F5103803
	for <alsa-devel@alsa-project.org>; Tue, 15 Mar 2011 11:10:08 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa <alsa-devel@alsa-project.org>
Cc: Mark Brown <broonie@opensource.wolfsonmciro.com>, Liam <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org


Hi,

In some cases the audio stream is kept ON and idle by application. In
that case codec is also ON. Is there a mechanism where DAPM can detect
this idle condition and turn off the idle widgets or turn of the codec
BIAS

-- 
~Vinod
