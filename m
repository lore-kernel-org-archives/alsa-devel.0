From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: RawMIDI interface programming
Date: Fri, 12 Sep 2003 17:30:03 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0309121700520.26363-100000@studcom.urz.uni-halle.de>
References: <20030911180426.7c35cdb8.brix82@libero.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <20030911180426.7c35cdb8.brix82@libero.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Brix <brix82@libero.it>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Brix wrote:
> I'm working on an ear trainer using the rawmidi interface.
>
> Because i would let this application used by newbies, i need a
> method to obtain (from files in /proc/asound, i think) the name of
> a working MIDI Synth device.

It isn't possible to automatically determine which of the ports has a
working synthesizer. I don't think you can avoid asking the user which
port to use.

And many computers with integrated motherboard sound chips don't have
a synthesizer, so you'd have to use a software synthesizer, which is
available only as an ALSA sequencer port. Using the sequencer would
make your program more flexible, too.

The ALSA sequencer isn't documented very well, either, but you could
begin with this short HOWTO:
<http://www.mail-archive.com/alsa-devel%40lists.sourceforge.net/msg08905.html>
<http://www.mail-archive.com/alsa-devel%40lists.sourceforge.net/msg09011.html>
(If you want to send an event immediately, schedule it at a relative
time of 0.)


HTH
Clemens




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
