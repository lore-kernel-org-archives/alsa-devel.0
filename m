From: "Andreas Falkenhahn" <andreas@airsoftsoftwair.de>
Subject: Playing multiple sounds at the same time
Date: Fri, 30 Apr 2010 12:38:49 +0200
Message-ID: <4411e1854e5de844b0cf28262efd5992-EhVcX19FRQFfRwgeDBcNWRwwfgFLV15YQUBGAEFbWi9fXEYKW1loAFJQQ1lcLkQAWFhfQltcWgE=-webmailer2@server02.webmailer.hosteurope.de>
Reply-To: andreas@airsoftsoftwair.de
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from jordan.mc0.hosteurope.de (jordan.mc0.hosteurope.de
	[80.237.138.9]) by alsa0.perex.cz (Postfix) with ESMTP id 88B5124444
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Apr 2010 12:38:49 +0200 (CEST)
Received: from server02.webmailer.hosteurope.de ([10.9.0.181]);
	by mailout.hosteurope.de (jordan.mc0.hosteurope.de) running
	EXperimental Internet Mailer with esmtps (TLSv1:AES256-SHA:256)
	id 1O7nch-0008VB-2W
	for alsa-devel@alsa-project.org; Fri, 30 Apr 2010 12:39:07 +0200
Received: from nobody by server02.webmailer.hosteurope.de with local (Exim
	4.69) (envelope-from <andreas@airsoftsoftwair.de>)
	id 1O7ncP-0003Xn-3f
	for alsa-devel@alsa-project.org; Fri, 30 Apr 2010 12:38:49 +0200
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

Hi,

I'm new to ALSA programming so please bear with me if the following
question is all too obvious. I did some research on my question before but
I didn't come across a clear answer.

What I want to do is really simple: Playing multiple sounds in different
formats at the same time. E.g.

Sound 1: 12345 hz, 8-bit signed, mono
Sound 2: 44100 hz, 16-bit unsigned, stereo
Sound 3: 8000 hz, 8-bit unsigned, stereo

Now I want to play sounds 1 to 3 at the same time. My question is now: Can
ALSA do automatic mixing for me here or do I have to do the mixing on my
own? In other words, can I simply feed all these three sound streams to
ALSA or do I have to mix them into a fourth audio stream first and feeding
this new fourth stream to ALSA then?

Thanks,

Andreas
