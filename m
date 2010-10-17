From: Julian Scheel <julian@jusst.de>
Subject: Re: USB asynchronous mode feedback format
Date: Sun, 17 Oct 2010 12:53:07 +0200
Message-ID: <201010171253.08023.julian@jusst.de>
References: <1287046026.4cb6c38a2a179@discus.singnet.com.sg>
	<201010161830.31603.julian@jusst.de>
	<201010162052.03180.julian@jusst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp2.work.de (smtp.work.de [212.12.45.188])
	by alsa0.perex.cz (Postfix) with ESMTP id 05B5C244BA
	for <alsa-devel@alsa-project.org>;
	Sun, 17 Oct 2010 12:53:11 +0200 (CEST)
In-Reply-To: <201010162052.03180.julian@jusst.de>
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
Cc: Clemens Ladisch <clemens@ladisch.de>, Alex Lee <lee188@singnet.com.sg>, Daniel Mack <daniel@caiaq.de>
List-Id: alsa-devel@alsa-project.org

Am Samstag, 16. Oktober 2010, 20:52:02 schrieb Julian Scheel:
> Anyway, as 3 byte feedback sending works, it might be worth to test the
> 10.14 patch by Clemens to see if the feedback loop itself is working
> properly then. Can you point me to that patch? Is it already commited to
> current head?

With the patch applied the feedback setting works perfectly fine! Now I just 
need to tweak my feedback loop to behave well.
But generally asynchronous transmission works as expected now! Thanks a lot 
for the help!
Will probably come back with some more questions (c:

-Julian
