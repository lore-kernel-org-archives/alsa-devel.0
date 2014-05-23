From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH] ASoC: fsl_ssi: Add suspend/resume support
Date: Fri, 23 May 2014 17:18:21 +0800
Message-ID: <20140523091820.GB2650@dragon>
References: <1400823536-31708-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0210.outbound.protection.outlook.com [207.46.163.210])
 by alsa0.perex.cz (Postfix) with ESMTP id 0096F261ACD
 for <alsa-devel@alsa-project.org>; Fri, 23 May 2014 11:18:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1400823536-31708-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, broonie@kernel.org, timur@tabi.org
List-Id: alsa-devel@alsa-project.org

On Fri, May 23, 2014 at 02:38:56AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Doing a suspend/resume sequence while playing an audio track in the backgroung
> causes broken audio right after resume:
> 
> root@freescale /$ aplay clarinet.wav &
> 
> root@freescale /home$ Playing WAVE 'clarinet.wav' : Signed 16 bit Little Endian,
>  Rate 44100 Hz, Mono
> 
> root@freescale /home$ echo mem > /sys/power/state 
> PM: Syncing filesystems ... done.
> Freezing user space processes ... (elapsed 0.002 seconds) done.
> Freezing remaining freezable tasks ... (elapsed 0.002 seconds) done.
> Suspending console(s) (use no_console_suspend to debug)
> PM: suspend of devices complete after 37.082 msecs
> PM: suspend devices took 0.040 seconds
> PM: late suspend of devices complete after 4.234 msecs
> PM: noirq suspend of devices complete after 4.618 msecs
> Disabling non-boot CPUs ...
> PM: noirq resume of devices complete after 4.013 msecs
> PM: early resume of devices complete after 4.000 msecs
> PM: resume of devices complete after 68.907 msecs
> PM: resume devices took 0.070 seconds
> Restarting tasks ... Suspended. Trying resume. Failed. Restarting stream. Done.
> Suspended. Trying resume. Failed. Restarting stream. Done.
> Suspended. Trying resume. Failed. Restarting stream. Done.
> Suspended. Trying resume. Failed. Restarting stream. Done.
> Suspended. Trying resume. Failed. Restarting stream. Done.
> Suspended. Trying resume. Failed. Restarting stream. Done.
> Suspended. Trying resume. Failed. Restarting stream. Done.
> ....
> 
> Add SNDRV_PCM_TRIGGER_RESUME/SUSPEND cases so that we can gracefully handle
> system suspend/resume.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Acked-by: Shawn Guo <shawn.guo@freescale.com>
