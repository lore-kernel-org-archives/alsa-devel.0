From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: How to pair Wine with ALSA? part1: intro &
 underruns (long)
Date: Sun, 14 Aug 2011 14:22:47 +0200
Message-ID: <4E47BE17.1000205@ladisch.de>
References: <8E4C156DA5797D418DBFADFD8CE655A4138FB471F5@HE113481.emea1.cds.t-internal.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 485F424897
	for <alsa-devel@alsa-project.org>;
	Sun, 14 Aug 2011 14:23:09 +0200 (CEST)
In-Reply-To: <8E4C156DA5797D418DBFADFD8CE655A4138FB471F5@HE113481.emea1.cds.t-internal.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Joerg-Cyril.Hoehle@t-systems.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Joerg-Cyril.Hoehle@t-systems.com wrote:
 > UC1 Intermittent Mouse Clicks
 > An app may use the winmm API as follows:
 >  1. open the device
 >  2. from time to time, e.g. on mouse clicks, send wave data.
 > The requirements are:
 >
 > R1 Nothing (or silence) is to be played when the app submits no data.
 > R2 Once the app submits data, it should play ASAP.
 >
 > That is the app's view on it.  It seems to translate to
 > silence_threshold=0 and silence_size=boundary, doesn't it?

This translates to stop_threshold=buffer_size and start_threshold=1.
(Please note that a very small start_threshold increases the possibility
of an underrun because it becomes more likely that the sound card
immediately reads all valid samples.)

 > UC2 Video
 > I've not much to say here because I basically ignore how apps
 > synchronize audio with video.  GetPosition returns "the stream
 > position of the sample that is currently playing through the
 > speakers".  This begs for snd_pcm_delay, not avail_update.

Yes.

However, does that documentation actually make a distinction between the
last sample that has been read from the buffer and the sample being
played?

 > R3 Wine must offer access to several sound cards if available.

It is not easy to enumerate available sound devices.

It's possible to enumerate hardware devices, but this does not give you
software-implemented devices like PulseAudio or Bluetooth.

I'd suggest to have a default device ("default") and one device for each
hardware sound card ("default:x", where x is the card index, but some
people write a custom .asoundrc where this doesn't work), with the
possibility of adding other device names.

 > R4 Try and find hw/sw_params that work with the "default" device as
 >    well as individual cards (hw:x or perhaps plughw:x).

The hw_params are hardware dependent; there is not set of values that is
guaranteed to be available on all devices.

Unless you actually know that certain settings are possible, you should
always use snd_hw_params_set_xxx_near/first/last.

 > mmdevapi has a notion of exclusive and shared modes. I expect shared
 > mode to be asked with the "default" device (for mixing to work), and
 > exclusive with others (e.g. 5:1 sound).  OTOH, apps may also ask for
 > the default device in exclusive mode, which is said to be granted if
 > no other app is playing sound (much like I can grab hw:0 only when
 > dmix has nothing to do).

There are some conventions about which devices are sharable, but those
are not always true with some custom configurations.

I would be tempted to just ignore the exclusive/share flag.

 > R5 No samples are ever skipped.  If late, play late.  See R1/R2.
 >
 > I've observed that "dmix"+"pulse" and the "hw:x" devices approach
 > underruns radically differently.  In case of a 10s underrun, the
 > former silently skip over the next 10s worth of samples(!) -- if the
 > app does not submit those *fast* to catch up, you'll hear no more
 > sound! -- while the latter immediately write them to their HW buffer.

During an underrun, the device does not have valid samples to play.
A hardware device just plays whatever currently is in the ring buffer;
PulseAudio does not bother to mix samples that it knows would be wrong.

There is no guarantee about the actual output resulting from those
'missed' samples.  You can set silence_threshold/size to force silence.

The continue-on-xrun mode is intended for situations where the overall
timing of the running stream is important.  After an xrun, you indeed
have to write the 'missed' samples as fast as possible to catch up,
until the relationship between written samples and elapsed time is back
to a situation that looks as if no xrun has happened.

Configuring the device to stop on xruns seems to be a better fit for
your requirements.


Regards,
Clemens
