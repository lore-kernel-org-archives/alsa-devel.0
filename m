From: Matt Flax <flatmax@ieee.org>
Subject: Re: SiS7012 hang alsa version 0.9.3c
Date: Sun, 25 May 2003 03:08:52 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030524170852.GB15643@ee.unsw.edu.au>
References: <20030524170025.GA15643@ee.unsw.edu.au>
Reply-To: Matt Flax <flatmax@pgb.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp3.unsw.edu.au (smtp3.unsw.EDU.AU [149.171.96.70])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id SAA28218
	for <alsa-devel@alsa-project.org>; Sat, 24 May 2003 18:23:53 +0200
Received: from smtp.unsw.edu.au (antivirus-01.services.comms.unsw.EDU.AU [149.171.193.80])
	by smtp3.unsw.edu.au (8.11.2/8.11.2) with ESMTP id h4OGCdu20809
	for <alsa-devel@alsa-project.org>; Sun, 25 May 2003 02:12:39 +1000 (EST)
Received: from maillationax ([149.171.36.140])
	by smtp.unsw.edu.au (8.11.2/8.11.2) with ESMTP id h4OGCdL20804
	for <alsa-devel@alsa-project.org>; Sun, 25 May 2003 02:12:39 +1000 (EST)
Received: from flatmax by maillationax with local (Exim 3.36 #1 (Debian))
	id 19JcVo-00046I-00
	for <alsa-devel@alsa-project.org>; Sun, 25 May 2003 03:08:52 +1000
Content-Disposition: inline
In-Reply-To: <20030524170025.GA15643@ee.unsw.edu.au>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: core sound <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello again,

It would seem this has been seem before ...
http://www.mail-archive.com/alsa-user@lists.sourceforge.net/msg04601.html

But there was no solution at the end of the thread ... I run kernel 
version 2.4.20

Perhaps I require a newer kernel version as well ?

Matt

On Sun, May 25, 2003 at 03:00:25AM +1000, flatmax wrote:
> Hi,
> 
> From the soundcard matrix 'Details' link :
> http://alsa-project.org/alsa-doc/doc-php/template.php3?company=SiS&card=&chip=ad1816a&module=intel8x0
> it seems this is supported in the 'intel8x0' driver.
> 
> When I try to load  the intel alsa module I get a hang state, with this 
> output :
> PCI: Enabling device 00:02.7 (0000 -> 0001)
> PCI: No IRQ known for interrupt pin C of device 00:02.7. Please try 
> using pci=biosirq.
> ALSA ../alsa-kernel/pci/intel8x0.c:2249: unable to grab IRQ 0
> 
> So I appended that to the lilo.conf file and ran lilo, upon reboot - 
> same problem.
> 
> Any wise tips, or  ... anything ???
> 
> Matt
> 
> -- 
> http://mffm.ee.unsw.edu.au
> 
> WSOLA TimeScale Audio Mod  : http://mffmtimescale.sourceforge.net/
> FFTw C++                   : http://mffmfftwrapper.sourceforge.net/
> Vector Bass                : http://mffmvectorbass.sourceforge.net/
> Multimedia Time Code       : http://mffmtimecode.sourceforge.net/

-- 
http://mffm.ee.unsw.edu.au

WSOLA TimeScale Audio Mod  : http://mffmtimescale.sourceforge.net/
FFTw C++                   : http://mffmfftwrapper.sourceforge.net/
Vector Bass                : http://mffmvectorbass.sourceforge.net/
Multimedia Time Code       : http://mffmtimecode.sourceforge.net/


-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
