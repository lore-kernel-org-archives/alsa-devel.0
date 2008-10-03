From: Howard Chu <hyc@symas.com>
Subject: snd_hda_intel shutdown noise
Date: Thu, 02 Oct 2008 21:59:59 -0700
Message-ID: <48E5A6CF.8070802@symas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lirone.symas.net (lirone.symas.net [64.71.152.235])
	by alsa0.perex.cz (Postfix) with ESMTP id 548AC24610
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Oct 2008 07:00:08 +0200 (CEST)
Received: from [76.91.220.157] (helo=[192.168.1.20])
	by lirone.symas.net with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69) (envelope-from <hyc@symas.com>) id 1Klclp-0001Pe-Cr
	for alsa-devel@alsa-project.org; Thu, 02 Oct 2008 22:00:05 -0700
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

On my HP dv5z whenever shutting down or rebooting there's a loud pop on the 
speakers just before the screen shuts off. It seems to me that it might be 
worthwhile to zero the volume or set the mute bit on the output channels just 
before closing the device. I started looking into this but haven't found the 
right place to insert the code yet. Anyone else have any ideas? Will this even 
make a difference?
-- 
   -- Howard Chu
   CTO, Symas Corp.           http://www.symas.com
   Director, Highland Sun     http://highlandsun.com/hyc/
   Chief Architect, OpenLDAP  http://www.openldap.org/project/
