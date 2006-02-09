From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Can anyone help?
Date: Thu, 09 Feb 2006 18:42:31 -0500
Message-ID: <1139528552.30058.135.camel@mindpipe>
References: <1139526455.9296.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mustang.oldcity.dca.net (mustang.oldcity.dca.net [216.158.38.3])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 79DE919A
	for <alsa-devel@alsa-project.org>; Fri, 10 Feb 2006 00:42:33 +0100 (MET)
In-Reply-To: <1139526455.9296.5.camel@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2006-02-09 at 23:07 +0000, Adrian McMenamin wrote:
> / # cat /bin/busybox > /dev/snd/pcmC0D0p
> ALSA /home/adrian/aica/aica/snd_card_aica.c:151: In
> snd_aicapcm_pcm_open
> cat: Write Error: File descriptor in bad state
> / # Feb 10 00:01:02 dreamy user.warn kernel:
> ALSA /home/adrian/aica/aica/snd_card_aica.c:151: In
> snd_aicapcm_pcm_open
> 
> But as the above fragment shows this opens the device file but not
> much
> else (as I assume it has no automagic way of accessing the alsa
> subsystem)
> 

Yes, "cat file > /dev/snd/pcmX" makes no sense, that's now how ALSA
works.  The only supported interface to these is via alsa-lib.

Lee



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
