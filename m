From: Richard Spindler <richard.spindler@gmail.com>
Subject: Intel HDA Headphones vs. Speaker Mute
Date: Fri, 7 Nov 2008 12:43:22 +0000 (UTC)
Message-ID: <loom.20081107T123030-119@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 56E4624408
	for <alsa-devel@alsa-project.org>; Fri,  7 Nov 2008 13:45:10 +0100 (CET)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1KyQhy-00069j-VC
	for alsa-devel@alsa-project.org; Fri, 07 Nov 2008 12:45:03 +0000
Received: from 091-141-073-028.dyn.orange.at ([91.141.73.28])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 07 Nov 2008 12:45:02 +0000
Received: from richard.spindler by 091-141-073-028.dyn.orange.at with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 07 Nov 2008 12:45:02 +0000
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

Hi,

the builtin sound card in my laptop does not behave as it should, when running
it with the ALSA system. While there are separate mixer controls for headphones
and speakers, the Master control levels both, speakers and headphones
simultaneously, while the headphone control does not act at all. Also in my
opinion the speakers should mute automatically as soon as I plug in the
headphones, this does not happen too.

I am running Ubuntu 8.04.1:


$ uname -a
Linux monostatos 2.6.24-19-generic #1 SMP Wed Aug 20 22:56:21 UTC 2008 i686
GNU/Linux

$ lspci -nn |grep Audio
00:1b.0 Audio device [0403]: Intel Corporation 82801G (ICH7 Family) High
Definition Audio Controller [8086:27d8] (rev 02)

If you need any more information about that machine, or if there is anything I
can do to help fix that problem, do not hesitate to ask.

Cheers
-Richard

PS.: I also published a lengthy rant, and some ideas about that problem at
http://propirate.net/oracle/archives/2008/11/05/alsa-headaches-erm-headphones/
