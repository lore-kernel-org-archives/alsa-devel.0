From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: limits
Date: Mon, 07 Jun 2004 09:43:09 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0406070926050.6374-100000@studcom.urz.uni-halle.de>
References: <1086505430.2578.16.camel@rivendell.home.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <1086505430.2578.16.camel@rivendell.home.local>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Florin Andrei wrote:
> What's the max number of cards in a system that can be used by ALSA
> simultaneously?

8

> What's the max number of MIDI ports that's supported by ALSA?

There can be up to 8 rawmidi devices per card, but each device can
have an unlimited number of subdevices.

OSS emulation supports 2 ports per card (/dev/midi0X, /dev/amidi0X).

There can be up to 192 sequencer clients (64 each for kernel, drivers
(8*8), and applications), and each can have up to 254 ports.

> What are other similar limits?

Up to 8 playback and 8 capture PCM devices per card, with unlimited
number of subdevices.

Up to 8 sequencer queues.

> The answers to the questions above - are they in the docs?

Use the Source, Luke!  :-)


HTH
Clemens




-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
