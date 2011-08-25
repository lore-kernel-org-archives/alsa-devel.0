From: Raymond Toy <rtoy@google.com>
Subject: Alsa timing question
Date: Wed, 24 Aug 2011 17:10:04 -0700
Message-ID: <CAE3TgXE3g9n92Xru_6Znk00rfDdF5OSMXaTiquU=ne5NLrOkOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out.google.com (smtp-out.google.com [216.239.44.51])
	by alsa0.perex.cz (Postfix) with ESMTP id F2F922476A
	for <alsa-devel@alsa-project.org>;
	Thu, 25 Aug 2011 02:10:08 +0200 (CEST)
Received: from hpaq14.eem.corp.google.com (hpaq14.eem.corp.google.com
	[172.25.149.14]) by smtp-out.google.com with ESMTP id p7P0A6kE031210
	for <alsa-devel@alsa-project.org>; Wed, 24 Aug 2011 17:10:07 -0700
Received: from fxd20 (fxd20.prod.google.com [10.184.4.20])
	by hpaq14.eem.corp.google.com with ESMTP id p7P0A5v9011268
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <alsa-devel@alsa-project.org>; Wed, 24 Aug 2011 17:10:05 -0700
Received: by fxd20 with SMTP id 20so1995227fxd.22
	for <alsa-devel@alsa-project.org>; Wed, 24 Aug 2011 17:10:05 -0700 (PDT)
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

I'm working on an application where I'd like to have relatively fixed timing
between calls to snd_pcm_writei.  As an example, of this I used the sample
pcm.c code from <
http://www.alsa-project.org/alsa-doc/alsa-lib/_2test_2pcm_8c-example.html#a65>.
 I placed a simple function to write out the time (from clock_getttime)
before each call to snd_pcm_writei in write_loop.  With a sample rate of
48kHz and a buffer time of 128000 and period time of 42667, what I see is
that most calls to snd_pcm_writei are spaced about 50 ms apart.  This makes
some sense, but I was expecting the calls to be about 42.67 ms apart.
 However, about every 6th call, the time is just 200 us or so.  Why is that?


Is there any simple way to make the calls spaced more closely to 42.67 ms
apart?  Do I need to do something more complicated to achieve this?

Ray
