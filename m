From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC PATCH 1/1] ASoC: dsd1791: Introduce driver
 for TI DSD1791 stereo codec
Date: Fri, 16 Dec 2011 13:53:21 +0100
Message-ID: <20111216125320.GA2710@opensource.wolfsonmicro.com>
References: <1323906043-28408-1-git-send-email-michael.williamson@criticallink.com>
	<1323906043-28408-2-git-send-email-michael.williamson@criticallink.com>
	<20111215071621.GE24248@opensource.wolfsonmicro.com>
	<4EEA5956.1090208@criticallink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B3F4E10381A
	for <alsa-devel@alsa-project.org>; Fri, 16 Dec 2011 13:53:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4EEA5956.1090208@criticallink.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Michael Williamson <michael.williamson@criticallink.com>
Cc: alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 15, 2011 at 03:32:22PM -0500, Michael Williamson wrote:
> On 12/15/2011 2:16 AM, Mark Brown wrote:
> > On Wed, Dec 14, 2011 at 06:40:43PM -0500, Michael Williamson wrote:

> >> +static int dsd1791_set_sysclk(struct snd_soc_dai *codec_dai,
> >> +				int clk_id, unsigned int freq, int dir)

> > Implement this as a CODEC wide operation, it's simpler.

> Not sure I follow you here.  Are you meaning to create something to
> replace these lines (which are in many of the routines) with a local inline?

No, I mean implement your set_sysclk operation as a CODEC wide
operation.
