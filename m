From: Mauro Sacchetto <mauro.sacchetto@alice.it>
Subject: Re: Troubles with hda_intel
Date: Sun, 24 Sep 2006 13:58:14 +0200
Message-ID: <200609241358.14627.mauro.sacchetto@alice.it>
References: <200609231519.53947.mauro.sacchetto@alice.it>
	<1159025098.1097.137.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from smtp-out13.alice.it (smtp-out13.alice.it [85.33.2.18])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 246EB234
	for <alsa-devel@alsa-project.org>;
	Sun, 24 Sep 2006 13:58:05 +0200 (MEST)
In-Reply-To: <1159025098.1097.137.camel@mindpipe>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
Cc: Lee Revell <rlrevell@joe-job.com>
List-Id: alsa-devel@alsa-project.org

Alle 17:24, sabato 23 settembre 2006, Lee Revell ha scritto:
> Check whether KDE is still using the obsolete OSS API:
> # fuser /dev/dsp

I wrote to Bugzilla KDE (BUG no. 134480), 
but the only conclusive aswer I had was:
===========================================
------- Additional Comment #6 From Stephan Kulow 2006-09-24 11:07 -------
it just means your kernel module is buggy indeed
===========================================
I wrote too to Kernel Bug Tracker (bog no. 7195).
Note that I have the same problem is I use the kernel alsa support
and the driver of alsa-driver package.
I hope that someone will be able to understand
the very reason of that trouble...

MS

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
