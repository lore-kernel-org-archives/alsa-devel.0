From: Brix <brix82@libero.it>
Subject: Re: troubles programming with the sequencer
Date: Thu, 29 Jan 2004 21:21:48 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040129212148.07de1671.brix82@libero.it>
References: <20040123190532.1f335a80.brix82@libero.it>
	<Pine.HPX.4.33n.0401261447190.24795-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0401261447190.24795-100000@studcom.urz.uni-halle.de>
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

On Mon, 26 Jan 2004 14:52:59 +0100 (MET)
Clemens Ladisch <clemens@ladisch.de> wrote:

> The default instrument is 0 (grand piano).

Ok

> You can send program change messages with the sequencer, too.

This is what i do in the set_chan_instr() function, it works fine.

> This does not work on big-endian machines, use char for ch.

Ok

> If the rawmidi device is already opened, it may not be possible for
> the sequencer to open it, too.  Call snd_rawmidi_close, or leave this
> code out altogether.

Now i don't touch anything about instruments and channels, and i don't use any of the rawmidi functions, but it still doesn't work.

> Directly after starting the queue, the program exists, and the queue
> gets destroyed.  Try snd_seq_sync_output.

There is no such library function...
I tried calling sleep() for a few tenth of seconds, hoping the sequencer would flush out anything, but it did not help.

-- 

	Hardware is never old.
	People just choose the wrong OS.


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
