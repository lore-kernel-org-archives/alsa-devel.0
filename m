From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: MIDI getting killed by Jack?
Date: Thu, 11 Sep 2003 17:42:21 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0309111736240.24243-100000@studcom.urz.uni-halle.de>
References: <200309111306.h8BD6Tfv007234@oud>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <200309111306.h8BD6Tfv007234@oud>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Mark Knecht <mknecht@controlnet.com>, Alsa-Devel <Alsa-Devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Paul Davis wrote:
> >When an interrupt for MIDI input occurs, the hdsp driver disables all
> >further MIDI interrupts until the current input data has been read.

... and midi_input_trigger flushes the input FIFO if the interrupt bit
isn't set.

Unfortunately, this does not seem to be the bug we're searching for.
:)


Regards,
Clemens




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
