From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: registering multiple cards
Date: Tue, 11 Jan 2011 11:28:24 +0000
Message-ID: <20110111112824.GB13429@opensource.wolfsonmicro.com>
References: <438BB0150E931F4B9CE701519A44630108443A6D8B@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 290E91039F8
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 12:30:28 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <438BB0150E931F4B9CE701519A44630108443A6D8B@bgsmsx502.gar.corp.intel.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Bensaid,
	Selma" <selma.bensaid@intel.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 11, 2011 at 04:57:14PM +0530, Koul, Vinod wrote:

> Currently snd_soc_register_card is internal soc-core API and is called from 
> soc-probe. And probe always assumes it is a single device, so how do we add
> up two cards?

> I saw a note on this that it will exposed so that drivers can register. 
> What is that plan to do that, and meanwhile what can be done to solve this?


Just register two soc-audio devices.  Calling register_card() directly
will just make the API a bit nicer, it shouldn't add any new features.
