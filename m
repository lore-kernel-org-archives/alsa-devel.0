From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: question on SND_SOC_DAPM_MUX
Date: Wed, 5 Jan 2011 21:40:42 +0530
Message-ID: <438BB0150E931F4B9CE701519A44630104C119C053@bgsmsx502.gar.corp.intel.com>
References: <438BB0150E931F4B9CE701519A44630104C119C00F@bgsmsx502.gar.corp.intel.com>
	<20110105134352.GA746@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 68B9624179
	for <alsa-devel@alsa-project.org>; Wed,  5 Jan 2011 17:10:56 +0100 (CET)
In-Reply-To: <20110105134352.GA746@opensource.wolfsonmicro.com>
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
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

> 
> > Is this the right way to go about adding a mux selection?
> 
> It looks plausible.  Have you tried looking at the code that generates
> the error and seeing what caused it to do so?
Looks like dapm_connect_mixer() is returning ENODEV
It is going there rightly as destination is a switch here

~Vinod
