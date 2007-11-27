From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: rme hdsp pcmcia (and probably pci) broken
Date: Mon, 26 Nov 2007 17:45:03 -0800
Message-ID: <1196127903.15009.34.camel@cmn3.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3.stanford.edu (smtp3.Stanford.EDU [171.67.20.26])
	by alsa0.perex.cz (Postfix) with ESMTP id A6D22247F3
	for <alsa-devel@alsa-project.org>; Tue, 27 Nov 2007 02:45:09 +0100 (CET)
Received: from smtp3.stanford.edu (localhost.localdomain [127.0.0.1])
	by localhost (Postfix) with SMTP id 06B9D4C8EB
	for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2007 17:45:06 -0800 (PST)
Received: from cm-mail.stanford.edu (cm-mail.Stanford.EDU [171.64.197.135])
	by smtp3.stanford.edu (Postfix) with ESMTP id C93264C972
	for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2007 17:45:05 -0800 (PST)
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
Cc: nando@ccrma.Stanford.EDU, planetccrma@ccrma.Stanford.EDU
List-Id: alsa-devel@alsa-project.org

Hi, anyone has a pcmcia rme card running? And working? With a reasonably
recent alsa? (this probably applies also for the regular pci rme cards,
I've had reports on the Planet CCRMA list about problems that sound
similar to this one). 

My test setup is on fc7 running:

  alsa-lib 1.0.15
  alsa-tools 1.0.15
  alsa-firmware 1.0.15

After a sequence of reboots this is what I get:

2.6.22.1-1.rt5.1 + alsa driver modules from
svn 20070702.165519
--> OK

2.6.22.5-1.rt9.2 + alsa driver modules from
hg20070830
--> OK

2.6.22.6-1.rt9.5 + alsa driver modules from
hg20070830
--> OK

2.6.22.10-1.rt9.1 + alsa driver modules from
hg20071012
--> BROKEN

2.6.23.1-1.rt11.1 + alsa drive modules from
hg20071124
--> BROKEN

BROKEN means: after starting hdspmixer I get no sound from the analog
outputs (all previous tries play sound correctly with the default preset
in hdspmixer). Some channels do appear (using a Digiface II). In the
"broken" drivers I can get sound with the default preset if I send a
signal to channels 7 and 12, all other stay muted. 

Something broke drastically in the driver between 2007.08.30 and
2007.10.12.

Any help appreciated...

-- Fernando
