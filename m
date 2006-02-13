From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: Can anyone help?
Date: Mon, 13 Feb 2006 00:42:40 +0000
Message-ID: <1139791360.10187.26.camel@localhost.localdomain>
References: <1139526455.9296.5.camel@localhost.localdomain>
	 <1139790508.2739.24.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sc-outsmtp1.homechoice.co.uk (sc-outsmtp1.homechoice.co.uk [81.1.65.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 77D421C9
	for <alsa-devel@alsa-project.org>; Mon, 13 Feb 2006 01:42:47 +0100 (MET)
In-Reply-To: <1139790508.2739.24.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, 2006-02-12 at 19:28 -0500, Lee Revell wrote:
> On Thu, 2006-02-09 at 23:07 +0000, Adrian McMenamin wrote:
> > I cannot get aplay to work on my architecture (afaics anyway) eg
> > 
> > / # aplay -D hw:0,0 /bin/busybox
> > aplay: pcm.c: 2119: snd_pcm_open: Assertion `pcmp && name' failed.
> > Aborted
> > 
> 
> Try this patch:
> 
[snip]
> to see if it's the PCM handle or name that's not set.
> 
> Lee



Get this now:
/usr/share/alsa # aplay -L
aplay: pcm_list:280: snd_config_update: Invalid argument
/usr/share/alsa # aplay -D hw:0,0
aplay: pcm.c: 2120: snd_pcm_open: Assertion `name' failed.
Aborted

alsa.conf is installed.


Thanks for the help, I'll return to this tomorrow - it's getting on for
1am here now :)



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
