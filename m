From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: introduce SOC_SINGLE_S8_TLV macro
Date: Mon, 9 Jan 2012 00:28:09 -0800
Message-ID: <20120109082808.GJ22134@opensource.wolfsonmicro.com>
References: <1325987606-7179-1-git-send-email-plai@codeaurora.org>
	<20120108202332.GE29065@opensource.wolfsonmicro.com>
	<4F0AA37F.5050602@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F058A1039AB
	for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2012 09:28:36 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4F0AA37F.5050602@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Patrick Lai <plai@codeaurora.org>, alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 09, 2012 at 09:21:19AM +0100, Lars-Peter Clausen wrote:
> On 01/08/2012 09:23 PM, Mark Brown wrote:

> > Since no shifts are specified the signature is just the same as your
> > SOC_SINGLE_S8_TLV:

> There is a shift, but it is hard coded to 8 in snd_soc_get_volsw_s8, which
> isn't considered by the patch currently. So either SOC_DOUBLE_S8_TLV should
> initialize rshift to 8 or a shift and rshift parameter should be added. It

The second option seems better here.

> might also makes sense to add a shift parameter to SOC_SINGLE_S8_TLV as well.

Probably.
