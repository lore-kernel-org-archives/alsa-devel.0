From: adelias <adelias@freemail.gr>
Subject: UAC2 defaults to max sampling rate
Date: Wed, 23 May 2012 10:59:56 +0300
Message-ID: <4FBC98FC.6000200@freemail.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
	by alsa0.perex.cz (Postfix) with ESMTP id 8FE3D2449E
	for <alsa-devel@alsa-project.org>;
	Wed, 23 May 2012 10:00:08 +0200 (CEST)
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1SX6UE-00060m-Cf
	for alsa-devel@alsa-project.org; Wed, 23 May 2012 10:00:02 +0200
Received: from 62.1.30.89.dsl.dyn.forthnet.gr ([62.1.30.89])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 23 May 2012 10:00:02 +0200
Received: from adelias by 62.1.30.89.dsl.dyn.forthnet.gr with local (Gmexim
	0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 23 May 2012 10:00:02 +0200
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
Cc: zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

Hi,

I'm running ALSA 1.0.23 and kernel 2.6.37 on ARM. The UAC2 audio device 
is the XMOS reference board.

This is what I'm observing. As soon as the XMOS board is plugged in to 
the USB port, the display on my DAC indicates that is has locked at 
192kHz which is the maximum sampling rate supported by the XMOS.

Is this the expected behavior or can I specify the defualt sampling rate 
at start up?

Thanks
