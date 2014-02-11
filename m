From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [PATCH 1/2] ASoC: fsl-spdif: big-endian support
Date: Tue, 11 Feb 2014 16:06:13 +0800
Message-ID: <20140211080612.GC18803@MrMyself>
References: <1392097276-14705-1-git-send-email-Li.Xiubo@freescale.com>
 <20140211071034.GA18803@MrMyself>
 <1a10273e564a4bb7a5aafe3f01ccffa2@BY2PR03MB505.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 by alsa0.perex.cz (Postfix) with ESMTP id F0B292616F4
 for <alsa-devel@alsa-project.org>; Tue, 11 Feb 2014 09:15:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1a10273e564a4bb7a5aafe3f01ccffa2@BY2PR03MB505.namprd03.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xiubo Li-B47053 <Li.Xiubo@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.de" <tiwai@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 11, 2014 at 03:39:44PM +0800, Xiubo Li-B47053 wrote:
> 
> 
> > > +   - big-endian : If this property is absent, the native endian mode will
> > > +   be in use as default, or the big endian mode will be in use for all the
> > > +   device registers.
> > > +
> > 
> > @Shawn
> > Does DT have an existing approach to determine if the current SoC this IP
> > uses is BE or LE? I am thinking the scenario that if all drivers support
> > BE/LE while the SoC is big-endian, all the nodes in the DT would have to
> > include a duplicated property (big-endian).
> > 
> 
> @Nicolin, @Shawn
> One special scenario likes the LS1 platform, the CPU and a few devices are in
> LE mode and other devices will be in BE mode.

Hmm... a bit strange to me. But I think it then should be fine here if it's
plausible as you describe.

Please revise the patch and send it to see if there's any comment from others.

And for both revised patches:
Acked-by: Nicolin Chen <Guangyu.Chen@freescale.com>

Thank you
