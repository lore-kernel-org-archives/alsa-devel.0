From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PPC,SOUND] Fix audio gpio state detection
Date: Mon, 13 Feb 2006 09:35:37 +1100
Message-ID: <1139783738.5247.54.camel@localhost.localdomain>
References: <jehd7527wq.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7F29C1C5
	for <alsa-devel@alsa-project.org>; Sun, 12 Feb 2006 23:36:49 +0100 (MET)
In-Reply-To: <jehd7527wq.fsf@sykes.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Andreas Schwab <schwab@suse.de>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@ozlabs.org, Ben Collins <ben.collins@ubuntu.com>
List-Id: alsa-devel@alsa-project.org

On Sat, 2006-02-11 at 17:10 +0100, Andreas Schwab wrote:
> When booting with line out or headphone plugged, you won't hear anything.
> The problem is that after reset all channels are muted, but the actual
> value of the gpio port doesn't exactly match the active_val settings as
> expected by check_audio_gpio.  For example, the line_mute port is set to
> 7, but check_audio_gpio would expect 0xd or 0xf, thus its return value
> indicates that it is not active, even though it is.  AFAICS only looking
> at the low bit is enough to determine whether the port is active.
> 
> Signed-off-by: Andreas Schwab <schwab@suse.de>
> 
> Index: linux-2.6.16-rc2/sound/ppc/tumbler.c
> ===================================================================
> --- linux-2.6.16-rc2.orig/sound/ppc/tumbler.c	2006-02-03 19:43:50.000000000 +0100
> +++ linux-2.6.16-rc2/sound/ppc/tumbler.c	2006-02-11 03:46:30.000000000 +0100
> @@ -207,7 +207,7 @@ static int check_audio_gpio(struct pmac_
>  
>  	ret = do_gpio_read(gp);
>  
> -	return (ret & 0xd) == (gp->active_val & 0xd);
> +	return (ret & 0x1) == (gp->active_val & 0x1);
>  }
>  
>  static int read_audio_gpio(struct pmac_gpio *gp)

Can you sync with the patches Ben Collins is doing on this as well ?

Ben, what is your status ? Are you feeding those through upstream the
alsa folks ? Or waiting for me to do something ? :)

The above, if it appear to works well enough might be worth merging
now ...

Ben.



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
