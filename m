From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: RawMIDI interface programming
Date: Thu, 11 Sep 2003 14:12:08 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0309111250210.8134-100000@studcom.urz.uni-halle.de>
References: <20030908143637.4f69b07f.brix82@libero.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <20030908143637.4f69b07f.brix82@libero.it>
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
> i need information about obtaining the correct rawmidi interface
> name (such as "hw:0,0,1"), corresponding to the MIDI synth device,
> from the system;

What do you mean with "the MIDI synth device"? There could be more
than one, or none. Usually, you let the user choose the device.

As default name, you could use "default", which is "hw:0,0" by
default, but can be changed in the user's .asoundrc.


HTH
Clemens




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
