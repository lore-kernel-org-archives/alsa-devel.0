From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: CD SPDIF in Soundblaster Live 5.1 working?
Date: Tue, 07 Oct 2003 11:19:41 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0310071111090.6744-100000@studcom.urz.uni-halle.de>
References: <1065454063.968.16.camel@client.veehoo.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <1065454063.968.16.camel@client.veehoo.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Juha <juhis@trinity.is-a-geek.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Juha wrote:
> I'm trying to route spdif signal from my dvb card through my soundcard,
> a sb live 5.1, to my amplifier. My amplifier states that it's 48kHz
> spdif signal. I connected the spdif out of the dvb card to the "CD
> SPDIF" connector of the sb live card. Is this the proper way to do it,
> ie, should it work or could it be made to work?

The standard voltage for S/PDIF signals is 0.5V, but the name "CD
SPDIF" (and the "TTL" in the name of ther mixer control) implies that
the SB wants to have 5V.

> This PCM device (it's the 4th PCM device (index 3!) and first subdevice
> (index 0) for a given card) allows to forward 48kHz, stereo, 16-bit
> little endian streams without any modifications to the digital output
> (coaxial or optical).
>
> And this (if I understand correctly) is exactly what I want to do. But,
> for some reason, I can't see the 4th PCM device. A listing of the
> capture devices don't list that as an option:

Device 3 is playback only. As far as I can see, you can only record
from S/PDIF by mixing it with other input signals to device 0.


HTH
Clemens




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
