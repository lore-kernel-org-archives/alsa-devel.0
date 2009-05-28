From: Konstantin Kletschke <lists@ku-gbr.de>
Subject: Wonder if VT1708A has Mic Boost or not
Date: Thu, 28 May 2009 10:39:27 +0200
Message-ID: <20090528083926.GA26750@punzenstreichler.doom>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ku-gbr.de (mail.ku-gbr.de [81.3.11.18])
	by alsa0.perex.cz (Postfix) with ESMTP id 292CB103807
	for <alsa-devel@alsa-project.org>;
	Thu, 28 May 2009 11:02:14 +0200 (CEST)
Received: from dslc-082-082-178-044.pools.arcor-ip.net ([82.82.178.44]:53934
	helo=keulator.homelinux.org)
	by mail.ku-gbr.de with esmtpsa (Exim 4.69 #1 (Debian))
	id 1M9bV8-0007l4-3C
	for <alsa-devel@alsa-project.org>; Thu, 28 May 2009 11:02:14 +0200
Received: from punzenstreichler ([10.10.0.18] helo=punzenstreichler.doom)
	by keulator.homelinux.org with esmtp (Exim 4.69)
	(envelope-from <konsti@ku-gbr.de>) id 1M9bV7-0005GC-LS
	for alsa-devel@alsa-project.org; Thu, 28 May 2009 11:02:13 +0200
Received: from konsti by punzenstreichler.doom with local (Exim 4.69)
	(envelope-from <konsti@ku-gbr.de>) id 1M9bV7-0006yY-2P
	for alsa-devel@alsa-project.org; Thu, 28 May 2009 11:02:13 +0200
Resent-Message-ID: <20090528090213.GB26750@punzenstreichler.doom>
Resent-To: alsa-devel@alsa-project.org
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

Hi Folks!

I have a mini-PC here which should record Voice over Microphone. The
Level is not really loud enough and the alsa-driver-1.0.19 doesn't
reveal a mic boost setting in its mixer. 

This of course may be of the driver not yet being adapted to the special
motherboard AFAIK.

What I wonder is, is the Mic Boost setting/function integrated in this
chip itself or does hardware vendor need to implement external opamps
for this? If it is integrated into the chip itself I could try to
modifiy the code to make the setting public.

Is there a source for a datasheet anywhere for the VT1708A?

King regards, Konsti

-- 
GPG KeyID EF62FCEF
Fingerprint: 13C9 B16B 9844 EC15 CC2E  A080 1E69 3FDA EF62 FCEF
