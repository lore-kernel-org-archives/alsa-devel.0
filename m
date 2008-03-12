From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [regression] 2.6.25-rc4 snd-es18xx broken on Alpha
Date: Wed, 12 Mar 2008 20:34:36 +0100
Message-ID: <47D8304C.3090005@keyaccess.nl>
References: <20080312144021.3FE57DBA2@gherkin.frus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.groni1.gr.home.nl (smtpq1.groni1.gr.home.nl
	[213.51.130.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 9704010387E
	for <alsa-devel@alsa-project.org>; Wed, 12 Mar 2008 20:34:03 +0100 (CET)
In-Reply-To: <20080312144021.3FE57DBA2@gherkin.frus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Bob Tracy <rct@frus.com>
Cc: ALSA devel <alsa-devel@alsa-project.org>, Michael Cree <mcree@orcon.net.nz>, Krzysztof Helt <krzysztof.h1@wp.pl>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-alpha@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 12-03-08 15:40, Bob Tracy wrote:

> Well, I built a 2.6.22 kernel last night, and in tests this morning
> there's no difference relative to the ALSA behavior seen in 2.6.25-rc4.

Okay. If someone is tracking this as a 2.6.25 regresion, it can be stricken 
of that list.

> Since the question came up (or was strongly implied), I took the time to
> check the status of IRQ 5 in /proc/interrupts, and while it shows up as
> assigned to the sound card, no interrupts are being seen/processed by
> the es18xx driver.

That is indeed what it soundeed like, or the first bit at least.

> When I remove the snd-es18xx module and install the snd-sb8 module with
> the same parameters (other than there's no second DMA channel), the
> /proc/interrupts counter for IRQ 5 increments as expected when playing
> sound files.

What does cat /proc/config.gz | grep CONFIG_ALPHA_ say? Miuchael, and for 
you? For some Alpha configs, arch/alpha/kernel/es1888.c is compiled and for 
some not. I expect for you (Bob) it's compiled in? And Michael?

Rene.
