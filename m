From: Tobias Schneider <tobsnyder@gmx.de>
Subject: Re: overrun in second capture device after stopping
 first capture device
Date: Fri, 29 Jan 2010 19:12:46 +0100
Message-ID: <4B63251E.7080403@gmx.de>
References: <4B584B38.9030000@gmx.de> <4B5EFAC7.6050402@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 2B523103906
	for <Alsa-devel@alsa-project.org>; Fri, 29 Jan 2010 19:12:51 +0100 (CET)
In-Reply-To: <4B5EFAC7.6050402@gmx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tobias Schneider <tobsnyder@gmx.de>
Cc: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I am still searching what causes the problem, I now figured out that the 
underruns occur because appl_ptr = hw_ptr - so this is because appl_ptr 
is not moved forward. Are there any reasons for this?

<7>DEBUG: p1 hw_ptr=0x3cdd43 (3988803) appl_ptr=0x3cebbc (3992508) 
jiffie=21775142
<7>DEBUG: p1 hw_ptr=0x3ce028 (3989544) appl_ptr=0x3ceea1 (3993249) 
jiffie=21775165
<7>DEBUG: p1 hw_ptr=0x3ce30d (3990285) appl_ptr=0x3cf186 (3993990) 
jiffie=21775188
<7>DEBUG: p1 hw_ptr=0x3ce5f2 (3991026) appl_ptr=0x3cf46b (3994731) 
jiffie=21775212
<7>DEBUG: p1 hw_ptr=0x3ce8d7 (3991767) appl_ptr=0x3cf750 (3995472) 
jiffie=21775235
<7>DEBUG: p1 hw_ptr=0x3cebbc (3992508) appl_ptr=0x3cf750 (3995472) 
jiffie=21775258
<7>DEBUG: p1 hw_ptr=0x3ceea1 (3993249) appl_ptr=0x3cf750 (3995472) 
jiffie=21775281
<7>DEBUG: p1 hw_ptr=0x3cf186 (3993990) appl_ptr=0x3cf750 (3995472) 
jiffie=21775304
<7>DEBUG: p1 hw_ptr=0x3cf46b (3994731) appl_ptr=0x3cf750 (3995472) 
jiffie=21775328
<7>DEBUG: p1 hw_ptr=0x3cf750 (3995472) appl_ptr=0x3cf750 (3995472) 
jiffie=21775351
<3>ERROR: p1 XRUN B! avail = 4446  stop_threshold = 4446 jiffie_diff=23
<7>DEBUG: playback trigger (1): cmd=stop
<7>DEBUG: trigger stop jiffies=21775351
<7>DEBUG: trigger stop jiffies difference =124742
<7>DEBUG: - pcm_timer_stop
<7>DEBUG: pcm prepare

I will go on searching for the reason, but I am thankful for any hint...
