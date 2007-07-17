From: Hans-Christian Egtvedt <hcegtvedt@atmel.com>
Subject: Re: [PATCH 2/2] ALSA sound driver for
	the	AT73C213	DAC	using Atmel SSC driver
Date: Tue, 17 Jul 2007 13:23:31 +0200
Message-ID: <1184671411.12675.13.camel@localhost.localdomain>
References: <11845952993023-git-send-email-hcegtvedt@atmel.com>
	<11845952991232-git-send-email-hcegtvedt@atmel.com>
	<s5hwsx0xu7h.wl%tiwai@suse.de>
	<1184661441.12675.6.camel@localhost.localdomain>
	<20070717104859.34f76382@dhcp-255-175.norway.atmel.com>
	<1184662459.12675.8.camel@localhost.localdomain>
	<s5hvecjwcoz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay.atmel.no (nat-132.atmel.no [80.232.32.132])
	by alsa0.perex.cz (Postfix) with ESMTP id 8FE1710381B
	for <alsa-devel@alsa-project.org>;
	Tue, 17 Jul 2007 13:21:44 +0200 (CEST)
In-Reply-To: <s5hvecjwcoz.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, kernel@avr32linux.org, Haavard Skinnemoen <hskinnemoen@atmel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2007-07-17 at 12:23 +0200, Takashi Iwai wrote:
> At Tue, 17 Jul 2007 10:54:19 +0200,
> Hans-Christian Egtvedt wrote:
> > On Tue, 2007-07-17 at 10:48 +0200, Haavard Skinnemoen wrote:
> > > On Tue, 17 Jul 2007 10:37:21 +0200
> > > Hans-Christian Egtvedt <hcegtvedt@atmel.com> wrote:

<cut memory preallocation discussion>

> > New patch attached.
> 
> The patch looks fine, but I suppose it's a post-2.6.23 material,
> judging from the current situation.  Is it OK?

I guess post-2.6.23 is fine since it seems nobody is reacting to the
atmel-ssc driver, will bump it later today.

I will notify you if it seems like they will fit it for 2.6.23.

> Then I'll queue it soon after the merge window is closed, so that your
> driver appears in the mm tree.

Thanks.

-- 
With kind regards,

Hans-Christian Egtvedt, siv.ing. (M.Sc.)
Applications Engineer - AVR32 System Solutions - Atmel Norway
