From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v5] sound/soc/lapis: add platform driver
	for ML7213
Date: Thu, 24 May 2012 11:07:42 +0100
Message-ID: <20120524100742.GH5361@opensource.wolfsonmicro.com>
References: <1331275160-31757-1-git-send-email-tomoya.rohm@gmail.com>
	<1332158459-14880-1-git-send-email-tomoya.rohm@gmail.com>
	<20120321160913.GF3226@opensource.wolfsonmicro.com>
	<CANKRQnjoGN=uvej8B1BxPHAx7NQtOORD9yJRPUc134DrVmPzNg@mail.gmail.com>
	<20120326154009.GA17506@sirena.org.uk>
	<CANKRQnhn=ALR0ucv5gnvwnxwxBQX4ajm9Jo5qC0fL-EFjDdoZg@mail.gmail.com>
	<20120523093857.GC4085@opensource.wolfsonmicro.com>
	<CANKRQnhNWC2F6zKgBMJY7HnipJbA5p-=6Lz4uGZqBKNQ688Z3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 753EE2441B
	for <alsa-devel@alsa-project.org>;
	Thu, 24 May 2012 12:07:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CANKRQnhNWC2F6zKgBMJY7HnipJbA5p-=6Lz4uGZqBKNQ688Z3w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, May 24, 2012 at 08:46:03AM +0900, Tomoya MORINAGA wrote:
> On Wed, May 23, 2012 at 6:41 PM, Mark Brown

> > Nobody seems to be working on it as far as I can tell, I've certainly
> > not seen any patches.

> If so, could you accept current platform/machine driver ?

Ideally what would be happening here is that you or other people who
have such systems would be working to add the required support to the
core code, there's clearly a need for common code here as there are a
number of different systems that don't have cyclic DMA and it wouldn't
be great to end up with duplicated code.

Is there some great difficulty in factoring out the support for
non-cyclic audio DMA on dmaengine - it seems like if there is we must
have a serious problem in dmaengine which we should fix?  If there is a
substantial difficulty then that's different but it doesn't feel like
we've tried doing common code yet, if there's problems doing that I'd
like to understand what they are before we jump ahead of ourselves.
