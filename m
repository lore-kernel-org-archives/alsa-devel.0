From: John Rigg <ad@sound-man.co.uk>
Subject: Re: Some problems with two 1010LTs (pcm_multi & jackd)
Date: Fri, 27 Jan 2006 14:02:21 +0000
Message-ID: <20060127140221.GA4036@localhost.localdomain>
References: <43D8D6E9.80902@findus.dhs.org> <20060126184843.GA3747@localhost.localdomain> <43D957E1.3030608@findus.dhs.org> <20060127125317.GA3768@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail3.uklinux.net (mail3.uklinux.net [80.84.72.33])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 164F71AD
	for <alsa-devel@alsa-project.org>; Fri, 27 Jan 2006 14:51:15 +0100 (MET)
Content-Disposition: inline
In-Reply-To: <20060127125317.GA3768@localhost.localdomain>
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

On Fri, Jan 27, 2006 at 12:53:17PM +0000, John Rigg wrote:
> On Fri, Jan 27, 2006 at 12:14:41AM +0100, Petter Sundl=F6f wrote:
> >=20
> > >>After this I tried to run jackd -d alsa -r44100 -p512 -C multi_capt=
ure=20
> > >>-P multi_playback
>=20
> > >>I then start Ardour and open a session. I place the playhead somewh=
ere=20
> > >>and try to start playback. Nothing happens. After a few seconds, Ar=
dour=20
> > >>is disconnected from JACK, and I receive this in jackd's stdout:
> > >>
> > >>ALSA: poll time out, polled for 17416024 usecs
>=20
> Just thought of something else. envy24control has `Locked' and `Reset'
> buttons. `Locked' keeps the master card's clock set to whatever rate
> is set by envy24control's radio buttons, regardless of what you specify
> on the command line.
> If you have `Locked' set and specify a different rate on the command
> line, jackd just hangs and will probably give a poll timeout=20
> (or if you're running it in realtime the jackd watchdog times out).
>=20
> Make sure you have the `Locked' button unchecked and the `Reset' button
> checked. `Reset' allows the command line to override the envy24control
> setting for sample rate. I suspect these buttons should be mutually exc=
lusive,
> ie. radio buttons, but they're not (looks like a bug).

This is getting complicated. I start getting all kinds of spurious
behaviour from jackd after I've been setting and resetting things
in envy24control. A reboot is required to make it behave normally again.

On my system the default on startup in envy24control is `Locked' button
unselected, `Reset' selected. All I have to do is tell the second card
to sync to the first with either S/PDIF or wordclock input. Then it
runs fine. The minute I try messing with `Locked' and `Unlocked' buttons
or sample rates jackd starts crashing with a floating point exception
(which I suspect is an indication of the cards losing sync).

It is possible to set this stuff up manually in /etc/asound.state using
the alsactl command to save/restore the settings in this file.
I think I'll start using it to set up my cards' clocks and only use
envy24control for the level meters and routing (at least until I get
hold of an oscilloscope and an external word clock generator to help
diagnose what's going wrong).

(My previous assessment of what the `Locked' and `Reset' buttons are
supposed to do may be incomplete, since they seem to behave differently
at different times).

John


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
