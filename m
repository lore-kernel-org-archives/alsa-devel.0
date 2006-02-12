From: Nick Warne <nick@linicks.net>
Subject: Re: Re: ALSA - pnp OS bios option
Date: Sun, 12 Feb 2006 07:56:38 +0000
Message-ID: <200602120756.38975.nick@linicks.net>
References: <200601092022.56244.nick@linicks.net> <200602111054.50947.nick@linicks.net> <1139687047.19342.91.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1139687047.19342.91.camel@mindpipe>
Content-Disposition: inline
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
Cc: Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Saturday 11 February 2006 19:44, Lee Revell wrote:
> > If I then reboot, the same damn control #47 errors happen again.  It's
> > as if
> > something changes my asound.state file at boot time time?
>
> Probably you have two different alsactl's installed, one that's
> hardcoded to save the state in /etc/asound.state, and a distro version
> that wants to save it in /var/lib/whatever.  It sounds like one is being
> run at boot and a different one at shutdown.

First thing I thought of - Slackware is a 'clean, straight' distro though, and 
the only asound.state file I had was in /etc/ and only one alsactl in 
default /usr/sbin

On Saturday 11 February 2006 22:07, Lee Revell wrote:
> > do we need to keep the alsa tools and
> > stuff current too?
>
> Yes - kernel upgrades should depend on alsa-lib upgrades (many distros
> seem to get this wrong).  This should be fixed in the future, but it's
> been this way for some time.

Well, it appears to have fixed the issues I had.  Several reboots since and no 
problems now.

Looking back, originally I had a 2.4.x kernel - I have since upgraded to 2.6.x 
series, plus built a lot of new tools and such from source - all except alsa 
stuff, of course - so it does make sense and I kick myself for not thinking 
about this in the beginning.  One to remember.

Thanks,

Nick
-- 
"Person who say it cannot be done should not interrupt person doing it."
-Chinese Proverb


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
