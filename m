From: "Michael Bourgeous" <sts.nitrogen@gmail.com>
Subject: Jackd dies with snd-usb-usx2y (DRIVER NT error)
Date: Tue, 15 May 2007 13:57:34 -0600
Message-ID: <8e4fc8270705151257i4c11cf53q8128599fe500bf32@mail.gmail.com>
References: <8e4fc8270704260313h31424b42jf41f7a374613d354@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.181])
	by alsa0.perex.cz (Postfix) with ESMTP id 5C39B24889
	for <alsa-devel@alsa-project.org>;
	Tue, 15 May 2007 21:57:35 +0200 (CEST)
Received: by py-out-1112.google.com with SMTP id a25so253471pyi
	for <alsa-devel@alsa-project.org>; Tue, 15 May 2007 12:57:34 -0700 (PDT)
In-Reply-To: <8e4fc8270704260313h31424b42jf41f7a374613d354@mail.gmail.com>
Content-Disposition: inline
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

Hi,

I recently upgraded my system from 32-bit Ubuntu Edgy, with a custom
hard-realtime-enabled 2.6.19 kernel, to 64-bit Ubuntu Feisty, with a
hard-realtime-enabled 2.6.20 kernel.  I also switched from an Athlon
XP 2600 to an Athlon 64 X2 4600.  In every way my new system should be
faster, but jackd+usx2y worked on the last system, and doesn't work
now.

Here's what I'm doing to test the audio setup:

----------
sudo chrt -f 90 `pidof IRQ-23` # usb irq
chrt -v -f 70 jackd -d alsa -dhw:1,2 -p 64 -n 2 # also tried defaults,
and values up to -p 256 -n 8
chrt -v -f 25 zynaddsubfx
----------

After a short time (< 1 or 2 minutes) of switching instruments and
playing notes with zynaddsubfx, all audio stops and jackd dies with
the following error:

----------
ALSA: poll time out, polled for 7998858 usecs
DRIVER NT: could not run driver cycle
jack main caught signal 12
no message buffer overruns
----------

There is a corresponding message in the kernel log:

----------
[12546.132286] ALSA [...]/usx2yhwdeppcm.c:94: activ frame status -70.
Most propably some hardware problem.
----------

I am loading the snd-usb-usx2y module with the nrpacks=1 option.  I've
gone through the Ubuntu HOWTOs I used to get things working on my last
system (to some of which I have even contributed), and I am still
having this problem.

I already tried on alsa-user, so I'm taking this to the developer list
(since I plan to help fix this if anybody will point me in the right
direction).

Additional note:
I tried modifying the source code of the driver, commenting out the
return statement after the "active status" error message.  This began
producing a new error message: "shouldn't be here with count=xx".  So,
I commented out the "return -EPIPE" after that error message, and now
jackd doesn't crash.  There are noticeable audio clicks whenever one
of these errors occurs, but the driver seems to have no problem
recovering, as audio continues.

This error happens with the stock Ubuntu kernels as well.

Thanks in advance,
Mike Bourgeous
