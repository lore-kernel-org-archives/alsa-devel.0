From: Francisco Moraes <fmoraes74@netzero.net>
Subject: Emu10k1x status
Date: Mon, 10 May 2004 19:49:19 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40A014FF.90107@netzero.net>
References: <403154C2.3020701@netzero.net>	<s5h3c99yb00.wl@alsa2.suse.de>	<403354B9.8000305@netzero.net>	<s5hd68cwpxa.wl@alsa2.suse.de>	<40340A6B.7080507@netzero.net> <s5h65e2ugga.wl@alsa2.suse.de> <403FAA2E.1040600@netzero.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <403FAA2E.1040600@netzero.net>
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

Hi everybody,

Just wanted to share the status of the Emu10k1x driver (Dell SB Live! 
Value). I've finally got PCM playback working at 48000khz and a 32Kb 
buffer. I haven't tried too much more than this which is hard because of 
lack of specs for the card.

I am doing some clean up and I hope to have a first pass of the drive 
submitted soon.

By the way, I've also added support for the joystick port on the card. 
This could have been done by simply adding the PCI ID into the 
drivers/char/joystick/emu10k1-gp.c driver in the linux kernel. Any 
suggestions or preferences of whether this should be changed in the 
kernel driver or in the alsa driver itself like I have at the moment?

Francisco


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
