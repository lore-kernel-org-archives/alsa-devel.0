From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Problem setting mixer switch with amixer/alsactl.
Date: Tue, 28 Oct 2008 15:48:57 +0000
Message-ID: <20081028154856.GL9068@sirena.org.uk>
References: <48FF7538.3090000@oliford.co.uk>
	<20081023132705.GA20557@sirena.org.uk>
	<4900829A.8000703@oliford.co.uk>
	<20081023140116.GB17901@sirena.org.uk> <87mygvmci7.fsf@free.fr>
	<20081024172533.GA3328@sirena.org.uk> <87ej25ero2.fsf@free.fr>
	<20081028131031.GG9068@sirena.org.uk>
	<20081028153435.GK9068@sirena.org.uk>
	<s5hy708buc2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id CA784244C2
	for <alsa-devel@alsa-project.org>; Tue, 28 Oct 2008 16:48:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hy708buc2.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Robert Jarzmik <robert.jarzmik@free.fr>, Oliver Ford <ipaqlinux@oliford.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 28, 2008 at 04:41:33PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > Gah, sorry - it doesn't help, I was masking the problem another way.

> ... and I think soc-dapm should warn if the string is too long, at
> least, so that you can notice and fix them.

Well, with the patch supplied (which I intend to push anyway) ASoC won't
enforce any limit and will just pass the string onto the ALSA core -
probably best to warn in snd_ctl_new1().  I'll take a look.
