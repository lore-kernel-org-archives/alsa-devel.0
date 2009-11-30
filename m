From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH V2] Add i.MX sound support
Date: Mon, 30 Nov 2009 13:43:05 +0100
Message-ID: <20091130124305.GQ27548@pengutronix.de>
References: <1259163666-30344-1-git-send-email-s.hauer@pengutronix.de>
	<eedb5540911260753u369d6cffp97c05089cdd30868@mail.gmail.com>
	<20091127075834.GG27548@pengutronix.de>
	<eedb5540911270101o4bf06b2ct6ff22e29b7c1fe15@mail.gmail.com>
	<20091127095416.GK27548@pengutronix.de>
	<eedb5540911300243t20ecf407o317b414720cf962e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id D6970103816
	for <alsa-devel@alsa-project.org>; Mon, 30 Nov 2009 13:43:06 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <eedb5540911300243t20ecf407o317b414720cf962e@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: javier Martin <javier.martin@vista-silicon.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 30, 2009 at 11:43:23AM +0100, javier Martin wrote:
> Hi Sascha,
> have you tested capture direction on an i.MX27 based board?
> 
> I have been testing your patches in the place you suggested and playback
> seems to work fine but I have several problems with capture stream. I found
> a BUG in the audmux_v1 code
> and I have fixed it but I am still having problems with capture. The file
> keeps empty and nothing is recorded.

Capture works fine on my boards.

> 
> Please could you try the following on an i.MX27 based board?
> 
> arecord -t raw -c 1 -f S16_LE test.wav

Does it work with two channels? Do you use DMA or FIQ? Could you try the
other variant?

It helped me a lot during development to use a tool like memedit
(http://www.pengutronix.de/software/memedit/index_en.html) to show a
register dump of the SSI/Audmux units of a working setup and a non
working setup. Usually the differences showed quite fast why one was
working and the other was not.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
