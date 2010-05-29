From: "Berg.Tian" <txftxf@gmail.com>
Subject: How to support software mixing on QUALCOMM 72XX
	without mmap?
Date: Sat, 29 May 2010 15:03:54 +0800
Message-ID: <AANLkTilDwF8pyOxanDyiG9ubcwvXAGA0X-1MzGl5ElLn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 82EC4244E0
	for <alsa-devel@alsa-project.org>;
	Sat, 29 May 2010 09:03:57 +0200 (CEST)
Received: by vws16 with SMTP id 16so1475707vws.38
	for <alsa-devel@alsa-project.org>; Sat, 29 May 2010 00:03:54 -0700 (PDT)
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

Hello,guys.
     I'm porting ASLA1.0.23 to qualcomm 72xx base on ARM11.
     The first instance,"aplay test.wav", works now, but the second
instance should fail with "device busy" error message.
     I have tried plug dmix and dshare "aply -D plug:mycard
test.wav", but met a fail again for the soc chip doesn't support mmap.
Of course,pcm_mycard is defined in /etc/asound.conf.
     In my pc ,both above cmds work well .

     Though,the document shows that:
        NOTE: For ALSA 1.0.9rc2 and higher you don't need to setup
dmix for analogue output. Dmix is enabled by default for soundcards
which don't support hardware mixing. You still need to set it up for
digital outputs.
     My questions are:
         1)Is  software mixing  implemented in ALSA Driver,or in ALSA LIB?
         2)What could I do to make the software mixing work? Is there
any special configure which need to adjust?

     And when testing on pc whth HD audio, I noticed that
      A)when aplay instances runs WITHOUT dmix, the result of"cat
/etc/one_of_my_aplay_pid/maps" should like:
                     ...
                     b331d000-b731e000 rw-s 00000000 00:15 862346
/dev/shm/pulse-shm-2882420837
                     ...
     B)when aplay instances runs  WITH dmix,the result is:
                  ...
                  b7511000-b7519000 rw-s 00000000 00:0f 4560
/dev/snd/pcmC0D0p
                  b7519000-b751a000 rw-s 81000000 00:0f 4560
/dev/snd/pcmC0D0p
                  b751a000-b751b000 r--s 80000000 00:0f 4560
/dev/snd/pcmC0D0p
                  ...
     So,the third question:
         3) From A) and B),can I make a result that the mmap feacture
is not necessary for the buildin software mixing ?

     Expect your help,please

    berg
