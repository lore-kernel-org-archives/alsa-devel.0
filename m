From: Jaroslav Kysela <perex@perex.cz>
Subject: PC Beep or PC Speaker or just Beep? and HDA Beep
	code...
Date: Thu, 22 Oct 2009 17:50:10 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0910221740280.5519@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id F0C8A2444F
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Oct 2009 17:50:11 +0200 (CEST)
Received: from server.perex.cz (server.perex.cz [172.16.0.20])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id
	D9994149BB7 for <alsa-devel@alsa-project.org>;
	Thu, 22 Oct 2009 17:50:11 +0200 (CEST)
Received: from eeebox2.perex-int.cz (localhost [127.0.0.1])
	by server.perex.cz (Perex's E-mail Delivery System) with ESMTP id
	C68A184630 for <alsa-devel@alsa-project.org>;
	Thu, 22 Oct 2009 17:50:11 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

 	I'm changing the behaviour of Beep / PC Beep controls for HDA 
drivers (comments?):

http://git.alsa-project.org/?p=alsa-kernel.git;a=commitdiff;h=d605dbeed1b102136513e09e95217e8dc19c800d

 	I would like to introduce uniform naming for these controls 
to not confuse users.

HDA driver: Beep, PC Beep
AC97: PC Speaker, Beep, PC Beep
etc..

 	I think that the original purpose of PC Speaker is a beep 
generator. Also, many SoC platforms use AC97 codecs, so removing 
abbreviation PC might make sense. It would be probably best to change all 
control names in drivers to 'Beep'. Comments?

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
