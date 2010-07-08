From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: wm8776_dai vs. cs4270_dai
Date: Fri, 9 Jul 2010 08:49:09 +0900
Message-ID: <20100708234908.GB2253@opensource.wolfsonmicro.com>
References: <4C365860.9080205@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2CA351038D6
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Jul 2010 01:49:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4C365860.9080205@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 08, 2010 at 05:59:44PM -0500, Timur Tabi wrote:

> Should the CS4270 driver be changed to use two structures?

Depends on the hardware and how you feel.  In WM8776 there is
little visible connection in the digital domain between the DAC and ADC
sections of the device, even the MCLKs can be separate, which is why I
decided to split the DAIs.  If the same is true for the CS4270 then it
might be worth thinking about, but if they are more interconnected then
it doesn't make sense to do this.
