From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: Add dependency on X86 for Intel MID
	drivers
Date: Tue, 18 Jan 2011 19:00:46 +0530
Message-ID: <438BB0150E931F4B9CE701519A446301084470B536@bgsmsx502.gar.corp.intel.com>
References: <1295096518-15779-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<438BB0150E931F4B9CE701519A44630108446725A3@bgsmsx502.gar.corp.intel.com>
	<20110115132842.GA3042@opensource.wolfsonmicro.com>
	<20110117101530.49b716a4@bob.linux.org.uk>
	<20110118132148.GI26498@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id E169D103831
	for <alsa-devel@alsa-project.org>; Tue, 18 Jan 2011 14:31:05 +0100 (CET)
In-Reply-To: <20110118132148.GI26498@opensource.wolfsonmicro.com>
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
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Alan Cox <alan@linux.intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Harsha,
	Priya" <priya.harsha@intel.com>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

> > That depends what it needs - you want to specify the minimum needed to
> > make it buildable really, which is probably INTEL_SCU_IPC in this case
> > - you use the IPC I/O so you need the IPC, and the rest follows.
> 
> Ping?  I don't care what dependency is most appropriate but clearly
> there's no way this should be showing up on things that aren't even
> x86.
I will send the patch now, sorry been little tied up with few other stuff

~Vinod
