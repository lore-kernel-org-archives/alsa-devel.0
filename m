From: Jez Humble <jez@whatsonwhen.com>
Subject: RE: audio via ethernet (was: dolby digital output)
Date: Mon, 18 Feb 2002 18:20:58 -0000
Message-ID: <917D6E50CD04D411BE8900D009F145CF98923F@PACAL>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

A parallel discussion has been taking place in the music bar
(music-bar@ampfea.org). I've given some of the more important comments
below.

>I think sending realtime audio data via eternet will be
>extremely difficult. It should be impossible to synchronize
>sample clock via ethernet. So each device has to have its
>own sample clock.

There is a protocol for determining which device is the master clock, which
is apparently "automatic and transparent to the user". Perhaps more urgent
are the fact that timing delays introduced by the fact that the Gibson
protocol DAISYCHAINS (which causes a whole host of other problems) will
screw MIDI up no end.

On the mLAN front, yes they do seem to be very similar, except that mLAN
works across FireWire, and is based on AMP (the Audio and Music Data
Transmission Protocol), which you can use without signing any agreements
with the evil guitar moloch from hell.

>4) All the problems of sending audio over packets have already been solved
>by the Voice over IP people.

I am somewhat sceptical: did they solve it for multiple streams of sound
sampled at 192khz? Indeed Gibson claims Magic provides up to 32 streams of
32-bit full-duplex sound at 192khz = 192Mbit/s, which is quite impressive
for ethernet, to say the least.

In fact the Gibson offering's main problems are with the control side of
things: Alastair Johnson pointed out the following quote from Gibson:

<evil guitar moloch>
Any device can assign a Control Link between a Source and a Target on the
network. The device making the assignment does not have to be the one with
either the Source or the Target. If that is the case, the assigning device
must issue the Assign Control Link message to both the Source and the
Target.
</evil guitar moloch>

<alastair>
I can already imagine the mayhem when two pieces of software/hardware try
and assign or remove Control Link to the same Sources and Targets. There
is no acknowledge message defined for this assign so if a control packet
is lost or if there are conflicting interests, there is no way to know.
Let alone fix it. (Hey why does the Cutoff knob on my Virus C suddenly
control the pitch of my Andromeda A& and my Kurzweill K2700?)
</alastair>

All in all the thing seems to be rather badly thought out.

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
