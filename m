From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [Pull request] Support for wm9705 codec and two
	machines that use it.
Date: Thu, 15 Jan 2009 22:22:33 +0000
Message-ID: <20090115222228.GA8806@sirena.org.uk>
References: <496E8DD0.4090006@mnementh.co.uk> <s5hfxjl3v6s.wl%tiwai@suse.de>
	<496F0ABD.4080207@mnementh.co.uk>
	<20090115172057.GC12768@sirena.org.uk>
	<496FB5AA.1030205@mnementh.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id EDE221038AC
	for <alsa-devel@alsa-project.org>; Thu, 15 Jan 2009 23:22:35 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <496FB5AA.1030205@mnementh.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ian Molton <ian@mnementh.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 15, 2009 at 10:16:10PM +0000, Ian Molton wrote:
> Mark Brown wrote:

> >>+	soc_ac97_ops.reset(codec->ac97);

> >This should check the return value, resets can and do fail.

> This call returns void. So no.

Oh, sorry - thinko.  You should read back the ID register and verify the
value.

> I cant see a way to determine the outcome of a reset on wm9705. I could 
> program a register, then check to see it is set to its reset value, but 
> if the codec is hung, this could cause lockups.

It shouldn't, the AC97 bus driver should time out.  The goal is to make
sure that the codec is live and the expected device.
