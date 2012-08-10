From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Error with "Unsigned 8 bit, Rate 8000 Hz,
	Mono" track
Date: Fri, 10 Aug 2012 12:31:09 +0100
Message-ID: <20120810113109.GI24328@opensource.wolfsonmicro.com>
References: <CAOMZO5Dc38HSZRXFeZ-55KN83v1NNPCAAuoiFdixJ0K2dw90vg@mail.gmail.com>
 <20120810110004.GA7142@shlinux2.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 17372266520
 for <alsa-devel@alsa-project.org>; Fri, 10 Aug 2012 13:01:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20120810110004.GA7142@shlinux2.ap.freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dong Aisheng <b29396@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Shawn Guo <shawn.guo@linaro.org>, Fabio Estevam <festevam@gmail.com>, Lauri Hintsala <lauri.hintsala@bluegiga.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 10, 2012 at 07:00:05PM +0800, Dong Aisheng wrote:

> Since sgtl5000 on slave mode, the mclk can only be 256*fs, 384*fs, 512*fs,
> the maximum mclk of 8Khz 4096000(512 * 8000) < 8Mhz, it does not meet
> the minimum clock requirement of mclk.
> It looks like hw limitation on slave mode.

> Will spend some time double check if any solution for this later.
> If anyone else know it, please share the comments.

The CODEC driver ought to be setting a constraint for this if there's no
way it can support 8kHz in slave mode.
