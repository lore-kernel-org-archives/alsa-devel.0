From: Jeremy Hall <jhall@maoz.com>
Subject: XRUN handling with SND_PCM_MULTI
Date: Tue, 15 Apr 2003 15:02:53 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200304151902.h3FJ2r92026464@sith.maoz.com>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

This probably was discussed with the introduction of a pcm_multi 
device--how to maintain sample-synch.

One possability is when a XRUN is seen on one of the devices, reset that 
device alone.  This breaks sample-synch, for example if half the channels 
didn't see a XRUN and the other half did, suddenly time has become 
discontiguous--the half that saw the XRUN is now "ahead" of the half that 
didn't when you replay the program material.

So do you want to:

1: silence the XRUNning card so that sample-synch is maintained

2: remove good data from the NON-XRUNning card(s)

3: ignore it

I can't figure out what currently happens--currently if two devices try to 
run snd_pcm_period_elapsed in interrupt context the machine will 
potentially deadlock as both interrupts try to take the spinlock, each 
waiting on the other to release it.

Thoughts are welcome.

_J


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
