From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Add dependency on X86 for Intel MID
	drivers
Date: Sat, 15 Jan 2011 13:28:42 +0000
Message-ID: <20110115132842.GA3042@opensource.wolfsonmicro.com>
References: <1295096518-15779-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<438BB0150E931F4B9CE701519A44630108446725A3@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4C6442445C
	for <alsa-devel@alsa-project.org>; Sat, 15 Jan 2011 14:28:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <438BB0150E931F4B9CE701519A44630108446725A3@bgsmsx502.gar.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Koul, Vinod" <vinod.koul@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Harsha,
	Priya" <priya.harsha@intel.com>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, Alan Cox <alan@linux.intel.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sat, Jan 15, 2011 at 06:55:57PM +0530, Koul, Vinod wrote:

> X86 specifies generic x86 devices, pc's netbooks.....
> The MID class of devices are quite different, so IMO it should rather depend
> on X86_MRST which is for MID devices.

> CC Alan:
> Alan would X86_MRST be apt or any other option for MID drivers vs X86?

Quite possibly, given that you hadn't specified any dependencies at all
I was going for something as inclusive as possible on x86 platforms.
Were this a normal embedded system on Linux the machine driver would
depend on the specific machine that's being supported.
