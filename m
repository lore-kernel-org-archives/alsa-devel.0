From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 7/12] wm8940: fix resource reclaim in
 wm8940_register error path
Date: Thu, 15 Jul 2010 09:59:16 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1007150952340.5310@axis700.grange>
References: <1279162147.29294.2.camel@mola> <1279162893.29294.20.camel@mola>
	<Pine.LNX.4.64.1007150855200.5310@axis700.grange>
	<AANLkTil_buBStfVy_L9iTgPrxosmSRFhNU1MbaXWJfMx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id B28571038A2
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Jul 2010 09:59:11 +0200 (CEST)
In-Reply-To: <AANLkTil_buBStfVy_L9iTgPrxosmSRFhNU1MbaXWJfMx@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, 15 Jul 2010, Axel Lin wrote:

> I agree that it is good to release resources at the same level,
> where they have been acquired.
> But I prefer to follow the maintainer/author's coding style.

Yeah, unless that "style" is a bug. IMHO this design is just buggy, 
unmaintainable, error-prone, and unjustified.

> 
> For the changes in other drivers, I'd like to see Liam and Mark's comments.
> Or if the driver maintainers request it, I can fix it.

Well, as the author of sound/soc/codecs/wm8978.c, I'd be happy if you 
change it in this way;) And also move the

	kfree(wm8978);

line from wm8978_unregister() to wm8978_i2c_remove().

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
