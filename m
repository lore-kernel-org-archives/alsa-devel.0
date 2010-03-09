From: ANISH KUMAR <anish.singh@samsung.com>
Subject: underrun problem when short audio play
Date: Tue, 09 Mar 2010 12:44:36 +0000 (GMT)
Message-ID: <17526962.152181268138676329.JavaMail.weblogic@epml01>
Reply-To: anish.singh@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	by alsa0.perex.cz (Postfix) with ESMTP id 0466F244F1
	for <alsa-devel@alsa-project.org>; Tue,  9 Mar 2010 13:44:39 +0100 (CET)
Received: from ep_ms13_bk (mailout2.samsung.com [203.254.224.25])
	by mailout1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KZ000H25M2CFN@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Tue, 09 Mar 2010 21:44:36 +0900 (KST)
Received: from ep_spt04 (ms13.samsung.com [203.254.225.109])
	by ms13.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTP id <0KZ0002Q0M2CNV@ms13.samsung.com> for
	alsa-devel@alsa-project.org; Tue, 09 Mar 2010 21:44:36 +0900 (KST)
Content-return: prohibited
MIME-version: 1.0
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: maniyar@samsung.com
List-Id: alsa-devel@alsa-project.org

Hi all,

I am facing a problem when i try to play short duration audio(problem is not observerd when i am
playing tones which is also short duration audio).
Somehow i am getting buffer overrun everytime i am playing short duration audio.
It is happening because of avail >= stop_threshold.

When i tried to increase the stop_threshold  but then i got "same audio played again kind of echo" problem.
I can't try the solution suggested by jaroslav i.e. checking for DRAINING state in lower level driver and stop
queuing because of some design issue as in my code i don't call drain function as soon as all buffers are written.
I wait for some time(in miliseconds) and then call drain function.

Please suggest any pointers.Should i increase the buffer size or stop_threshold both of which i tried but to no use.
I am always getting underrun problem that too always in the function update_hw_ptr_post function.

How can i disable the stop_threshold check??

Thanks,
anish
