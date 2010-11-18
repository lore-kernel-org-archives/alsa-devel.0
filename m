From: Radivoje Jovanovic <radivojejovanovic@gmail.com>
Subject: trigger_stop and buffer overrun
Date: Thu, 18 Nov 2010 08:59:07 -0800
Message-ID: <AANLkTi=vVFDbeLgoy-wRWtzOQanmBTLDLkoaxrUciJj9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51])
	by alsa0.perex.cz (Postfix) with ESMTP id C19AF1037F2
	for <alsa-devel@alsa-project.org>; Thu, 18 Nov 2010 17:59:10 +0100 (CET)
Received: by yws5 with SMTP id 5so2228359yws.38
	for <alsa-devel@alsa-project.org>; Thu, 18 Nov 2010 08:59:09 -0800 (PST)
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

Is there anu way to tell what is the last position in the buffer filled by
ALSA during the trigger stop callback? The hardware I have is playing sound
but if I turn the DMA off when trigger_stop is executed I will not hear the
end of the file at all. It seems to me that I would have to setup the
hardware to stop playing at the specific address.
On the other hand if I play longer sounds or a song I notice that the song
is skipping a lot and 1 minute sample is over in 20 seconds so it seems to
me that the buffer is overflowing. the pointer callback reads correctly the
current DMA position from the hardware so I am confused how the overflow
happens. Is there any other way ALSA tracks the position where to write the
data?
cheers
