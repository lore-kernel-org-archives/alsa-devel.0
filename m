From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Question about WM8974 codec driver--Incorrect
 setup of dapm_route
Date: Thu, 5 Aug 2010 17:41:43 +0100
Message-ID: <20100805164143.GA17501@opensource.wolfsonmicro.com>
References: <NBJJGLZNASKKARPOLZKJZXNGZJFU.jjinfo@nudt.edu.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EB7352456A
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Aug 2010 18:41:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <NBJJGLZNASKKARPOLZKJZXNGZJFU.jjinfo@nudt.edu.cn>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "jjinfo@nudt.edu.cn" <jjinfo@nudt.edu.cn>
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 05, 2010 at 11:16:18PM +0800, jjinfo@nudt.edu.cn wrote:

Please fix your mail client to word wrap text, it makes your mail vastly
more legible.  I've reflowed your text into 80 columns.

> Recently I've been working on porting alsa-driver-1.0.22 to support
> wm8974 codec with Freescale Mx27ipcam platform. By now the playback
> channel can work as expected. But the capture stream can't work and
> there is no data from the codec DAI interface.(Acutally, it is always
> low level.)

Please try a version of the driver from current kernel versions (you'll
probably need a little backporting).  I do not recommend using
alsa-driver for any embedded audio work, there are usually
interdependencies with CPU code in the CPU sides of the drivers.

> In the codec driver(wm8974.c), I note there is a potentioal problem
> with the audio route setup.In the definition of struct
> snd_soc_dapm_route audio_map[], the "Input PGA" is connected directly
> to "Boost Mixer" as follows: {

> "Boost Mixer"
> , NULL,
> "Input PGA"
> }, (Line 260).

> However, according to the wm8974 hardware manual, the connection
> between Input PGA and Boost Mixer IS controlled by a switch,
> INPPGAMUTE(R45[6]).

This looks like a potential issue, yes.  Have you tried testing?

> Another problem in wm8974.c, bit 6 of Register WM8974_INPPGA is
> defined as "Aux Switch"(line 191), and bit 2 of Register WM8974_INOUT
> is also defined as "Aux Switch"(line 196). Will these two same names
> cause any problem? (Since both the audio path from "Aux Input" to
> "Input PGA"(line 264) and the autio path from "Aux Input" to "Boost
> Mixer" use "Aux Switch", how can we distinguish from them?)

Without looking at the driver version you're using I'm not 100% certain
but I believe both of these are controls for mixers.  Mixers controls
have the name of the mixer prepended to thekm when presented to the API.
