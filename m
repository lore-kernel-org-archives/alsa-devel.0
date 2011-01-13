From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: registering multiple cards
Date: Thu, 13 Jan 2011 12:15:42 +0530
Message-ID: <438BB0150E931F4B9CE701519A4463010844671D6B@bgsmsx502.gar.corp.intel.com>
References: <438BB0150E931F4B9CE701519A44630108443A6D8B@bgsmsx502.gar.corp.intel.com>
	<20110111112824.GB13429@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 030612433F
	for <alsa-devel@alsa-project.org>; Thu, 13 Jan 2011 07:46:16 +0100 (CET)
In-Reply-To: <20110111112824.GB13429@opensource.wolfsonmicro.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Bensaid,
	Selma" <selma.bensaid@intel.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

> > Currently snd_soc_register_card is internal soc-core API and is called from
> > soc-probe. And probe always assumes it is a single device, so how do we add
> > up two cards?
> 
> > I saw a note on this that it will exposed so that drivers can register.
> > What is that plan to do that, and meanwhile what can be done to solve this?
> 
> 
> Just register two soc-audio devices.  Calling register_card() directly
> will just make the API a bit nicer, it shouldn't add any new features.
Okay, I have tried to do that and sent the patch.
This keeps the existing method of registration "as is" while exposing API.
I was able to test this out on our driver in both ways.

Didn't add any code, just flipped things around.

~Vinod
