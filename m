From: <Ashwin.Chandra@corel.com>
Subject: Alsa Issue - Sound playback starts on left speaker only
Date: Tue, 24 Jun 2008 15:14:46 +0800
Message-ID: <6AA7F928714999469B70E7707C87F82C531570@TW-EVS02.corelcorp.corel.ics>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from twmail.corel.com (twmail.corel.com [220.128.92.8])
	by alsa0.perex.cz (Postfix) with ESMTP id D518D1037FB
	for <alsa-devel@alsa-project.org>;
	Tue, 24 Jun 2008 09:14:42 +0200 (CEST)
Content-class: urn:content-classes:message
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

 

Hello,

I am having an issue with my playback application where upon playback
start, only the left speaker is outputted. But if I mute and unmute
(either through my application or using alsamixer), the sound playback
resumes on both left and right speakers. This only happens on a
particular system too (out of 5 systems). But I know it is my issue
because mplayer or smplayer works fine.

 

I believe I am setting the correct HW params (ie. 2 channels), etc.

 

Any ideas?

 

Thanks!
