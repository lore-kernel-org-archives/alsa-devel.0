From: Tommi Sakari Uimonen <tuimonen@cc.hut.fi>
Subject: Re: Again with the Delta 1010LT...
Date: Thu, 26 Feb 2004 09:25:30 +0200 (EET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.OSF.4.58.0402260907490.175637@kosh.hut.fi>
References: <403D1B36.1010908@sun.ac.za>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <403D1B36.1010908@sun.ac.za>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ludwig Schwardt <schwardt@sun.ac.za>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> I'm struggling to sync two Delta 1010LT cards. I've tried both the word
> clock and SPDIF approaches, without any success. Both the SPDIF Out and
> Word Clock Out connectors show no activity when inspected by an
> oscilloscope.

Have you tried to connect card 1's spdif out to 2's input and set 2's
clock to spdif in.

I think only way to get anything properly from spdif in is to clock the
card from the spdif in also.

However, sometimes my Audiophile card receivec stuff from spdif even it's
not clocked from it, but then I get pops and cracks on leftf channel, and
sometimes I hear nothing. But both issues disappear when clocking from
spdif.

> - Is the word clock output something you must switch on in the ALSA
> driver or is it supposed to start automatically when you have a valid
> clock signal on the card?

Don't know.

> - Do I have to do something special to get SPDIF output (I'm new to

No you don't. My .asoundrc has

pcm.spdif_test
{
        type plug
        ttable.0.8 1
        ttable.1.9 1
        slave.pcm {
                type hw
                card 0
                device 0
        }
}

and I can play & capture using this 'spdif_test' device. This is for
Audiophile, but since they use same chip, this should work for you.

> this)? I've fiddled with iecset from alsa-utils, and otherwise I
> connected the SPDIF Out to various inputs using the patchbay of
> envy24control. Still, no signal appears on the connector.

>From one card? You can't connect card's outputs to any inputs with
anvy24control within the same card. JACK can do that, but it's a different
story.

You can connect inputs to outputs directly with the envy24control and it's
done in hardware.

Tommi

ps. One more thing, make sure you use the right connectors when connecting
physically the spdif inputs and outputs.


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
