From: jamesmstone@gmail.com
Subject: emu10k1 ALSA/jack problem
Date: Fri, 10 Aug 2007 12:10:45 +0100
Message-ID: <20070810111045.GA3741@moon.base>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.188])
	by alsa0.perex.cz (Postfix) with ESMTP id 76245243D5
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Aug 2007 13:10:49 +0200 (CEST)
Received: by fk-out-0910.google.com with SMTP id f40so722309fka
	for <alsa-devel@alsa-project.org>; Fri, 10 Aug 2007 04:10:48 -0700 (PDT)
Received: from james by moon.base with local (Exim 4.63)
	(envelope-from <jamesmstone@gmail.com>) id 1IJSOD-0000yZ-5A
	for alsa-devel@alsa-project.org; Fri, 10 Aug 2007 12:10:45 +0100
Content-Disposition: inline
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

Dear All,

I am currently working on an audio program (aldrin) which uses
libbzub driver
http://trac.zeitherrschaft.org/zzub/browser/trunk/src/libzzub/driver.cpp
for accessing the sound card. Libzzub, in turn uses rtaudio
version 3.03, which is part of the libzzub source tree.

The problem arises when I am running a jack server using my
sblive, but specifying the default interface (hw:0).

On startup, a vast number of xruns are generated (>200) and jack
either falls over, or the computer almost completely locks up.

This appears to be caused by rtaudio probing the alsa devices
whilst jack is running. Interestingly, if I specify a sub-device
(hw:0,3), or the integrated sound card (intel), no xruns are
generated.

I am wondering if this problem is arising because of a bug in the
emu10k1 driver, or a problem with the way rtaudio probes alsa
devices, or because it is a bad idea to probe alsa devices while
they are being used by jack???

Best wishes,

James
