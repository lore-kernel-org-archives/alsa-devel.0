From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Can anyone help?
Date: Sun, 12 Feb 2006 19:34:18 -0500
Message-ID: <1139790858.2739.26.camel@mindpipe>
References: <1139526455.9296.5.camel@localhost.localdomain>
	 <1139527169.30058.130.camel@mindpipe>
	 <1139528032.9296.8.camel@localhost.localdomain>
	 <1139528366.30058.133.camel@mindpipe>
	 <1139789040.10187.18.camel@localhost.localdomain>
	 <1139790318.2739.21.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from viper.oldcity.dca.net (viper.oldcity.dca.net [216.158.38.4])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 76D0E1C9
	for <alsa-devel@alsa-project.org>; Mon, 13 Feb 2006 01:34:20 +0100 (MET)
In-Reply-To: <1139790318.2739.21.camel@mindpipe>
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

On Sun, 2006-02-12 at 19:25 -0500, Lee Revell wrote:
> On Mon, 2006-02-13 at 00:04 +0000, Adrian McMenamin wrote:
> > But the basic problem remains the same:
> > 
> > /lib # aplay -L
> > aplay: pcm_list:280: snd_config_updte: Invalid argument
> > /lib # aplay -L
> > aplay: pcm_list:280: snd_config_update: Invalid argument
> > /lib # aplay -D hw:0,0
> > aplay: pcm.c: 2119: snd_pcm_open: Assertion `pcmp && name' failed.
> > Aborted
> > 
> 
> You must be forgetting to initialize something in the driver.
> 
> Go over your driver source carefully with a known working driver
> side-by-side.
> 
> Add more debug output to alsa-lib and your driver.
> 
> I really have no idea what's wrong.
> 

Does /usr/share/alsa/alsa.conf exist?

Lee



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
