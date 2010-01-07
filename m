From: "Max Klein" <mein_name@ist-einmalig.de>
Subject: Re: playback delay and problems with
	simultaneous	playback/capture
Date: Thu, 07 Jan 2010 16:49:54 +0100
Message-ID: <20100107154954.319460@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 6C3232459E
	for <alsa-devel@alsa-project.org>; Thu,  7 Jan 2010 16:49:58 +0100 (CET)
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

concerning the first point, I did some measurements...
the file I used has a length of 1488 ms

trigger start jiffies=7466937
trigger stop  jiffies=7468172
difference = 1235 (1235 ms)

pcm prepare jiffies 2=6761125
trigger start jiffies=6761126
trigger stop  jiffies=6762361
difference = 1235 (1235 ms)
trigger stopped, buffer empty, stop decoder jiffies=6762684
difference = 323 (323 ms)

so I was wondering, why the difference between trigger start - stop
is not 1488ms but 1235ms. I still guess that it may is a wrongly updated
pcm pointer?

Thanks for your help,
Max
-- 
Jetzt kostenlos herunterladen: Internet Explorer 8 und Mozilla Firefox 3.5 -
sicherer, schneller und einfacher! http://portal.gmx.net/de/go/atbrowser
