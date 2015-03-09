From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: RawMIDI behaviour with MidiFace 4x4
Date: Mon, 09 Mar 2015 09:47:41 +0100
Message-ID: <54FD5E2D.40801@ladisch.de>
References: <6A72E9C91650BD49A6D9B305755BC04C42D801FA@mbs1.ad.jyu.fi>
 <alpine.DEB.2.02.1503090933530.7125@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 024092605A4
 for <alsa-devel@alsa-project.org>; Mon,  9 Mar 2015 09:47:44 +0100 (CET)
In-Reply-To: <alpine.DEB.2.02.1503090933530.7125@lnxricardw1.se.axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricard Wanderlof <ricard.wanderlof@axis.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Kalvas,
 Taneli" <taneli.v.m.kalvas@jyu.fi>
List-Id: alsa-devel@alsa-project.org

Ricard Wanderlof wrote:
> On Sat, 7 Mar 2015, Kalvas, Taneli wrote:
>> I am developing a patch librarian for a synthesizer. Because the
>> communication happens with Midi sysex and timing is not relevant I chose
>> RawMIDI interface and not the alsa sequencer. The problem I have
>> encountered is that writing to the midi port with snd_rawmidi_write()
>> seems to broken. The function accepts any size of data block and claims
>> to have sent everything. In reality only a part of the message is sent.
>> For a large block size I can see the activity light blinking for
>> fraction of a second. This happens both in blocking and non-blocking
>> mode. I would expect the snd_rawmidi_write() to accept only a part of
>> the message.
>
> Can't help with rawmidi, but I can at least report that my experience
> using the sequencer interface has been that it is rather straightforward
> to use, even if just using it to send and transmit sysex data, even when
> the data is longer than 300 bytes.

If the data is larger than the RawMIDI buffer size (4096 bytes), the
sequencer does not wait (like snd_rawmidi_write() would do), but just
drops data.


Regards,
Clemens
