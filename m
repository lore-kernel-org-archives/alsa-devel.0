From: Jeremy Hall <jhall@maoz.com>
Subject: rme9652: possible deadlock
Date: Mon, 14 Apr 2003 14:47:02 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200304141847.h3EIl2T0014979@sith.maoz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: paul@linuxaudiosystems.com
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

Consider the following:

Two RME9652's are running together and on different interrupts.

The master, in interrupt context, acquires its runtime->lock and begins 
snd_pcm_update_hw_ptr_interrupt()

At the same time, the second card, the slave, is behind, still in play 
mode, and wants to XRUN.  To do that, it must stop and restart all the 
substreams connected to it.  To do that, it must acquire the runtime lock 
of each, but the capture substream is locked in another interrupt.

solution:

Is it acceptible if XRUN occurs in a pcm_multi environment to only restart 
substreams related to that physical card? or is it necessary to restart 
the whole device to maintain sample-sync?

I'm thinking you'd need to restart all devices.  Is this reasonable? as 
in, am I reading the code correctly?

_J


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
