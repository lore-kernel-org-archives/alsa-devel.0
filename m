From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Re: ALSA - pnp OS bios option
Date: Sat, 11 Feb 2006 14:44:06 -0500
Message-ID: <1139687047.19342.91.camel@mindpipe>
References: <200601092022.56244.nick@linicks.net>
	 <200601101759.20707.nick@linicks.net> <s5hek3geyup.wl%tiwai@suse.de>
	 <200602111054.50947.nick@linicks.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200602111054.50947.nick@linicks.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Nick Warne <nick@linicks.net>
Cc: Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, 2006-02-11 at 10:54 +0000, Nick Warne wrote:
> Sorting SB Live! sound (alsactl restore)...
> alsactl: set_control:894: warning: name mismatch (Sigmatel Surround
> Playback 
> Volume/Sigmatel Surround Playback Switch) for control #47
> alsactl: set_control:896: warning: index mismatch (0/0) for control
> #47
> alsactl: set_control:1008: bad control.47.value index
> 
> 

Harmless

> Ummm.  At the command line, same errors also.  So I
> deleted /etc/asound.state 
> and reconfigured alsamixer from scratch.  Then following 'alsactl
> store', 
> 'alsactl restore' completes without issue (i.e. works clean).
> 
> If I then reboot, the same damn control #47 errors happen again.  It's
> as if 
> something changes my asound.state file at boot time time?
> 

Probably you have two different alsactl's installed, one that's
hardcoded to save the state in /etc/asound.state, and a distro version
that wants to save it in /var/lib/whatever.  It sounds like one is being
run at boot and a different one at shutdown.



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
