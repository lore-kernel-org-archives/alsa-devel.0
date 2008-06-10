From: =?utf-8?b?UmFmYcWC?= =?utf-8?b?TXXFvHnFgm8=?= <galtgendo@o2.pl>
Subject: Re:
	=?utf-8?q?What_does_snd=5Fpcm=5Fdelay=28=29_actually?=
	=?utf-8?q?_return=3F?=
Date: Tue, 10 Jun 2008 14:01:42 +0000 (UTC)
Message-ID: <loom.20080610T134958-492@post.gmane.org>
References: <20080609190225.GA4534@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 812AE24783
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Jun 2008 16:01:57 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1K64Q4-0007v8-Ut
	for alsa-devel@alsa-project.org; Tue, 10 Jun 2008 14:01:53 +0000
Received: from host-89-228-42-12.elk.mm.pl ([89.228.42.12])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 10 Jun 2008 14:01:52 +0000
Received: from galtgendo by host-89-228-42-12.elk.mm.pl with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 10 Jun 2008 14:01:52 +0000
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

Just to add my 2c: wine 1.0-rc4 kind of "works" with pulseaudio 0.9.10,
however in a funny kind of way.
First of all, volume seems quite a bit lower than it should be and volume
control doesn't seem to work (or at least it's barely noticeable).
Then there's a silly effect:
'wine winmm_test wave' sometimes completes with 0-2 failures, sometimes hangs
(in a random spot).
I'm using standard pulseaudio asound.conf (from the webpage).
The strange thing is that wine opens hw:0 for default, while I think that
asound.conf should have changed that (though I may simple fail to understand
that file).
