From: Robert Jarzmik <rjarzmik@free.fr>
Subject: PXA27x and AC97 reset bug
Date: 07 Feb 2008 00:00:51 +0100
Message-ID: <87ejbpheqk.fsf@polgara.paysbobval>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp6-g19.free.fr (smtp6-g19.free.fr [212.27.42.36])
	by alsa0.perex.cz (Postfix) with ESMTP id 01BEF24443
	for <alsa-devel@alsa-project.org>; Thu,  7 Feb 2008 01:00:12 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: liam.girdwood@wolfsonmicro.com, broonie@opensource.wolfsonmicro.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I hope this subject wasn't previously discussed, as I couldn't find a trace ...

The basic question is : why can't the PXA27x reset the AC97 bus in front of an
wm9713 ?

And more precisely, I'd like to know :
 - are there any references to this bug (Intel note, mailing list ref, ...)
 - is it a hardware bug on PXA27x side ?
 - is it a hardware bug on wm9713 side ?
 - is there a known generic workaround (assuming GPIO113 is connected to wm9713
reset line is not generic for me) ?
 - is there a known platform where this bug does not happen ?

--
Robert
