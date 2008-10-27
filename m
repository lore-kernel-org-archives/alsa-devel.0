From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Problem setting mixer switch with amixer/alsactl.
Date: Mon, 27 Oct 2008 20:44:41 +0000
Message-ID: <20081027204440.GA4135@sirena.org.uk>
References: <48FF7538.3090000@oliford.co.uk>
	<20081022205729.GD7537@sirena.org.uk>
	<48FFAFB1.1090106@oliford.co.uk>
	<20081023140015.GA17901@sirena.org.uk>
	<4900851D.2050001@oliford.co.uk> <490100C9.7030907@oliford.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 5585324400
	for <alsa-devel@alsa-project.org>; Mon, 27 Oct 2008 21:44:44 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <490100C9.7030907@oliford.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Oliver Ford <ipaqlinux@oliford.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 23, 2008 at 11:55:05PM +0100, Oliver Ford wrote:

> In terms of the control's direct effect, setting it in alsamixer gives:
> pxa2xx_ac97_write: 0c = af08

> setting it in amixer:
> pxa2xx_ac97_write: 0c = af09

On the one hand, that's odd.  On the other hand, the low bit of register
0xc is just a volume control for the right DAC so shouldn't make any
odds really.

> However, after running the offending amixer command this no longer 
> happens. It seems that the dapm_power_widgets() function determines that 
> the DAC is off and so doesn't power any widgets on at all.

Well, it determines that there's not a complete path so it doesn't
bother powering anything up which isn't *quite* the same thing.  It does
look like that's what's happening here - I can reproduce similar
behaviour here, though it's not quite the same system.  I'll try to fix
this tomorrow.
