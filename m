From: "Martijn Sipkema" <msipkema@sipkema-digital.com>
Subject: Re: Re: [linux-audio-dev] midi events in jack callback / ALSA Sequencer
Date: Thu, 22 Aug 2002 14:21:17 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <001601c249de$e8d78140$0400a8c0@martijn>
References: <0AA9E01B31168E42A308714A6EF271841E9D89@trebe002.europe.nokia.com>
Reply-To: "Martijn Sipkema" <msipkema@sipkema-digital.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from hirogen.kabelfoon.nl (hirogen.kabelfoon.nl [62.45.45.69])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id OAA16398
	for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2002 14:24:33 +0200
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

> Why is it important to keep the API simple, shouldn't it be functional in
first place and make the API usage simply?

Who says a simple API can't be functional?

> Anyway (IMHO), there should really be an API which combines audio and MIDI
playback, recording and timing of events and makes it possible to keep MIDI
in sync with audio (ALSA sequencer API seems to support only tick and time
synchronization modes, no audio clock sync mode). Professional API's like
ASIO and VST (and DirectMusic) synchronizes everything to audio clock
(sample position). Even when MTC is used the audio clock is the main clock
source, digital I/O or world clock is used to sync the audio clock to the
audio clock of the external device. There is no need for other sync modes
than audio (_maybe the tick mode could be useful if ALSA takes care of
sending MIDI clock, SPP, MTC etc. data to external devices). Sequencer
application can easily convert sample position from the beginning of the
song to measures / beats, time etc. whatever is needed when the time
signature, tempo and sample rate is known - reading the sample position from
the sound card is no problem at all!

Well, I disagree. I think using UST is better. You might want to use MIDI
without audio. Also
MIDI hardware that supports scheduling will not support scheduling to the
audio position. Using
UST just means mapping different clocks to one common clock.

> , PCI chipset's DMA registers have usually such current play position
register, or if not, the sample position can be calculated by measuring the
time between IRQ's and calculating the time between current time and the
time when last interrupt was received.

The current sample position does not tell me anything about when some
earlier sample occured or
a later sample will occur. In your example you already use two UST/MSC
values to estimate
the current MSC. Allthough it is possible on some hardware to read the
current sample position
(MSC) it is not possible to the OS (or other hardware) to schedule on it and
so you'll have to
convert to another clock at some point.

--martijn







-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
