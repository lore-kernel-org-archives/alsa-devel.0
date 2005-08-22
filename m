From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: emagic MT4
Date: Mon, 22 Aug 2005 09:32:26 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0508220931080.20385-100000@studcom.urz.uni-halle.de>
References: <1124476568.430626984ab55@horde.hku.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1124476568.430626984ab55@horde.hku.nl>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Sam <tzahm@punkass.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Sam wrote:
> I've been attempting to use the "snd-usb-audio" module to make an Emagic MT4
> midi interface work under linux. At first, it appeared to be working fine: 'cat
> /dev/snd/midiC0D0' would output more garbled characters everytime I'd struck a
> key on the keyboard.
>
> Connecting the keyboard to a software synth via aconnect does work, but the
> result is not what one would expect: I hear one note when I first hit a key,
> but the sound either gets stuck or the synth repeats the same note once I
> release the key. Trying to play a scale does not work. I always hear the same
> note.

What is the output of "amidi -d -p hw:0" when you press and release
some keys?


Regards,
Clemens



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
