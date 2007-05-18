From: Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>
Subject: alsa-driver 1.0.14rc4 compile error resolved (was:
	Linux 2.6.21 regression with hda-intel	(Conexant	5045))
Date: Fri, 18 May 2007 11:35:39 +0200
Message-ID: <f2js0l$at0$1@sea.gmane.org>
References: <f2h9a9$d15$1@sea.gmane.org>
	<1179414132.4415.295.camel@razman.gruemaster.com>
	<f2jq7l$5ru$1@sea.gmane.org> <s5hveeqeba4.wl%tiwai@suse.de>
Reply-To: G.Ohrner@post.rwth-aachen.de
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 7649E24530
	for <alsa-devel@alsa-project.org>;
	Fri, 18 May 2007 11:35:29 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Hoyru-0003dl-JA
	for alsa-devel@alsa-project.org; Fri, 18 May 2007 11:35:26 +0200
Received: from bras-co-85-197-6-232.westend.de ([85.197.6.232])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 18 May 2007 11:35:26 +0200
Received: from G.Ohrner by bras-co-85-197-6-232.westend.de with local (Gmexim
	0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 18 May 2007 11:35:26 +0200
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

Takashi Iwai wrote:
>> > alsa-driver-1.0.14rc4.tar.bz2 release from alsa-project.org and use it.
>> This driver version does not seem to compile with Linux 2.6.21:

>> /usr/src/tmp/alsa-driver-1.0.14rc4/include/adriver.h:1168: error: too
>> many arguments to function 'pci_save_state'

> The configure script couldn't detect some conditions by some reasons
> on your system.

I found a reference to exactly the same problem here:

http://thread.gmane.org/gmane.linux.alsa.devel/46343/focus=46387

This thread mentions just this compile error and that it was supposed to be
fixed with 1.0.14rc4 but in fact wasn't.

My kernel was also built for the Core2 CPU, recompiling the whole kernel for
Pentium M helped and the compilation finished successfully.

There seems to be some macro magic going awry if Core2 is selected as the
target CPU.

I'll now test the freshly compiled driver and report if it works better than
the driver contained in vanilla Linux 2.6.21. :-)

Greetings,

  Gunter
