From: John Rigg <ad@sound-man.co.uk>
Subject: ice1712 - cannot set channel count
Date: Tue, 15 Nov 2005 17:08:52 +0000
Message-ID: <E1Ec4Ie-0001Da-QO@localhost.localdomain>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
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

Hi

Sorry to send this to the list and not bugtrack, but the bugtrack system
won't let me log in.

The channel count on ice1712 cannot be set by jackd to anything except
maximum, ie. 12 for capture and 10 for playback.
For example:
`jackd -d alsa -d -C -i12 -P -o10 hw:0' (equivalent to jackd -d alsa -d hw:0)
works, but 
`jackd -d alsa -d -C -i8 hw:0' results in the following message:
ALSA: cannot set channel count to 8 for capture

This isn't a problem with only one ice1712 card because jackd can run it in 
duplex mode despite different channel count for capture and playback.

However, this completely disables the use of duplex mode when two or
more ice1712s are combined using the pcm multi plugin in .asoundrc.
This requires the slaves channel count to be defined explicitly, eg.
	slaves.a.pcm hw:0
	slaves.a.channels 12
	slaves.b.pcm hw:1
	slaves.b.channels 12
This works, but only for capture. Changing the channel count to 10 only works
for playback. No other numbers work at all, and there doesn't appear to be
any way of defining different channel counts for capture and playback.

The docs say that channel count can be set to anything up to maximum
(which is default). They also say that the number of slaves channels in
multi definition can be set to any number up to maximum.
I should be able to define one multi device with say 10 slaves channels
per card, and one set of bindings, and have it work in duplex mode.

Setup is 2.6.14rt6 x86_64 SMP kernel (alsa-driver-1.0.10rc1) with
alsa-lib-1.0.10-rc2 and jack 0.100.7 with MMAP_COMPLEX patch,
running on Debian unstable amd64.

John


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
