From: Devin Heitmueller <dheitmueller@kernellabs.com>
Subject: Use of default device with snd_pcm_link()
Date: Sun, 27 Dec 2009 19:59:28 -0500
Message-ID: <829197380912271659k5b9fd29aj3927fda3a1001874@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f212.google.com (mail-fx0-f212.google.com
	[209.85.220.212])
	by alsa0.perex.cz (Postfix) with ESMTP id 28EFF243F1
	for <alsa-devel@alsa-project.org>; Mon, 28 Dec 2009 01:59:29 +0100 (CET)
Received: by fxm4 with SMTP id 4so32105473fxm.32
	for <alsa-devel@alsa-project.org>; Sun, 27 Dec 2009 16:59:29 -0800 (PST)
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

I am working on some code which captures from one PCM device and plays
to another, based off of the latency.c found in alsa-lib.  I noticed
something strange:

The code works if I set the capture device to hw:1,0 and playback
device to hw:0,0.  However, if I change the playback device to
"default:0", the snd_pcm_link() call fails with -ENOSYS (error 38).

If I dump out the properties, I can see that the the default device
*is* mapped to device 0,0, so it's not clear why the behaviour would
differ.

My goal was just to playback to whatever the default device is, and I
was under the impression that default:0 should be equivalent to
"hw:0,0".  Can anyone offer any brief explanation as to why the
snd_pcm_link() call would fail?

Thanks in advance,

Devin

-- 
Devin J. Heitmueller - Kernel Labs
http://www.kernellabs.com
