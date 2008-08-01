From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 04/14] ASoC: Allow codecs to
	override	register display
Date: Fri, 1 Aug 2008 18:18:19 +0100
Message-ID: <20080801171818.GD11735@sirena.org.uk>
References: <9e4733910807311841v3ebe98f5i327606d7d793f832@mail.gmail.com>
	<s5hk5f1jcl7.wl%tiwai@suse.de>
	<20080801100003.GA16420@rakim.wolfsonmicro.main>
	<9e4733910808010750x69e71cd2i21eb0b448e11544a@mail.gmail.com>
	<s5hiquk4v4g.wl%tiwai@suse.de>
	<20080801153538.GA11735@sirena.org.uk>
	<s5hfxpo4twd.wl%tiwai@suse.de>
	<9e4733910808010913x46a4f57fm316b013984ac6b1c@mail.gmail.com>
	<20080801161613.GA2076@rakim.wolfsonmicro.main>
	<s5hd4ks4rrm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 6F431244EB
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Aug 2008 19:18:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hd4ks4rrm.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 01, 2008 at 06:35:57PM +0200, Takashi Iwai wrote:

> Hm, is display_register already used in asoc tree by any drivers?
> If so, then it's a step backward, and I understand your statement.

No, there are no users.  It was added purely due to Jon's request.

> OTOH, showing lots of meaningless registers is bad, too.

I agree - as I say, I do think supporting suppression of the display of
irrelevant/nonexistant registers would be a win.

> Looking back soc-core.c again, the primary problem is that
> codec_reg_show() assumes that the continuous register table beginning
> from 0.  It'd be much easier if the driver provides a complete show
> method by itself for non-standard cases, e.g. sparse registers
> (i.e. just pass buf and let fill the whole page).

There are two issues:

 - I don't like pushing the entire file format into the codec driver;
   it feels wrong since it increases the amount of non-shared code.

 - Doing that prevents reuse of any part of the information elsewhere.
   For example, if we were to display a register value anywhere else a
   different interface would be required to allow codecs to override the
   display there.

I know there are people who'd love to see things like more detailed
register/control mapping information.
