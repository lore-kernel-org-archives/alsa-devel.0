From: David Topper <topper@virginia.edu>
Subject: Problem with ncurses and alsamixer (cannot open
 terminal: vt100 or xterm)
Date: Sat, 02 Jun 2007 16:34:12 -0400
Message-ID: <4661D444.4090006@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fork4.mail.virginia.edu (fork4.mail.Virginia.EDU
	[128.143.2.194]) by alsa0.perex.cz (Postfix) with ESMTP id 36CFF243B9
	for <alsa-devel@alsa-project.org>;
	Sat,  2 Jun 2007 22:32:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by fork4.mail.virginia.edu (Postfix) with ESMTP id 4262911B0A2
	for <alsa-devel@alsa-project.org>; Sat,  2 Jun 2007 16:32:31 -0400 (EDT)
Received: from fork4.mail.virginia.edu ([127.0.0.1])
	by localhost (fork4.mail.virginia.edu [127.0.0.1]) (amavisd-new,
	port 10024) with ESMTP id 29965-08 for <alsa-devel@alsa-project.org>;
	Sat,  2 Jun 2007 16:32:31 -0400 (EDT)
Received: from [128.143.140.146] (pawn.music.Virginia.EDU [128.143.140.146])
	by fork4.mail.virginia.edu (Postfix) with ESMTP id 9467511B097
	for <alsa-devel@alsa-project.org>; Sat,  2 Jun 2007 16:32:30 -0400 (EDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I finally managed to get the alsa-1.0.4 utils to compile on an ARM based 
SBC.  When I launch alsamixer, however, I get an error:

Error opening terminal:  xterm

When I ssh into the board.  Or:

Error opening terminal:  vt100

When connected via serial cable.

I suspect this has something to do with the linking (or lack thereof) of 
alsamixer for ncurses.  The ncurrses library, by the way, I cross 
compiled with the following command:

CC=/opt/crosstool/arm-unknown-linux-gnu/gcc-3.3.4-glibc-2.3.2/bin/arm-unknown-linux-gnu-gcc 
./configure --host=arm-linux --prefix=/home/topper/ts-packages/ 
--exec-prefix=/home/topper/ts-packages/

But for the alsa utils, I simple ran ./configure, and the script 
detected the ncurses library, ran through and compiled.  Yet, something 
seems amuck because:

root@ts7000:root# ldd /bin/alsamixer
        libasound.so.2 => /lib/libasound.so.2 (0x2aac8000)
        libm.so.6 => /lib/libm.so.6 (0x2ab6f000)
        libdl.so.2 => /lib/libdl.so.2 (0x2abe9000)
        libpthread.so.0 => /lib/libpthread.so.0 (0x2abf3000)
        libc.so.6 => /lib/libc.so.6 (0x2ac4b000)
        /lib/ld-linux.so.2 => /lib/ld-linux.so.2 (0x2aaab000)

Whereas on my Linux Intel laptop:

awn:~$ ldd /usr/bin/alsamixer
        libncurses.so.5 => /lib/libncurses.so.5 (0x4002c000)
        libasound.so.2 => /usr/lib/libasound.so.2 (0x40069000)
        libm.so.6 => /lib/libm.so.6 (0x4010d000)
        libdl.so.2 => /lib/libdl.so.2 (0x40130000)
        libpthread.so.0 => /lib/libpthread.so.0 (0x40133000)
        libc.so.6 => /lib/libc.so.6 (0x40184000)
        /lib/ld-linux.so.2 => /lib/ld-linux.so.2 (0x40000000)

So I have two questions:

1.  How might ensure proper linking of the ncurses library.
2.  Is there another way to tell alsa to activate various cards, set 
volume, etc.. so I can test to see if the alsa driver is even working on 
this board.

Thanks,

Dave Topper

-- 
Technical Director - Virginia Center for Computer Music
http://www.virginia.edu/music/VCCM/
