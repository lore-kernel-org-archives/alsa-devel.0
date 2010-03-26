From: Udo van den Heuvel <udovdh@xs4all.nl>
Subject: Speakertest repeats sounds on ATI HD3200 HDMI (Fedora
 12 x86_64, 2.6.33.1 kernel.org)
Date: Fri, 26 Mar 2010 17:01:34 +0100
Message-ID: <4BACDA5E.2070604@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pindarots.xs4all.nl (pindarots.xs4all.nl [80.101.128.228])
	by alsa0.perex.cz (Postfix) with ESMTP id 94C4F103821
	for <alsa-devel@alsa-project.org>; Fri, 26 Mar 2010 17:01:37 +0100 (CET)
Received: from surfplank2.hierzo (localhost.localdomain [127.0.0.1])
	by pindarots.xs4all.nl (8.14.3/8.14.3) with ESMTP id o2QG1YJ6001202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO)
	for <alsa-devel@alsa-project.org>; Fri, 26 Mar 2010 17:01:37 +0100
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

I am getting repeated sounds when using speakertest:
FronFronFronFronFronFronFronFronFronFron... RontRontRontRont... etc.

Seeh ttps://bugtrack.alsa-project.org/alsa-bug/view.php?id=4965 for
details about the bug.

It's a Jetway NC81-LF w/ ATI HD3200 onboard video. HDMI connection to
the TV. Video works great, adding audio gives stuttering effects.
So we started debugging.

I have a speakertest-strace: http://pastebin.com/Ad7j8Yc5.
I start the test and the audio goes like:
FronFronFronFronFronFronFronFronFronFronFronFronFronFronFronFron
the strace sits and I pastebinned it.

Then the speaker-test continues and the audio goes like
RontRontRontRontRontRont
See http://pastebin.com/TNpsv1bv for the strace.

Any idea what might be wrong here?

Kind regards,
Udo
