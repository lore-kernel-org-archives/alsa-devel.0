From: Andrew Burgess <aab@cichlid.com>
Subject: Oops: iMic, alsa cvs, 2.4.23-pre2
Date: Sun, 31 Aug 2003 14:30:38 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200308312130.h7VLUcJ32453@cichlid.com>
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

NULL pointer dereference

Trace; f09b16bf <[usb-ohci]dl_del_list+40f/460>
Trace; c0119619 <process_timeout+19/20>
Trace; f09b255b <[usb-ohci]hc_interrupt+10b/1a0>
Trace; c0109080 <handle_IRQ_event+60/a0>
Trace; c010929b <do_IRQ+8b/e0>
Trace; c0105420 <default_idle+0/40>
Trace; c010bd18 <call_do_IRQ+5/d>
Trace; c0105420 <default_idle+0/40>
Trace; c010544c <default_idle+2c/40>
Trace; c01054c2 <cpu_idle+42/60>
Trace; c011d42b <call_console_drivers+5b/120>
Trace; c011d607 <printk+a7/170>

I run:

  arecord -D imic --rate 44100 -f S16_LE - | aplay -

and then press ^C

I get:

A few URB timeouts the first time but the kernel stayed up.
Then the oops the 2nd time I ran it and a hard hang (had to use
a pencil for the backtrace :-).

kernel 2.4.23-pre2 (because it has a new batch of USB patches)
alsa-cvs
dual athlon mb
Griffin iMic
Creative Soundblaster-Live!

PS Any chance the alsa cvs could set its version to something other
than 0.9.6? At least 0.9.6-cvs or maybe some actual cvs version
that would make sense to developers? Maybe the build script could
detect it was running in a cvs tree and grab the version from the cvs info?
If I were a cvs guru I'd send a patch...




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
