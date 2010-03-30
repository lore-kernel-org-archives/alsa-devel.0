From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: mx31 snd and mc13783 codec status
Date: Tue, 30 Mar 2010 21:40:21 +0100
Message-ID: <20100330204021.GA4666@sirena.org.uk>
References: <4BB22576.1070108@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E92EF244DD
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Mar 2010 22:40:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4BB22576.1070108@epfl.ch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Valentin Longchamp <valentin.longchamp@epfl.ch>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, alsa-devel@alsa-project.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 30, 2010 at 06:23:18PM +0200, Valentin Longchamp wrote:

> I have quickly hacked something based on what you had done for
> pcm037 with the MC13783 codec in some of your first sound patches. I
> know that this is not ready for mainline and I'm still struggling to
> debug my code, but I would like to have results quite soon so that
> my colleague could see what sounds (especially regarding to the
> volume) our system is capable to produce.

If you're struggling to find time to do full support for the CODEC a
good technique is often to get just very basic fixed function support
(say just DAC to headphone support) implemented and merged, then go back
and implement

I'd also suggest looking at the current Freescale BSPs - obviously this
device is used on a lot of Freescale reference boards and I believe
there's a reasonably mainlineish driver in the BSPs they have for
current devices.
