From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [Pull request] Support for wm9705 codec and two
	machines that use it.
Date: Fri, 16 Jan 2009 11:21:53 +0000
Message-ID: <20090116112145.GA7554@sirena.org.uk>
References: <496E8DD0.4090006@mnementh.co.uk> <s5hfxjl3v6s.wl%tiwai@suse.de>
	<496F0ABD.4080207@mnementh.co.uk>
	<20090115172057.GC12768@sirena.org.uk>
	<496FB5AA.1030205@mnementh.co.uk>
	<20090115222228.GA8806@sirena.org.uk>
	<496FCDAC.70900@mnementh.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id A244E1038C8
	for <alsa-devel@alsa-project.org>; Fri, 16 Jan 2009 12:21:54 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <496FCDAC.70900@mnementh.co.uk>
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

On Thu, Jan 15, 2009 at 11:58:36PM +0000, Ian Molton wrote:

> Pushed out and available at:

> git://git.mnementh.co.uk/linux-2.6-im.git asoc

Err... that branch is based off the ASoC dev branch so can't be pulled
for mainline.  I've cherry picked the patches over since the conflicts
were trivial but if you are going to send pull requests please base
things for upstream off the ASoC branch of Takashi's repository at:

	git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git

As previously mentioned you really should post patches rather than just
pull requests (pull requests are fine but you should post the patches as
well) - it really is much easier to work with.
