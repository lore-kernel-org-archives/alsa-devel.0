From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: WM8993: amp control, amplifying pops.
Date: Mon, 10 May 2010 11:24:23 +0100
Message-ID: <20100510102422.GD31804@rakim.wolfsonmicro.main>
References: <v2jcf7b913c1005091910hf7b32843sc71b09b801b8649e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A0D91103820
	for <alsa-devel@alsa-project.org>;
	Mon, 10 May 2010 12:24:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <v2jcf7b913c1005091910hf7b32843sc71b09b801b8649e@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Zhang JieJing <kzjeef@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, May 10, 2010 at 10:10:53AM +0800, Zhang JieJing wrote:

> I have a question about WM8993 codec's amplifying pops control.

Could you please be more specific about what you mean when you say
"amplifying pops control"?  What exactly is an "amplifying pop" (do you
mean that you hear an unwanted noise, or is there something else)?

Please ensure that you are using the latest version of the WM8993 driver
(including wm_hubs.c) to make sure that you have all the latest bug
fixes and enhancements.  If you are not using single ended line outputs
from the device you should also mark the line outputs as being in
differential mode for maximum power savings.

> Our board using a WM8993 codec, and I We have problem about ampifying pops,
> when the system resume, We will heard a ampifying pop, (but it's silence on
> the suspend processing), We also noticed that when system boot, also can
> hear one ampifying pop.

System resume and power up are identical from the point of view of the
CODEC driver.

> From I know, the WM8993's codec have a internal amplifier, I don't know how
> to control this amplifier.

The WM8993 has a large number of amplifiers, there are many audio paths
in the device and most of them have some amplification control.  Which
outputs are you concerned about?
