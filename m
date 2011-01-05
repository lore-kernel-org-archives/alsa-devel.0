From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: question on SND_SOC_DAPM_MUX
Date: Wed, 5 Jan 2011 13:43:53 +0000
Message-ID: <20110105134352.GA746@opensource.wolfsonmicro.com>
References: <438BB0150E931F4B9CE701519A44630104C119C00F@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 74A0D103962
	for <alsa-devel@alsa-project.org>; Wed,  5 Jan 2011 14:45:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <438BB0150E931F4B9CE701519A44630104C119C00F@bgsmsx502.gar.corp.intel.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 05, 2011 at 07:08:51PM +0530, Koul, Vinod wrote:

> Is this the right way to go about adding a mux selection?

It looks plausible.  Have you tried looking at the code that generates
the error and seeing what caused it to do so?
