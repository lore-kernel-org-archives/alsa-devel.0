From: gilbr <gilbux@free.fr>
Subject: Re: Dev: Alsa sequencer problem (Why ???)
Date: Mon, 15 Sep 2008 09:32:22 +0000 (UTC)
Message-ID: <loom.20080915T092533-905@post.gmane.org>
References: <48BBAFB9.9080101@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 7E61F24405
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Sep 2008 19:25:06 +0200 (CEST)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1KfHot-00034S-6T
	for alsa-devel@alsa-project.org; Mon, 15 Sep 2008 17:25:03 +0000
Received: from alf94-10-82-243-47-202.fbx.proxad.net ([82.243.47.202])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 15 Sep 2008 17:25:03 +0000
Received: from gilbux by alf94-10-82-243-47-202.fbx.proxad.net with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 15 Sep 2008 17:25:03 +0000
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

I had wrote :
> I want to send scheduled event with the queuing system, but with RTC 
> timer the queue doesn't start, and with the other timer the queue start 
> but no events are sent.

Finnaly I have solved one of my problem.
I think, it was that I was trying to schedule event, when the queue is not
started. I don't know why but with my code this doesn't work, if I schedule
event after the queue is started all is ok and they are sended.

Regards,
Gilbux
