From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: RawMIDI behaviour with MidiFace 4x4
Date: Mon, 9 Mar 2015 15:29:08 +0100
Message-ID: <alpine.DEB.2.02.1503091524320.7125@lnxricardw1.se.axis.com>
References: <6A72E9C91650BD49A6D9B305755BC04C42D801FA@mbs1.ad.jyu.fi>
 <alpine.DEB.2.02.1503090933530.7125@lnxricardw1.se.axis.com>
 <54FD5E2D.40801@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 83094260712
 for <alsa-devel@alsa-project.org>; Mon,  9 Mar 2015 15:29:22 +0100 (CET)
In-Reply-To: <54FD5E2D.40801@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Kalvas,
 Taneli" <taneli.v.m.kalvas@jyu.fi>
List-Id: alsa-devel@alsa-project.org


On Mon, 9 Mar 2015, Clemens Ladisch wrote:

> Ricard Wanderlof wrote:
> > On Sat, 7 Mar 2015, Kalvas, Taneli wrote:
> >> I am developing a patch librarian for a synthesizer. Because the
> >> communication happens with Midi sysex and timing is not relevant I cho=
se
> >> RawMIDI interface and not the alsa sequencer. The problem I have
> >> encountered is that writing to the midi port with snd_rawmidi_write()
> >> seems to broken. The function accepts any size of data block and claims
> >> to have sent everything. In reality only a part of the message is sent.
> >> For a large block size I can see the activity light blinking for
> >> fraction of a second. This happens both in blocking and non-blocking
> >> mode. I would expect the snd_rawmidi_write() to accept only a part of
> >> the message.
> >
> > Can't help with rawmidi, but I can at least report that my experience
> > using the sequencer interface has been that it is rather straightforward
> > to use, even if just using it to send and transmit sysex data, even when
> > the data is longer than 300 bytes.
> =

> If the data is larger than the RawMIDI buffer size (4096 bytes), the
> sequencer does not wait (like snd_rawmidi_write() would do), but just
> drops data.

Interesting. Thanks for the info. I've only tried sending patch dumps for =

single synthesizer patches, in the region of 400 bytes, which are more =

than 300 but far less than 4096 obviously.

I have noted though, that when sending data with snd_seq_ev_set_sysex() =

that the ALSA lib internally copies the data to an internal, malloced =

buffer, so I always thought that it would take care of any amount of data =

from there, but apparently not then?

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
