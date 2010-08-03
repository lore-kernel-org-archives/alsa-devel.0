From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Device name hints and the value of DEV
Date: Tue, 3 Aug 2010 18:56:30 +0300
Message-ID: <201008031856.30100.anssi.hannula@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tulikuusama.dnainternet.net (tulikuusama.dnainternet.net
	[83.102.40.132]) by alsa0.perex.cz (Postfix) with ESMTP id C50E724431
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Aug 2010 17:56:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by tulikuusama.dnainternet.net (Postfix) with ESMTP id 3612A2C946
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Aug 2010 18:56:32 +0300 (EEST)
Received: from tulikuusama.dnainternet.net ([83.102.40.132])
	by localhost (tulikuusama.dnainternet.net [127.0.0.1]) (amavisd-new,
	port 10041)
	with ESMTP id TSGvaRvg6VBw for <alsa-devel@alsa-project.org>;
	Tue,  3 Aug 2010 18:56:32 +0300 (EEST)
Received: from omenapuu.dnainternet.net (omenapuu.dnainternet.net
	[83.102.40.212])
	by tulikuusama.dnainternet.net (Postfix) with ESMTP id 119AD2C948
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Aug 2010 18:56:32 +0300 (EEST)
Received: from mail.onse.fi (unknown [109.204.162.131])
	by omenapuu.dnainternet.net (Postfix) with ESMTP id 04DEF2BAE3
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Aug 2010 18:56:30 +0300 (EEST)
Received: from sigma.onse.fi (sigma [10.0.0.8])
	by mail.onse.fi (Postfix) with ESMTP id 9CE3E10DE4BF
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Aug 2010 18:56:30 +0300 (EEST)
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

Hi all!

I was confused as to why on one of my boxes "aplay -L" says
hdmi:CARD=NVidia,DEV=0
and on another it says
hdmi:CARD=NVidia

I looked into it, and saw that namehint.c:add_card() loops through the pcm 
device numbers using snd_ctl_pcm_next_device(), and then proceeds in 
try_config() to append ',DEV=device_number' to the device name.

However, in reality DEV does not match the device number, as e.g. DEV=0 may 
mean the '0' in HDA-Intel.pcm.hdmi.0, and the slave pcm of that is device 3, 
not device 0.

If there is no device 0 on the NVidia card, the 'hdmi:CARD=NVidia,DEV=0' entry 
is never added (instead the one without ",DEV=0" is), even though these are 
not really related..


Now, I don't have a good understanding of all the code in namehint.c, but 
surely the occupied device numbers should not have any side-effects like this?

-- 
Anssi Hannula
