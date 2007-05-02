From: chris@idlelion.net
Subject: Newb wants to fix snd_cs46xx driver
Date: Wed, 2 May 2007 17:03:46 -0500 (CDT)
Message-ID: <Pine.LNX.4.64.0705021658260.3157@tick.idlelion.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rwcrmhc11.comcast.net (rwcrmhc11.comcast.net [216.148.227.151])
	by alsa0.perex.cz (Postfix) with ESMTP id 986302449F
	for <alsa-devel@alsa-project.org>;
	Thu,  3 May 2007 00:04:01 +0200 (CEST)
Received: from localhost (tick.idlelion.net [127.0.0.1])
	by tick.idlelion.net (8.13.8/8.13.4) with ESMTP id l42M3ki3005197
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <alsa-devel@alsa-project.org>; Wed, 2 May 2007 17:03:47 -0500
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

There's been a bug on this chip's driver for at least four years.

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=305

There are two ThinkPad 600X's in my home that have the problem. The chip 
is also in the ThinkPad A20m, A20p, A21m, A21p, A22m, A22p, T20, T21 and 
T22... and probably other brands as well.

In the 600X, it happens to be paired with a CS4297A... hey, should I just 
try to get Linux to use that? (I use Fedora BTW.) How would I try to do 
that?

Or... better still... how would I get either the '97A driver installed 
automatically by soundcard detection, or failing that, actually fix the 
driver? (I am a software developer who has written machine code for fun.)

Thanks,
Chris
