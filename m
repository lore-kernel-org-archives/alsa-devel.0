From: Angel Tsankov <fn42551@fmi.uni-sofia.bg>
Subject: alsactl restore: unknown hardware: ymf724f
Date: Thu, 25 Feb 2010 09:54:33 +0200
Message-ID: <hm5aba$p65$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 6A063103957
	for <alsa-devel@alsa-project.org>; Thu, 25 Feb 2010 09:05:06 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1NkYiV-0006qy-0t
	for alsa-devel@alsa-project.org; Thu, 25 Feb 2010 09:05:03 +0100
Received: from client-144-140.speedy-net.bg ([78.159.144.140])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 25 Feb 2010 09:05:03 +0100
Received: from fn42551 by client-144-140.speedy-net.bg with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 25 Feb 2010 09:05:03 +0100
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

Hello,

I run 'alsactl restore' on a machine with 2 sound cards -- a built-in 
Intel Corporation 82801EB/ER (ICH5/ICH5R) AC'97 Audio Controller (rev 
02) and a non-built-in Yamaha Corporation YMF-724F [DS-1 Audio 
Controller] (rev 03) -- and get the following message:

Unknown hardware: "YMF724F" "SigmaTel STAC9700,83,84" "AC97a:83847600"
"0x1073" "0x000d"
Hardware is initialized using a guess method

As a consequence the volume levels of the Yamaha card do not get 
restored to the levels stored in /etc/asound.state.  The volume levels 
of the built-in card however are properly restored.  The asound.state 
file has been created by executing 'alsactl store'.

The kernel has been built with support for ALSA.  I've built and
installed the kernel modules for both cards (not the ones in the 
alsa-driver package but those that come with kernel version 2.6.30.2). 
Any ideas why alsactl cannot find the hardware it has previously 
identified as "YMF724F", "SigmaTel STAC9700,83,84", and so on?

Regards,
Angel Tsankov
