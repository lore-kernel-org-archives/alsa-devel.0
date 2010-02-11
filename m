From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [RESEND][PATCHv2 3/4] Add ASoC support for
	Devkit8000
Date: Thu, 11 Feb 2010 18:56:42 +0200
Message-ID: <20100211185642.34eb234e.jhnikula@gmail.com>
References: <1265901239-31285-1-git-send-email-weber@corscience.de>
	<1265901628.3179.14.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f223.google.com (mail-ew0-f223.google.com
	[209.85.219.223])
	by alsa0.perex.cz (Postfix) with ESMTP id 9E92E10384D
	for <alsa-devel@alsa-project.org>; Thu, 11 Feb 2010 17:52:15 +0100 (CET)
Received: by ewy23 with SMTP id 23so242359ewy.4
	for <alsa-devel@alsa-project.org>; Thu, 11 Feb 2010 08:52:14 -0800 (PST)
In-Reply-To: <1265901628.3179.14.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, jy0922.shim@samsung.com, jkrzyszt@tis.icnet.pl, tiwai@suse.de, Thomas Weber <weber@corscience.de>, broonie@opensource.wolfsonmicro.com, peter.ujfalusi@nokia.com, linux-kernel@vger.kernel.org, tony@atomide.com, x0052729@ti.com, anuj.aggarwal@ti.com, linux-omap@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, 11 Feb 2010 15:20:28 +0000
Liam Girdwood <lrg@slimlogic.co.uk> wrote:

> On Thu, 2010-02-11 at 16:13 +0100, Thomas Weber wrote:
> > This patch expands the omap3beagle sound soc for the
> > beagle board clone DevKit8000.
> > 
> > Signed-off-by: Thomas Weber <weber@corscience.de>
> 
> Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
> 
Acked-by: Jarkko Nikula <jhnikula@gmail.com>

Note, this is safe to push even if this goes to mainline before the
basic board file and arch/arm/mach-omap2/Kconfig change from linux-omap.
The machine type and so machine_is_devkit8000() are already there.


-- 
Jarkko
