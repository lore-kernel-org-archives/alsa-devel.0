From: jack craig <jackc@linuxlighthouse.com>
Subject: pulseaudio workaround for alsa-driver bug
Date: Tue, 28 Jul 2009 11:46:55 -0700
Message-ID: <4A6F479F.7080804@linuxlighthouse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from linuxlighthouse.com (gate.linuxlighthouse.com [63.249.90.144])
	by alsa0.perex.cz (Postfix) with ESMTP id 61F562471F
	for <alsa-devel@alsa-project.org>;
	Tue, 28 Jul 2009 20:46:59 +0200 (CEST)
Received: from ws.linuxlighthouse.com (ws.linuxlighthouse.com [192.168.2.20])
	(authenticated bits=0)
	by linuxlighthouse.com (8.14.3/8.14.3) with ESMTP id n6SIktRF010679
	for <alsa-devel@alsa-project.org>; Tue, 28 Jul 2009 11:46:56 -0700
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

Hi alsa-developers,

I wanted to report my recent issues with audio on fc11.

after an update from fc10, my audio started failing. not the failure to 
year any audio,
but instead, it would start off fine and then tail spin. i am using 
mplayer to
play an internet asf stream to the local audio.

the stream processing failure is described in 
https://bugzilla.redhat.com/show_bug.cgi?id=514213

i was able to get a workaround from the #pulseaudio guys, but!

they encouraged me to report my experience and its fix to you to 
encourage the fix of this snd_pcm_delay() defect.

if you get a driver fix for this, i am happy to try it out when its ready.

thx, jackc...

-- 
    jack craig
       jackc@LinuxLightHouse.com
          831-684-1375 (Office)
             831-596-6924 (cell)
                IM: jackcraigaptos (AIM)

_________________________________
This email has been ClamScanned !
     www.LinuxLightHouse.com
