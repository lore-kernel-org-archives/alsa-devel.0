From: mikko.a.helin@nokia.com
Subject: RE: Re: [linux-audio-dev] midi events in jack callback / ALSA Sequencer
Date: Thu, 22 Aug 2002 14:51:48 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <0AA9E01B31168E42A308714A6EF271841E9D89@trebe002.europe.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mgw-x4.nokia.com (mgw-x4.nokia.com [131.228.20.27])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id NAA15964
	for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2002 13:51:54 +0200
Received: from esvir04nok.ntc.nokia.com (esvir04nokt.ntc.nokia.com [172.21.143.36])
	by mgw-x4.nokia.com (Switch-2.2.1/Switch-2.2.0) with ESMTP id g7MC49f24992
	for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2002 15:04:10 +0300 (EET DST)
content-class: urn:content-classes:message
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: linux-audio-dev@music.columbia.edu
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Why is it important to keep the API simple, shouldn't it be functional =
in first place and make the API usage simply?

Anyway (IMHO), there should really be an API which combines audio and =
MIDI playback, recording and timing of events and makes it possible to =
keep MIDI in sync with audio (ALSA sequencer API seems to support only =
tick and time synchronization modes, no audio clock sync mode). =
Professional API's like ASIO and VST (and DirectMusic) synchronizes =
everything to audio clock (sample position). Even when MTC is used the =
audio clock is the main clock source, digital I/O or world clock is used =
to sync the audio clock to the audio clock of the external device. There =
is no need for other sync modes than audio (_maybe the tick mode could =
be useful if ALSA takes care of sending MIDI clock, SPP, MTC etc. data =
to external devices). Sequencer application can easily convert sample =
position from the beginning of the song to measures / beats, time etc. =
whatever is needed when the time signature, tempo and sample rate is =
known - reading the sample position from the sound card is no problem at =
all, PCI chipset's DMA registers have usually such current play position =
register, or if not, the sample position can be calculated by measuring =
the time between IRQ's and calculating the time between current time and =
the time when last interrupt was received.

-Mikko

> etc. Of course
> you
> > might be using one big monolithic (cubase?) sequencer=20
> application which
> does
> > do everything you need....
>=20
> No, I like the concept of a lot of small applications. And I=20
> want those to
> be able
> to sync (slave) to MIDI clock.
>=20
>=20
> I think it is important to keep the API as simple as possible.
>=20
> --martijn


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
