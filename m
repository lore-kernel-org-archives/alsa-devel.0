From: Johannes Stezenbach <js@sig21.net>
Subject: Re: ASoC: Patches for an STA32X and WM8782
Date: Wed, 15 Jun 2011 12:00:03 +0200
Message-ID: <20110615100003.GA21276@sig21.net>
References: <1308079626-31239-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bar.sig21.net (bar.sig21.net [80.81.252.164])
	by alsa0.perex.cz (Postfix) with ESMTP id AF7161037F8
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Jun 2011 12:00:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1308079626-31239-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Hi Daniel,

On Tue, Jun 14, 2011 at 09:27:04PM +0200, Daniel Mack wrote:
> I'm sending two patches to support the ST STA32x codec and the WM8782 ADC.
> The code was originally written by Johannes Stezenbach for 2.6.36.
> 
> As the ASoC internals changed quite a bit due to the multi-component
> reconstruction, I took care for the code transition to make these drivers
> compatible to more recent versions. If there's anything left to care for
> in these drivers, please let me know.

Thank you very much for doing that work!

In the STA32x driver there are a few controls #if 0'd, and there are
corresponding FIXMEs in sta32x_probe() where the operating mode
and channel mapping is hard coded.  I think the #if 0'd
controls can be deleted, this was the wrong idea.  The mode
configuration should eventually be moved to platform data, but
I thought this work is best left to a possible future second
user of the driver ;-)


Johannes
