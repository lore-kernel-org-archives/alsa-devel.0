From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH] ASoC: Add dependency on X86 for Intel MID
	drivers
Date: Mon, 17 Jan 2011 10:15:30 +0000
Message-ID: <20110117101530.49b716a4@bob.linux.org.uk>
References: <1295096518-15779-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<438BB0150E931F4B9CE701519A44630108446725A3@bgsmsx502.gar.corp.intel.com>
	<20110115132842.GA3042@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 79E82103804
	for <alsa-devel@alsa-project.org>; Mon, 17 Jan 2011 11:41:07 +0100 (CET)
In-Reply-To: <20110115132842.GA3042@opensource.wolfsonmicro.com>
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
Cc: "Koul, Vinod" <vinod.koul@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Harsha, Priya" <priya.harsha@intel.com>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sat, 15 Jan 2011 13:28:42 +0000
Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> On Sat, Jan 15, 2011 at 06:55:57PM +0530, Koul, Vinod wrote:
> 
> > X86 specifies generic x86 devices, pc's netbooks.....
> > The MID class of devices are quite different, so IMO it should
> > rather depend on X86_MRST which is for MID devices.
> 
> > CC Alan:
> > Alan would X86_MRST be apt or any other option for MID drivers vs
> > X86?

That depends what it needs - you want to specify the minimum needed to
make it buildable really, which is probably INTEL_SCU_IPC in this case
- you use the IPC I/O so you need the IPC, and the rest follows.
