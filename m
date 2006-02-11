From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Re: ALSA - pnp OS bios option
Date: Sat, 11 Feb 2006 14:47:23 -0500
Message-ID: <1139687243.19342.95.camel@mindpipe>
References: <200601092022.56244.nick@linicks.net>
	 <200601101759.20707.nick@linicks.net> <s5hek3geyup.wl%tiwai@suse.de>
	 <200602111054.50947.nick@linicks.net>
	 <7c3341450602110556u75c4bfffq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <7c3341450602110556u75c4bfffq@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Nick <nick@linicks.net>
Cc: Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, 2006-02-11 at 13:56 +0000, Nick wrote:
> > Ummm.  At the command line, same errors also.  So I deleted /etc/asound.state
> > and reconfigured alsamixer from scratch.  Then following 'alsactl store',
> > 'alsactl restore' completes without issue (i.e. works clean).
> >
> > If I then reboot, the same damn control #47 errors happen again.  It's as if
> > something changes my asound.state file at boot time time?
> >
> > Ideas?  This is driving me potty.
> >
> 
> OK, talking to myself (testing, testing, 1-2-3) - I have resolved this
> issue after spending 2 hours trying to get my Mic to work again in
> Teamspeak (why is there _so_ many frigging mixers
> (alsamixer/amixer/aumix/kmix/arts) that all seem to do different
> things...

Because people keep writing half-assed mixers, rather than fixing the
existing ones, and distros inexplicably include 5 of them.  Half the
mixers out there only speak OSS, and distros ship them anyway.

Lee



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
