From: Frank Barknecht <fbar@footils.org>
Subject: Re: Problems running latencytest: "error setting freq 1024"
Date: Wed, 24 Mar 2004 18:21:08 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040324172107.GC5800@fliwatut.scifi>
References: <20040323205352.GA3246@fliwatut.scifi> <200403232133.i2NLXCZt015035@dhin.linuxaudiosystems.com> <20040323214205.GA4382@fliwatut.scifi> <s5hn0661jw7.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp2.netcologne.de (smtp2.netcologne.de [194.8.194.218])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id SAA28969
	for <alsa-devel@alsa-project.org>; Wed, 24 Mar 2004 18:21:40 +0100
Received: from fliwatut.scifi (xdsl-213-196-220-41.netcologne.de [213.196.220.41])
	by smtp2.netcologne.de (Postfix) with ESMTP id 6C3623AC77
	for <alsa-devel@alsa-project.org>; Wed, 24 Mar 2004 18:21:08 +0100 (MET)
Received: from freak by fliwatut.scifi with local (Exim 3.36 #1 (Debian))
	id 1B6C3w-0001pg-00
	for <alsa-devel@alsa-project.org>; Wed, 24 Mar 2004 18:21:08 +0100
Content-Disposition: inline
In-Reply-To: <s5hn0661jw7.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hallo,
Takashi Iwai hat gesagt: // Takashi Iwai wrote:

> At Tue, 23 Mar 2004 22:42:05 +0100,
> Frank Barknecht wrote:
> > mlockall(MCL_CURRENT|MCL_FUTURE)        = 0
> > sched_get_priority_max(0x1)             = 99
> > sched_setscheduler(0, 0x1, 0xbfffe254)  = 0
> > open("/dev/midi0", O_RDWR)              = 3
> > ioctl(3, 0x40047401, 0x400)             = -1 ENOTTY (Inappropriate ioctl for device)
> > write(2, "error setting freq 1024\n", 24) = 24
> > exit_group(1)                           = ?
> 
> please make sure that you loaded latency-test module.

Yes, it is loaded.

> > I'm still puzzled. Why "/dev/midi0"?
> 
> that's because the latency-test kernel module requires a device file
> for ioctls.  i chose it simply because the file is unused (it's for
> tclmidi).

Maybe that is my problem. Here, /dev/midi is a link to /dev/midi0:
$ ls -l /dev/midi
lrwxrwxrwx    1 root     root           10 Jul 30  2003 /dev/midi -> /dev/midi0
$ ls -l /dev/midi0
crw-rw----    1 root     audio     14,   2 Jul 30  2003 /dev/midi0

I don't know why it is set up this way, but on another machine I can
ssh to it looks different: 

$ ls -l /dev/midi
lrwxrwxrwx    1 root     root            6 May 27  2003 /dev/midi ->
midi00
$ ls -l /dev/midi0
crw-rw-rw-    1 root     audio     35,   0 Mar 14  2003 /dev/midi0

Here I get the device number 35 for midi0, and another symlink.

Did I mess up big time?

ciao
-- 
 Frank Barknecht                               _ ______footils.org__


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
