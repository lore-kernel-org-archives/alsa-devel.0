From: Frank Barknecht <fbar@footils.org>
Subject: Problems running latencytest: "error setting freq 1024"
Date: Tue, 23 Mar 2004 21:53:52 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040323205352.GA3246@fliwatut.scifi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp2.netcologne.de (smtp2.netcologne.de [194.8.194.218])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id VAA03340
	for <alsa-devel@alsa-project.org>; Tue, 23 Mar 2004 21:54:30 +0100
Received: from fliwatut.scifi (xdsl-213-196-243-96.netcologne.de [213.196.243.96])
	by smtp2.netcologne.de (Postfix) with ESMTP id E9B6739DD7
	for <alsa-devel@alsa-project.org>; Tue, 23 Mar 2004 21:53:52 +0100 (MET)
Received: from freak by fliwatut.scifi with local (Exim 3.36 #1 (Debian))
	id 1B5suG-0000sU-00
	for <alsa-devel@alsa-project.org>; Tue, 23 Mar 2004 21:53:52 +0100
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hallo,

I'd like to test my system's 2.6.4 latency using Takashi's
http://www.alsa-project.org/~iwai/latencytest-0.5.2.tar.gz
suite. 

Building and installing so far went fine, I can run all the tests but
no output is created. But I get a spurious error message which could be
the reason for this. If I run "measure" by hand as it is called by
"run_tests" like this: 
$ measure -p ./out/x11.png -o ./out/x11.out -c 0 -f 1024 -n 2 -t 2
I get this error message: "error setting freq 1024"

This seems to have something to do with the rtc-clock, but I have no
idea, what could be wrong here. Maybe it's something with my kernel
config? It looks like this: 

$ grep -i rtc /boot/config-2.6.4  
# CONFIG_HPET_EMULATE_RTC is not set
# CONFIG_APM_RTC_IS_GMT is not set
CONFIG_RTC=m
CONFIG_GEN_RTC=m
CONFIG_GEN_RTC_X=y
CONFIG_SND_RTCTIMER=m

Modules latency_test and rtc are loaded.

Any ideas?

ciao
-- 
 Frank Barknecht                               _ ______footils.org__


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
