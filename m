From: "John S. Denker" <jsd@monmouth.com>
Subject: sb16 gets wedged when doing overlapped i/o (full duplex)
Date: Thu, 05 Dec 2002 05:47:51 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DEF2ED7.7000808@monmouth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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

	==== This is a slightly-updated clone of item
	#648232 on the sourceforge bug/patch reporting
	system.  I'm moving it to here (the alsa-devel
	mailing list) at the request of Jaroslav. ====

Things run OK for a few minutes (sometimes 30 seconds,
sometimes 5+ minutes) then ALSA gets wedged.  Every read or
write results in an error.  This only happens when I'm doing
overlapped i/o; pure input runs happily for hours, and
although I haven't tried it I assume pure output works fine.

I observe this on two different machines using two different
models of card (classic sb16 PnP and sb32awe).

This is clearly a driver problem, not a problem in my
program, because when the ALSA system gets wedged, it stays
wedged.  If I kill and restart the program while things are
wedged, it puts out what sounds like one buffer of audio and
then gets nothing but errors.  There is a ten-second pause
associated with each error.  Then, if I do init.d/alsactl
restart, i.e. unload and reload the modules, we are back
where we started: things will run fine for a few minutes.

I'm doing stereo * 44100 frames per second * two
directions. The same pattern of i/o on a different machine
(faster cpu) with a different driver (snd-intel8x0) works
fine.

I observe the same problems with rc6 and also with
9.0beta11, so the problem has been lurking there for quite a
while.

The message (under rc6) is:
ALSA lib pcm_hw.c:428:(snd_pcm_hw_prepare)
SNDRV_PCM_IOCTL_PREPARE failed: Device or resource busy

The message is the same for beta11, except line 349.

Once it gets wedged, writes and reads both fail, with the
same message.

Because the runtime before failure is far from constant, I
suspect some sort of race condition. I tried varying the
load on the machine. I intermittently imposed enough load to
cause the application to suffer underruns, but this had no
discernible effect on the incidence of the wedge problem.

Further experiments tend to suggest that lowering the
frame-rate from 44100 to 22050 decreases the incidence of
the wedge problem by roughly a factor of two.  I suspect
most people don't do overlapped i/o at 44100 fps, which may
explain why the bug hasn't been reported before.

References, possibly related, possibly not:
http://www.mail-archive.com/alsa-user@lists.sourceforge.net/msg02194.html
http://www.mail-archive.com/alsa-devel@lists.sourceforge.net/msg05183.html
http://www.mail-archive.com/alsa-devel@lists.sourceforge.net/msg05195.html



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
