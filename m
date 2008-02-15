From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Random inverted audio channels
Date: Fri, 15 Feb 2008 17:16:27 +0000
Message-ID: <20080215171627.GA13164@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1D825246A9
	for <alsa-devel@alsa-project.org>; Fri, 15 Feb 2008 18:16:29 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alexandre BOUIN <a.bouin@kerlink.fr>
Cc: alsa-devel@alsa-project.org, Frank Mandarino <fmandarino@endrelia.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 15, 2008 at 05:39:49PM +0100, Alexandre BOUIN wrote:

> This embedded project includes a AT91SAM9260 CPU and a WM8900 codec.

JOOI, is this the WM8900 driver in our dev branch or another one?  It
shouldn't make any difference either way what driver is used for the
codec, though, so long as it is generating the relevant clock signals.

> We have an issue : when we play a right channel stereo track, sound is
> played on right channel, but sometimes on left.
> This issue could happen right after starting kernel, or later after 10-20
> sounds played.
> With Frank Mandarino, we've checked any issue from SSC(audio bus) or PDC
> (dma) controlers, but no much success.

> Any idea to help us debugging this issue would be welcome !

The most likely issue here is a DMA underrun but from what you say you
may already have ruled that out?  It would be helpful if you could run
through the debugging you've already done here.

One thing to try if your design allows it would be to try making the
CPU the master.  That should reduce the number of variables, at least.
