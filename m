From: Adam Rosenberg <adam@alcorn.com>
Subject: Clicking and stuttering audio when playing two or more
	files
Date: Thu, 15 Jul 2010 13:21:47 -0400
Message-ID: <AANLkTikcthlodljUqW8oA69UYL2znXfTgHbABTRHYwSI@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 25C63103816
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Jul 2010 19:21:50 +0200 (CEST)
Received: by ewy21 with SMTP id 21so311605ewy.38
	for <alsa-devel@alsa-project.org>; Thu, 15 Jul 2010 10:21:49 -0700 (PDT)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

I have audio output perfectly from my second CS42448 CODEC now, but
only when one file is playing.  When I attempt to play two files, one
or both of the files play with clicking and stuttering.  I am also
noticing that the PCM prepare operation is occurring more than once.
What could be causing this problem?

HW settings are:
 buffer_bytes_max = 32768
 period_bytes min = 8 max = 32768
 periods      min = 1 max = 4096

PCM runtime is reporting:
 frames per period = 1114
 periods          = 2
 total frames   =   2228
 frame bytes   =    8

Thank you,
Adam
