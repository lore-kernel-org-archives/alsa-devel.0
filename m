From: Robert Gonciarz <ruppertus@gmail.com>
Subject: snd-hda-intel AD1981 - Sound volume low level
Date: Mon, 18 Feb 2008 20:50:00 +0100
Message-ID: <47B9E168.8050504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.168])
	by alsa0.perex.cz (Postfix) with ESMTP id 9B484244DB
	for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2008 20:51:51 +0100 (CET)
Received: by ug-out-1314.google.com with SMTP id q2so829971uge.50
	for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2008 11:51:50 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi, I just want to ask you if you have heard about the problem with low 
sound volume level even though you set the alsamixer on the (almost) 
maximum volume level. The sound card: snd-hda-intel / AD1981 / ICH7 )

It's a big problem for me especially when I watch a movie with
ac3 (DVD quality) decoded sound. The volume level is extrimly low in
such situation (I mean the level you hear the sound). I have to connect 
my loudspeakers to a ampilifier and set it in very high level.

I don't have such problem when I work with Windows XP. They are loud enough.

That's alsa-info.sh result: http://pastebin.ca/908831

It is said that there are some preferences in the totem package (hidden 
in alsamixer) that can fix it and make alsa to remember higher sound level.

I've noticed that problem with all kernels I tested (I've checked about 
15-20 kernels from that range 2.6.13.x - 2.6.24.x) (I usually
use vanillia kernel (from www.kernel.org) /with build alsa/). But I've 
tested the newest alsa-drivers: 1.0.16 with 2.6.24.2 kernel also and the 
result was the same.

Could you chack that problem, please?

Robert
