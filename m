From: "Xiaoyong Wen" <wen_kernel@163.com>
Subject: Recording sound from microphone isn't good working
	that playback sound is distortion.
Date: Tue, 31 Jul 2012 15:00:16 +0800
Message-ID: <201207311500149537558@163.com>
Reply-To: wen_kernel@163.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from m50-133.163.com (m50-133.163.com [123.125.50.133])
 by alsa0.perex.cz (Postfix) with ESMTP id DA195265CD6
 for <alsa-devel@alsa-project.org.>; Tue, 31 Jul 2012 09:03:05 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
Cc: linux-kernel-cn <kernel@vger.linux-kernel.cn>
List-Id: alsa-devel@alsa-project.org

Hi, alsa-devel
		 Platform: S3C6410, WM9713G codec with AC'97, Linux kernel 2.6.36.  ALSL 1.0.23 lib and utils.
         Test process:
		 1. aplay WAV file is good working
		 #aplay -D 'hw:0,0' -c 2 /opt/music.wav

		 2. arecord WAV file from Line in is good working.
		#arecord -D 'hw:0,0' -r 48000 -f S16_LE -c 2 | aplay -D 'hw:0,0' -c 2 &

		 3. Recording sound from microphone isn't good working that playback sound is distortion. 
		 #arecord -D 'hw:0,0' -r 48000 -f S16_LE -c 2 | aplay -D 'hw:0,0' -c 2 &
		 or
		 #arecord -d 10 -fdat test2.wav
		 I hear the sound is very distortion and low.
	     ~~~~~~~~~~~~~~~~~~~~~~~~~~
		 If I excute "amixer cset numid=9 3; amixer cset numid=7 31; amixer cset numid=87 on; amixer cset numid=6 31,31" command, and then volume is high.
		Please help me to fix up this bug, thanks.
		
Best regards.
Xiaoyong Wen, <wen_kernel@163.com>, 2012-07-31, 14:46:17. 
