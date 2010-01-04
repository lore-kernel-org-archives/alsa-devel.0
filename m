From: Joern Bernhardt <joern.bernhardt@gmx.net>
Subject: Speakers won't turn off, when headphones are plugged in
Date: Mon, 04 Jan 2010 17:36:26 +0100
Message-ID: <4B42190A.1000206@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 03D871037F3
	for <alsa-devel@alsa-project.org>; Mon,  4 Jan 2010 17:36:41 +0100 (CET)
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

Hi there,

my speakers won't turn off, when I plug in headphones. I've tried all of 
these models:

   ref           Reference board
   ref-no-jd     Reference board without HP/Mic jack detection
   3stack        D965 3stack
   5stack        D965 5stack   SPDIF
   5stack-no-fp  D965 5stack without front panel
   dell-3stack   Dell Dimension E520
   dell-bios     Fixes with Dell BIOS setup
   auto          BIOS setup (default)

Some of these only had sound when headphones were plugged in (speakers 
didn't work at all) or when they were plugged in the microphone jack.

My laptop is a HP HDX 9000 and my alsa-info script output is here:

http://www.alsa-project.org/db/?f=b5a4386553266384382868ddef56553d643e7b4a

Thanks for helping,

Joern
