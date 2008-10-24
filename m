From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Problem setting mixer switch with amixer/alsactl.
Date: Fri, 24 Oct 2008 18:26:40 +0100
Message-ID: <20081024172640.GB3328@sirena.org.uk>
References: <48FF7538.3090000@oliford.co.uk>
	<20081022205729.GD7537@sirena.org.uk>
	<48FFAFB1.1090106@oliford.co.uk>
	<20081023140015.GA17901@sirena.org.uk>
	<4900851D.2050001@oliford.co.uk> <4900F6D2.6030305@oliford.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id D84EE245B6
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Oct 2008 19:27:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4900F6D2.6030305@oliford.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Oliver Ford <oliford@oliford.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 23, 2008 at 11:12:34PM +0100, Oliver Ford wrote:

> Am I right in understanding that setting all the controls in amixer  
> doesn't actually enable the control in the codec chip at that time but  
> that the powering on/off is done by soc-dapm.c when the the DAC is  
> actually enabled when playing some audio? This appears to be what is  
> happening when it does work (looking at the log). I hadn't realised this.

Sort of.  The power control happens whenever any power-related control
changes and whenever audio is started or stopped.

> I've put some debugging in pxa2xx-ac97-write and in dapm_power_widgets()  
> and the log is attached (stripped of non-audio stuff).

I'll have a look at these on Monday.
