From: Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: alsa pcm jack plugin
Date: Tue, 10 Jan 2006 20:29:37 +0100
Message-ID: <20060110202937.6dcbf223@mango.fruits.de>
References: <20060108204454.511ad978@mango.fruits.de>
	<s5hirssf148.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hirssf148.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 10 Jan 2006 18:23:35 +0100
Takashi Iwai <tiwai@suse.de> wrote:

Hi Takashi,

sorry for the late reply. I didn't see this mail turn up on the LAD ML,
so i figured it got lost completely.

> > xmms simlpy doesn't start playback when using the jackplug device (well,
> > it seems it wants to, but its clock simply stays at 00:00). Jack seems
> > to stay functional though.

xmms seems to be in some sort of loop, which looks a bit like this
(repeating over and over):

gettimeofday({1136920429, 546991}, NULL) = 0
gettimeofday({1136920429, 547282}, NULL) = 0
gettimeofday({1136920429, 547424}, NULL) = 0
write(3, "\224\3\n\0\37\0\340\2>\0\340\2\0\6@\0P\1\0\0L\0\20\0\30"..., 88) = 88
read(3, 0xbfc5cc70, 32)                 = -1 EAGAIN (Resource temporarily unavai
lable)
select(4, [3], NULL, NULL, NULL)        = 1 (in [3])
read(3, "\1\1j$\0\0\0\0\"\0`\1\4\0\0\0\0\0\0\0\20\"\22\21\310\316"..., 32) = 32
gettimeofday({1136920429, 548535}, NULL) = 0
ioctl(3, FIONREAD, [0])                 = 0
poll([{fd=3, events=POLLIN}, {fd=5, events=POLLIN}, {fd=7, events=POLLIN}], 3, 8
) = 0
gettimeofday({1136920429, 557975}, NULL) = 0
gettimeofday({1136920429, 558473}, NULL) = 0
gettimeofday({1136920429, 558937}, NULL) = 0
ioctl(3, FIONREAD, [0])                 = 0
poll([{fd=3, events=POLLIN}, {fd=5, events=POLLIN}, {fd=7, events=POLLIN}], 3, 7
) = 0
gettimeofday({1136920429, 567853}, NULL) = 0
gettimeofday({1136920429, 568483}, NULL) = 0
ioctl(3, FIONREAD, [0])                 = 0
poll([{fd=3, events=POLLIN}, {fd=5, events=POLLIN}, {fd=7, events=POLLIN}], 3, 0
) = 0
gettimeofday({1136920429, 569815}, NULL) = 0
gettimeofday({1136920429, 570183}, NULL) = 0
write(3, "\224\3\n\0\37\0\340\2>\0\340\2\0\6@\0\240\1\0\0L\0\20\0"..., 88) = 88
read(3, "\1\1n$\0\0\0\0\"\0`\1\4\0\0\0\0\0\0\0$\"\22\21\310\316"..., 32) = 32
gettimeofday({1136920429, 571764}, NULL) = 0
ioctl(3, FIONREAD, [0])                 = 0
poll([{fd=3, events=POLLIN}, {fd=5, events=POLLIN}, {fd=7, events=POLLIN}], 3, 6
) = 0
gettimeofday({1136920429, 579972}, NULL) = 0
gettimeofday({1136920429, 580464}, NULL) = 0
read(13, 0xbfc5cbd0, 72)                = -1 EAGAIN (Resource temporarily unavai
lable)
gettimeofday({1136920429, 581452}, NULL) = 0
gettimeofday({1136920429, 581885}, NULL) = 0
ioctl(3, FIONREAD, [0])                 = 0
poll([{fd=3, events=POLLIN}, {fd=5, events=POLLIN}, {fd=7, events=POLLIN}], 3, 8
) = 0
gettimeofday({1136920429, 591941}, NULL) = 0
gettimeofday({1136920429, 592410}, NULL) = 0
gettimeofday({1136920429, 592778}, NULL) = 0
gettimeofday({1136920429, 593334}, NULL) = 0
write(3, "\224\3\n\0\37\0\340\2>\0\340\2\0\6@\0\0\1\20\0L\0\20\0"..., 40) = 40
ioctl(3, FIONREAD, [0])                 = 0
poll([{fd=3, events=POLLIN}, {fd=5, events=POLLIN}, {fd=7, events=POLLIN}], 3, 4
) = 0
gettimeofday({1136920429, 599691}, NULL) = 0
gettimeofday({1136920429, 600068}, NULL) = 0
ioctl(3, FIONREAD, [0])                 = 0
poll([{fd=3, events=POLLIN}, {fd=5, events=POLLIN}, {fd=7, events=POLLIN}], 3, 1
) = 0
gettimeofday({1136920429, 602685}, NULL) = 0
gettimeofday({1136920429, 603117}, NULL) = 0
write(3, ">\3\7\0\223\0\340\2\35\0\340\2>\0\340\2\6\0\0\0p\0\33\0"..., 48) = 48
read(3, "\1\1r$\0\0\0\0\"\0`\1\4\0\0\0\0\0\0\0L\"\22\21\310\316"..., 32) = 32
gettimeofday({1136920429, 604513}, NULL) = 0
ioctl(3, FIONREAD, [0])                 = 0
poll([{fd=3, events=POLLIN}, {fd=5, events=POLLIN}, {fd=7, events=POLLIN}], 3, 8
) = 0
gettimeofday({1136920429, 614844}, NULL) = 0
gettimeofday({1136920429, 615309}, NULL) = 0
gettimeofday({1136920429, 615681}, NULL) = 0
gettimeofday({1136920429, 616221}, NULL) = 0
write(3, "\224\3\n\0\37\0\340\2>\0\340\2\0\6@\0P\1\20\0L\0\20\0\30"..., 40) = 40
ioctl(3, FIONREAD, [0])                 = 0
poll([{fd=3, events=POLLIN}, {fd=5, events=POLLIN}, {fd=7, events=POLLIN}], 3, 8
) = 0
gettimeofday({1136920429, 626719}, NULL) = 0
gettimeofday({1136920429, 627157}, NULL) = 0
gettimeofday({1136920429, 627621}, NULL) = 0
ioctl(3, FIONREAD, [0])                 = 0
poll([{fd=3, events=POLLIN}, {fd=5, events=POLLIN}, {fd=7, events=POLLIN}], 3, 2
) = 0
gettimeofday({1136920429, 631692}, NULL) = 0
gettimeofday({1136920429, 631889}, NULL) = 0
ioctl(3, FIONREAD, [0])                 = 0
poll([{fd=3, events=POLLIN}, {fd=5, events=POLLIN}, {fd=7, events=POLLIN}], 3, 4
) = 0
gettimeofday({1136920429, 636651}, NULL) = 0
gettimeofday({1136920429, 637022}, NULL) = 0
ioctl(3, FIONREAD, [0])                 = 0
poll([{fd=3, events=POLLIN}, {fd=5, events=POLLIN}, {fd=7, events=POLLIN}], 3, 0
) = 0
gettimeofday({1136920429, 638675}, NULL) = 0
gettimeofday({1136920429, 639043}, NULL) = 0
write(3, "\224\3\n\0\37\0\340\2>\0\340\2\0\6@\0\240\1\20\0L\0\20"..., 88) = 88
read(3, "\1\1w$\0\0\0\0\"\0`\1\4\0\0\0\0\0\0\0`\"\22\21\310\316"..., 32) = 32
gettimeofday({1136920429, 640595}, NULL) = 0
ioctl(3, FIONREAD, [0])                 = 0
poll([{fd=3, events=POLLIN}, {fd=5, events=POLLIN}, {fd=7, events=POLLIN}], 3, 6
) = 0
gettimeofday({1136920429, 648696}, NULL) = 0
gettimeofday({1136920429, 649209}, NULL) = 0
gettimeofday({1136920429, 649680}, NULL) = 0
ioctl(3, FIONREAD, [0])                 = 0
poll([{fd=3, events=POLLIN}, {fd=5, events=POLLIN}, {fd=7, events=POLLIN}], 3, 9
) = 0
gettimeofday({1136920429, 660689}, NULL) = 0
gettimeofday({1136920429, 661201}, NULL) = 0
gettimeofday({1136920429, 661591}, NULL) = 0
gettimeofday({1136920429, 662125}, NULL) = 0
write(3, "\224\3\n\0\37\0\340\2>\0\340\2\0\6@\0\0\1 \0L\0\20\0\30"..., 40) = 40
ioctl(3, FIONREAD, [0])                 = 0
poll([{fd=3, events=POLLIN}, {fd=5, events=POLLIN}, {fd=7, events=POLLIN}], 3, 0
) = 0
gettimeofday({1136920429, 663890}, NULL) = 0
ioctl(3, FIONREAD, [0])                 = 0
poll([{fd=3, events=POLLIN}, {fd=5, events=POLLIN}, {fd=7, events=POLLIN}], 3, 6
) = 0
gettimeofday({1136920429, 671725}, NULL) = 0
gettimeofday({1136920429, 672160}, NULL) = 0
write(3, ">\3\7\0\223\0\340\2\35\0\340\2>\0\340\2\10\0\0\0p\0\33"..., 48) = 48
read(3, "\1\1{$\0\0\0\0\"\0`\1\4\0\0\0\0\0\0\0\210\"\22\21\310\316"..., 32) = 32
gettimeofday({1136920429, 673671}, NULL) = 0
ioctl(3, FIONREAD, [0])                 = 0
poll([{fd=3, events=POLLIN}, {fd=5, events=POLLIN}, {fd=7, events=POLLIN}], 3, 8
) = 0
gettimeofday({1136920429, 683819}, NULL) = 0
gettimeofday({1136920429, 684354}, NULL) = 0
gettimeofday({1136920429, 685130}, NULL) = 0
gettimeofday({1136920429, 685735}, NULL) = 0
write(3, "\224\3\n\0\37\0\340\2>\0\340\2\0\6@\0P\1 \0L\0\20\0\30"..., 40) = 40
ioctl(3, FIONREAD, [0])                 = 0
poll([{fd=3, events=POLLIN}, {fd=5, events=POLLIN}, {fd=7, events=POLLIN}], 3, 6
) = 0
gettimeofday({1136920429, 693693}, NULL) = 0
gettimeofday({1136920429, 694071}, NULL) = 0
ioctl(3, FIONREAD, [0])                 = 0
poll([{fd=3, events=POLLIN}, {fd=5, events=POLLIN}, {fd=7, events=POLLIN}], 3, 0
) = 0
gettimeofday({1136920429, 695391}, NULL) = 0
write(3, ">\3\7\0\223\0\340\2\35\0\340\2>\0\340\2\t\0\0\0p\0\33\0"..., 48) = 48
read(3, "\1\1\177$\0\0\0\0\"\0`\1\4\0\0\0\0\0\0\0\234\"\22\21\310"..., 32) = 32
gettimeofday({1136920429, 696885}, NULL) = 0
ioctl(3, FIONREAD, [0])                 = 0
poll([{fd=3, events=POLLIN}, {fd=5, events=POLLIN}, {fd=7, events=POLLIN}], 3, 7
) = 0
gettimeofday({1136920429, 704646}, NULL) = 0
gettimeofday({1136920429, 705077}, NULL) = 0
gettimeofday({1136920429, 705467}, NULL) = 0
read(13, 0xbfc5cbd0, 72)                = -1 EAGAIN (Resource temporarily unavai
lable)
gettimeofday({1136920429, 706463}, NULL) = 0
gettimeofday({1136920429, 706870}, NULL) = 0
write(3, "\224\3\n\0\37\0\340\2>\0\340\2\0\6@\0\240\1 \0L\0\20\0"..., 40) = 40
ioctl(3, FIONREAD, [0])                 = 0
poll([{fd=3, events=POLLIN}, {fd=5, events=POLLIN}, {fd=7, events=POLLIN}], 3, 7
) = 0
gettimeofday({1136920429, 716654}, NULL) = 0
gettimeofday({1136920429, 717084}, NULL) = 0
gettimeofday({1136920429, 717749}, NULL) = 0
ioctl(3, FIONREAD, [0])                 = 0
poll([{fd=3, events=POLLIN}, {fd=5, events=POLLIN}, {fd=7, events=POLLIN}], 3, 5
) = 0
gettimeofday({1136920429, 724813}, NULL) = 0
gettimeofday({1136920429, 725203}, NULL) = 0
ioctl(3, FIONREAD, [0])                 = 0
poll([{fd=3, events=POLLIN}, {fd=5, events=POLLIN}, {fd=7, events=POLLIN}], 3, 1
) = 0
gettimeofday({1136920429, 727677}, NULL) = 0
gettimeofday({1136920429, 728107}, NULL) = 0
gettimeofday({1136920429, 728503}, NULL) = 0
write(3, "\224\3\n\0\37\0\340\2>\0\340\2\0\6@\0\0\0010\0L\0\20\0"..., 88) = 88
read(3, "\1\1\204$\0\0\0\0\"\0`\1\4\0\0\0\0\0\0\0\260\"\22\21\310"..., 32) = 32
gettimeofday({1136920429, 730106}, NULL) = 0
ioctl(3, FIONREAD, [0])                 = 0
poll([{fd=3, events=POLLIN}, {fd=5, events=POLLIN}, {fd=7, events=POLLIN}], 3, 7
) = 0
gettimeofday({1136920429, 738727}, NULL) = 0
gettimeofday({1136920429, 739371}, NULL) = 0
gettimeofday({1136920429, 739818}, NULL) = 0
ioctl(3, FIONREAD, [0])                 = 0
poll([{fd=3, events=POLLIN}, {fd=5, events=POLLIN}, {fd=7, events=POLLIN}], 3, 8
) = 0
gettimeofday({1136920429, 749631}, NULL) = 0
gettimeofday({1136920429, 750051}, NULL) = 0
gettimeofday({1136920429, 750438}, NULL) = 0
gettimeofday({1136920429, 750971}, NULL) = 0
write(3, "\224\3\n\0\37\0\340\2>\0\340\2\0\6@\0P\0010\0L\0\20\0\30"..., 40) = 40
ioctl(3, FIONREAD, [0])                 = 0
poll([{fd=3, events=POLLIN}, {fd=5, events=POLLIN}, {fd=7, events=POLLIN}], 3, 3
) = 0
gettimeofday({1136920429, 756655}, NULL) = 0
gettimeofday({1136920429, 757034}, NULL) = 0
ioctl(3, FIONREAD, [0])                 = 0
poll([{fd=3, events=POLLIN}, {fd=5, events=POLLIN}, {fd=7, events=POLLIN}], 3, 2
) = 0
gettimeofday({1136920429, 760727}, NULL) = 0
gettimeofday({1136920429, 761164}, NULL) = 0
write(3, ">\3\7\0\223\0\340\2\35\0\340\2>\0\340\2\v\0\0\0p\0\33\0"..., 48) = 48
read(3, 0xbfc5cc70, 32)                 = -1 EAGAIN (Resource temporarily unavai
lable)
select(4, [3], NULL, NULL, NULL)        = 1 (in [3])
read(3, "\1\1\210$\0\0\0\0\"\0`\1\4\0\0\0\0\0\0\0\330\"\22\21\310"..., 32) = 32
gettimeofday({1136920429, 762656}, NULL) = 0
ioctl(3, FIONREAD, [0])                 = 0
poll([{fd=3, events=POLLIN}, {fd=5, events=POLLIN}, {fd=7, events=POLLIN}], 3, 8
) = 0
gettimeofday({1136920429, 771656}, NULL) = 0
gettimeofday({1136920429, 772090}, NULL) = 0
gettimeofday({1136920429, 772475}, NULL) = 0
gettimeofday({1136920429, 773007}, NULL) = 0
write(3, "\224\3\n\0\37\0\340\2>\0\340\2\0\6@\0\240\0010\0L\0\20"..., 40) = 40
ioctl(3, FIONREAD, [0])                 = 0
poll([{fd=3, events=POLLIN}, {fd=5, events=POLLIN}, {fd=7, events=POLLIN}], 3, 8
) = 0
gettimeofday({1136920429, 783937}, NULL) = 0
gettimeofday({1136920429, 784611}, NULL) = 0
gettimeofday({1136920429, 785288}, NULL) = 0
ioctl(3, FIONREAD, [0])                 = 0
poll([{fd=3, events=POLLIN}, {fd=5, events=POLLIN}, {fd=7, events=POLLIN}], 3, 1
) = 0
gettimeofday({1136920429, 787604}, NULL) = 0
gettimeofday({1136920429, 787976}, NULL) = 0
ioctl(3, FIONREAD, [0])                 = 0
poll([{fd=3, events=POLLIN}, {fd=5, events=POLLIN}, {fd=7, events=POLLIN}], 3, 5
) = 0
gettimeofday({1136920429, 794639}, NULL) = 0
gettimeofday({1136920429, 795069}, NULL) = 0
gettimeofday({1136920429, 795455}, NULL) = 0
write(3, "\224\3\n\0\37\0\340\2>\0\340\2\0\6@\0\0\2\0\0L\0\20\0\30"..., 88) = 88
read(3, "\1\1\215$\0\0\0\0\"\0`\1\4\0\0\0\0\0\0\0\354\"\22\21\310"..., 32) = 32
gettimeofday({1136920429, 796980}, NULL) = 0
ioctl(3, FIONREAD, [0])                 = 0
poll([{fd=3, events=POLLIN}, {fd=5, events=POLLIN}, {fd=7, events=POLLIN}], 3, 7
) = 0
gettimeofday({1136920429, 805779}, NULL) = 0
gettimeofday({1136920429, 806231}, NULL) = 0
gettimeofday({1136920429, 806679}, NULL) = 0
ioctl(3, FIONREAD, [0])                 = 0
poll([{fd=3, events=POLLIN}, {fd=5, events=POLLIN}, {fd=7, events=POLLIN}], 3, 9
) = 0
gettimeofday({1136920429, 817654}, NULL) = 0
gettimeofday({1136920429, 818088}, NULL) = 0
gettimeofday({1136920429, 818473}, NULL) = 0
write(3, "\224\3\n\0\37\0\340\2>\0\340\2\0\6@\0P\2\0\0L\0\20\0\30"..., 88) = 88
read(3, "\1\1\221$\0\0\0\0\"\0`\1\4\0\0\0\0\0\0\0\0#\22\21\310\316"..., 32) = 32
gettimeofday({1136920429, 819992}, NULL) = 0
ioctl(3, FIONREAD, [0])                 = 0
poll( <unfinished ...>

Here i killed it..

~$ 
GLib-WARNING **: g_main_iterate(): main loop already active in another thread

GLib-WARNING **: g_main_iterate(): main loop already active in another thread
XS[src/xmms-sid.c:xs_close:235]: xs_close(): shutting down...
XS[src/xmms-sid.c:xs_stop:584]: STOP_REQ
XS[src/xmms-sid.c:xs_close:248]: shutdown finished.

GLib-WARNING **: g_main_iterate(): main loop already active in another thread

GLib-WARNING **: g_main_iterate(): main loop already active in another thread

GLib-WARNING **: g_main_iterate(): main loop already active in another thread

GLib-WARNING **: g_main_iterate(): main loop already active in another thread

GLib-WARNING **: g_main_iterate(): main loop already active in another thread

GLib-WARNING **: g_main_iterate(): main loop already active in another thread



> > 
> > With ninjam, it is possible to actually get some audio from it (for
> > about 10 seconds), then it goes silent/frozen and jack's watchdog kicks
> > it out after the timeout time has expired. And jackd is taken down with
> > it, too :(
> 
> Any chance to get strace at the stalling position?

I put the complete log file to 

http://affenbande.org/~tapas/ninjam_strace

ca. 2.9M

I hope it helps any at all.. I ran ninjam like this:

strace -o log  cursesclient/cninjam  test.ninjam.com:2049 -audiostr "in jackplug out jackplug"

use username "anonymous" to log in. It seems to block on rt_sigaction
for a bit and then continues. Then blocks again, continues and after a
while it dies and takes jackd with it.

> > I wonder whether cleanly designed this thing would need to have to use
> > an alsa lib calls in the process callback at all. And most of all the
> > write() should be avoided, too. Shouldn't all communication with the
> > pcm_jack's process callback be done via lockless ringbufffers/condition
> > variables?
> 
> Maybe.  The write() there is used just for a poll notification and
> wake-up of the caller of poll.  So, basically we don't need even a
> buffer, but a single condition variable and a simple sleep/wake-up
> mechanism for multi threads.

I see. Please excuse my implying of this thing not being cleanly
designed. I didn't understand the code at all really :)

Regards,
Flo


-- 
Palimm Palimm!
http://tapas.affenbande.org


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
