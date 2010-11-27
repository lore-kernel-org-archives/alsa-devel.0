From: Amit Nagal <helloin.amit@gmail.com>
Subject: reset of kernel input buffer for /dev/dsp
Date: Sat, 27 Nov 2010 21:33:43 +0900
Message-ID: <AANLkTi=EzbQc__Z+4JCrMNbGpWoKWKmyX+BFhuLcKt7T@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
	[209.85.216.51]) by alsa0.perex.cz (Postfix) with ESMTP id 42DCB2445F
	for <alsa-devel@alsa-project.org>; Sat, 27 Nov 2010 13:33:47 +0100 (CET)
Received: by qwd7 with SMTP id 7so407864qwd.38
	for <alsa-devel@alsa-project.org>; Sat, 27 Nov 2010 04:33:43 -0800 (PST)
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
Cc: alsa-user@lists.sourceforge.net, tiwai@suse.de, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Hi ,

i am doing usb audio streaming using usb audio class interface .

our application is OSS based , uses OSS calls to interact with linux
audio driver .

Our device is capture only device .

we want to flush  kernel input pcm buffer  without using close() system call .

does OSS supports in userspace any ioctl call which can flush kernel
pcm buffer at any time .

right now we have to close audio-fd  and open audio-fd  again .

how we can flush  kernel input pcm buffer  without using close system
call in based OSS application

regards
Amit Nagal
