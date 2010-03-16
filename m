From: ANISH KUMAR <anish.singh@samsung.com>
Subject: Re: underrun problem when short audio play
Date: Tue, 16 Mar 2010 13:13:06 +0000 (GMT)
Message-ID: <19320030.825861268745186292.JavaMail.weblogic@epml03>
Reply-To: anish.singh@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	by alsa0.perex.cz (Postfix) with ESMTP id EC423243B7
	for <alsa-devel@alsa-project.org>; Tue, 16 Mar 2010 14:13:10 +0100 (CET)
Received: from ep_ms13_bk (mailout4.samsung.com [203.254.224.34])
	by mailout1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KZD00KNWM1U3F@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Tue, 16 Mar 2010 22:13:06 +0900 (KST)
Received: from ep_spt01 (ms13.samsung.com [203.254.225.109])
	by ms13.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTP id <0KZD00DL3M1UPN@ms13.samsung.com> for
	alsa-devel@alsa-project.org; Tue, 16 Mar 2010 22:13:06 +0900 (KST)
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
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: MAHAMMADRAFI MANIYAR <maniyar@samsung.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


Thanks Mark,
>If your driver is not responding promptly to requests to terminate playback then an
underrun doesn't seem surprising.

Sometimes in my driver write calls doesn't return causing application to block forever and CPU pegged problem.
Situation:Recording going on->go to sleep->come back from sleep->start recording again->try recording 
and playing back simultaneously(something like recording going on in background and you try to play short audio).

This causes write call to get blocked in playback case causing application to hangup.
This doesn't happen if we don't go to sleep.
So i think somewhere there is some problem with suspend->resume case which is difficult to figure out.
 I checked driver logs after coming back from sleep.I found for some time interrupts are coming then stopped coming suddenly
So now after waking up i am reopening the playback device before opening the record device.Which has fixed the problem
but not the root cause.
