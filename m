From: Leonid <leonopulos@gmail.com>
Subject: Re: [Alsa-devel] how to cross compile the alsa util?
Date: Fri, 04 Feb 2011 16:05:10 +0300
Message-ID: <4D4BF986.8030603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 752E7103AF6
	for <alsa-devel@alsa-project.org>; Fri,  4 Feb 2011 14:05:05 +0100 (CET)
Received: by fxm5 with SMTP id 5so2323049fxm.38
	for <alsa-devel@alsa-project.org>; Fri, 04 Feb 2011 05:05:05 -0800 (PST)
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

Hello alls:
Please help.
I also cross compiled alsa utils trhough CodeSourcery:

PATH=$PATH:/opt/arm-2007q1/bin
CC=arm-none-linux-gnueabi-gcc ./configure --host=i686-pc-linux-gnu \
      --target=arm-none-linux-gnueabi \
      --with-alsa-prefix=/usr/lib \
      --with-alsa-inc-prefix=/usr/include/alsa

configure out...

--cut
checking for ncursesw5-config... yes
checking for curses library... ncursesw
checking for curses header name...<ncurses.h>
checking for curses compiler flags... -I/usr/include/ncursesw
checking for curses NLS support... yes
checking for sys/types.h... yes
checking for sys/stat.h... yes
checking for stdlib.h... yes
checking for string.h... yes
checking for memory.h... yes
checking for strings.h... yes
checking for inttypes.h... yes
checking for stdint.h... yes
checking for unistd.h... yes
checking panel.h usability... no
checking panel.h presence... no
checking for panel.h... no
configure: error: required curses helper header not found

but libncursesw5 and aibncursesw5-dev is installed to host:

more...

I changet the configuration and add option --with-curses=ncurses 
(libncurses5-dev also installed):
PATH=$PATH:/opt/arm-2007q1/bin
CC=arm-none-linux-gnueabi-gcc ./configure --host=i686-pc-linux-gnu \
      --target=arm-none-linux-gnueabi \
      --with-alsa-prefix=/usr/lib \
      --with-alsa-inc-prefix=/usr/include/alsa \
      --with-curses=ncurses
out...

--cut
checking for ncurses5-config... yes
checking for curses library... ncurses
checking for curses header name...<ncurses.h>
checking for curses compiler flags...
checking for curses NLS support... no
checking for sys/types.h... yes
checking for sys/stat.h... yes
checking for stdlib.h... yes
checking for string.h... yes
checking for memory.h... yes
checking for strings.h... yes
checking for inttypes.h... yes
checking for stdint.h... yes
checking for unistd.h... yes
checking panel.h usability... no
checking panel.h presence... no
checking for panel.h... no
configure: error: required curses helper header not found

the same effect.

what am i doing wrong?
can  be  cross  compiled  ncurses?

-- 
with best wishes
Leonid

On Mon, 31 May 2004, Roc Wu wrote:

>  Hello alls:
>
>  Sorry for post the mail again. I posted it several
>  days ago, but no response. Anybody can give me some
>  hints?
>
>  I cross compiled the alsa-lib-1.04 to arm platform.
>  The 2.6.6 kernel including alsa driver is ok on our
>  ARM board, so I want to test the driver. how to do it?
>
>  I think maybe the first step is to crosscompile the
>  alsa utils to play a wave audio file.
>
>  CC=arm-linux-gcc ./configure --host=i686-linux
>  --target=arm-linux

./configure --help

--- cut ---
   --with-alsa-prefix=PFX  Prefix where Alsa library is installed 
(optional)
   --with-alsa-inc-prefix=PFX  Prefix where include libraries are 
(optional)
--- cut ---

                                                 Jaroslav

-----
Jaroslav Kysela<[EMAIL PROTECTED]>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs
