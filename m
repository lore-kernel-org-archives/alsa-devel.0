From: Louise Hoffman <louise.hoffman@gmail.com>
Subject: =?windows-1252?q?Warning/error_from_ALSA=92s_pcm=5Fm?=
	=?windows-1252?q?in=2Ec_example=2E_Possible_problem=3F?=
Date: Sat, 30 Jan 2010 20:51:28 +0100
Message-ID: <30c82f5f1001301151r6de4761fh9453829c1af85e15@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.149])
	by alsa0.perex.cz (Postfix) with ESMTP id B1AD4103807
	for <alsa-devel@alsa-project.org>; Sat, 30 Jan 2010 20:51:29 +0100 (CET)
Received: by ey-out-1920.google.com with SMTP id 13so571066eye.0
	for <alsa-devel@alsa-project.org>; Sat, 30 Jan 2010 11:51:29 -0800 (PST)
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

Dear ALSA developers,

When I compile ALSA's pcm_min.c[0] example with

gcc -Wall -lasound pcm_min.c -o pcm_min

Everything is fine, but running it, I get the white noise as expected,
but I also get this warning/error:

Short write (expected 16384, wrote 7616)

Which comes from the last if-statement.

One bug is in this line

                frames = snd_pcm_writei(handle, buffer, sizeof(buffer));

where "sizeof(buffer)" should be "number of frames in the buffer".

But there are still some strange things going on. I still get those
errors, and if I remove the for-loop, nothing is played.

Here is my code. [1]

Can someone see what's wrong?

Hugs,
Louise


[0] http://www.google.com/codesearch/p?hl=en&sa=N&cd=1&ct=rc#4FSOSMZ6Pxc/distfiles/alsa-lib-1.0.14rc2.tar.bz2|ZScnKi-LryE/alsa-lib-1.0.14rc2/test/pcm_min.c&q=pcm_min.c

[1] http://pastebin.com/m2f28b578
