From: Matt Kelly <radius@charter.net>
Subject: ioctl(... SNDCTL_SEQ_OUTOFBAND ...)  help?
Date: Mon, 8 Mar 2004 09:30:24 -0600 (CST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200403081530.JAA04994@charter.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Hello,

I'm trying to locate the cause of a bug I filed:  #0000108 
(ioctl(... SNDCTL_SEQ_OUTOFBAND ...) does not work).  I'm using SuSE 8.2 Pro
with an off-the-shelf 2.4.25 kernel, and an SB Audigy2 card.  I'm using
an external MIDI keyboard and some MIDI rack-mount modules.  Everything
seems to work just fine, audio and MIDI, except for this.

I've traced this all the way down to the function mpu401_write(), located
in alsa-kernel/pci/emu10k1/emumpu401.c.  This is where all data gets 
written to the sound card.  (actually there is a func below it, but all it
does is the in's and out's.)

I've put in snd_printk()'s to print out the data going to the card.  The data 
looks "almost identical" whether I use ioctl(... SNDCTL_SEQ_OUTOFBAND ...) or a
SEQ_START_NOTE(), etc. call. 

So why would one work and not the other?  Could it be something with IRQ's
not being enabled at the right time?  All the same code gets used for
both types of operations past a certain point, and all the data looks very
similar.  I don't know what the data bytes mean when at the hardware level,
so it could be that the small differences between the two may mean something.

Can anyone give me a pointer as to what else I should be looking at?  Or, a
description of what the raw data bytes mean to the Audigy2?

Thanks,

Matt K.





-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
