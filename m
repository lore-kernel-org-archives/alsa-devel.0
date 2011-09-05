From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 2/3] ASoC: Allow codecs to provide their
	own regmap configuration
Date: Mon, 05 Sep 2011 19:43:22 +0200
Message-ID: <4E650A3A.5050807@metafoo.de>
References: <1315228682-1097-1-git-send-email-lars@metafoo.de>
	<1315228682-1097-2-git-send-email-lars@metafoo.de>
	<20110905172916.GG3889@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
	(mailhost.informatik.uni-hamburg.de [134.100.9.70])
	by alsa0.perex.cz (Postfix) with ESMTP id 980C6103877
	for <alsa-devel@alsa-project.org>;
	Mon,  5 Sep 2011 19:43:51 +0200 (CEST)
In-Reply-To: <20110905172916.GG3889@opensource.wolfsonmicro.com>
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
Cc: Scott Jiang <scott.jiang.linux@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org, uclinux-dist-devel@blackfin.uclinux.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 09/05/2011 07:29 PM, Mark Brown wrote:
> On Mon, Sep 05, 2011 at 03:18:01PM +0200, Lars-Peter Clausen wrote:
>> Currently a codec can either do the whole regmap initialization on its own or
>> provide only the register and value bit size and let the core handle
>> initialization. This patch allows a codec to provide a complete regmap
>> configuration while still letting ASoC core handle the regmap initialization
>> and setup.
> 
> I'd rather not do this, the only value is the copying of the word size
> setup out of the regmap config is to allow us to use the ASoC cache code
> but the idea is to push the cache down out of ASoC into the regmap code
> so this function should just be a trivial indirection for the regmap
> init which isn't useful.
> 

I think it is useful, since we avoid duplicating that ugly switch statement
and we also have to wrap regmap_write and regmap_read, duplicating that in each
codec driver doesn't make sense.
