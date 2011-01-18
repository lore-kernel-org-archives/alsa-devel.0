From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Add dependency on X86 for Intel MID
	drivers
Date: Tue, 18 Jan 2011 13:21:48 +0000
Message-ID: <20110118132148.GI26498@opensource.wolfsonmicro.com>
References: <1295096518-15779-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<438BB0150E931F4B9CE701519A44630108446725A3@bgsmsx502.gar.corp.intel.com>
	<20110115132842.GA3042@opensource.wolfsonmicro.com>
	<20110117101530.49b716a4@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0E085103840
	for <alsa-devel@alsa-project.org>; Tue, 18 Jan 2011 14:21:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20110117101530.49b716a4@bob.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alan Cox <alan@linux.intel.com>
Cc: "Koul, Vinod" <vinod.koul@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Harsha, Priya" <priya.harsha@intel.com>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 17, 2011 at 10:15:30AM +0000, Alan Cox wrote:

> That depends what it needs - you want to specify the minimum needed to
> make it buildable really, which is probably INTEL_SCU_IPC in this case
> - you use the IPC I/O so you need the IPC, and the rest follows.

Ping?  I don't care what dependency is most appropriate but clearly
there's no way this should be showing up on things that aren't even
x86.
