From: John Rigg <ad@sound-man.co.uk>
Subject: Re: Some problems with two 1010LTs (pcm_multi & jackd)
Date: Fri, 27 Jan 2006 12:53:17 +0000
Message-ID: <20060127125317.GA3768@localhost.localdomain>
References: <43D8D6E9.80902@findus.dhs.org> <20060126184843.GA3747@localhost.localdomain> <43D957E1.3030608@findus.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail3.uklinux.net (mail3.uklinux.net [80.84.72.33])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 80ED31AD
	for <alsa-devel@alsa-project.org>; Fri, 27 Jan 2006 13:42:11 +0100 (MET)
Content-Disposition: inline
In-Reply-To: <43D957E1.3030608@findus.dhs.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Petter =?iso-8859-1?Q?Sundl=F6f?= <petter.sundlof@findus.dhs.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 27, 2006 at 12:14:41AM +0100, Petter Sundl=F6f wrote:
>=20
> >>After this I tried to run jackd -d alsa -r44100 -p512 -C multi_captur=
e=20
> >>-P multi_playback

> >>I then start Ardour and open a session. I place the playhead somewher=
e=20
> >>and try to start playback. Nothing happens. After a few seconds, Ardo=
ur=20
> >>is disconnected from JACK, and I receive this in jackd's stdout:
> >>
> >>ALSA: poll time out, polled for 17416024 usecs

Just thought of something else. envy24control has `Locked' and `Reset'
buttons. `Locked' keeps the master card's clock set to whatever rate
is set by envy24control's radio buttons, regardless of what you specify
on the command line.
If you have `Locked' set and specify a different rate on the command
line, jackd just hangs and will probably give a poll timeout=20
(or if you're running it in realtime the jackd watchdog times out).

Make sure you have the `Locked' button unchecked and the `Reset' button
checked. `Reset' allows the command line to override the envy24control
setting for sample rate. I suspect these buttons should be mutually exclu=
sive,
ie. radio buttons, but they're not (looks like a bug).

John


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
