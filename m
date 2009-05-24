From: linux user <raen@internode.on.net>
Subject: spdif/iec958 outputs at VT1708S not recognized
Date: Sun, 24 May 2009 04:24:47 +0000 (UTC)
Message-ID: <loom.20090524T041733-62@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id B295B24500
	for <alsa-devel@alsa-project.org>;
	Sun, 24 May 2009 06:40:06 +0200 (CEST)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1M85VC-0002OJ-Vt
	for alsa-devel@alsa-project.org; Sun, 24 May 2009 04:40:03 +0000
Received: from ppp121-44-133-211.lns10.syd7.internode.on.net ([121.44.133.211])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sun, 24 May 2009 04:40:02 +0000
Received: from raen by ppp121-44-133-211.lns10.syd7.internode.on.net with
	local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sun, 24 May 2009 04:40:02 +0000
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

Hi I am running 2.6.28-11-generic (Kubunti install) with M4A78T-E Motherboard
and also have no digital spdif output.

aplay -L     
default:CARD=SB               
    HDA ATI SB, VT1708S Analog
    Default Audio Device
front:CARD=SB,DEV=0
    HDA ATI SB, VT1708S Analog
    Front speakers
surround40:CARD=SB,DEV=0
    HDA ATI SB, VT1708S Analog
    4.0 Surround output to Front and Rear speakers
surround41:CARD=SB,DEV=0
    HDA ATI SB, VT1708S Analog
    4.1 Surround output to Front, Rear and Subwoofer speakers
surround50:CARD=SB,DEV=0
    HDA ATI SB, VT1708S Analog
    5.0 Surround output to Front, Center and Rear speakers
surround51:CARD=SB,DEV=0
    HDA ATI SB, VT1708S Analog
    5.1 Surround output to Front, Center, Rear and Subwoofer speakers
surround71:CARD=SB,DEV=0
    HDA ATI SB, VT1708S Analog
    7.1 Surround output to Front, Center, Side, Rear and Woofer speakers
null
    Discard all samples (playback) or generate zero samples (capture)
hdmi:CARD=HDMI
    HDA ATI HDMI, ATI HDMI
    HDMI Audio Output


 I have read this thread ( 
http://mailman.alsa-project.org/pipermail/alsa-devel/2009-May/016958.html ) and
gather that it is a problem with the BIOS and that it was fixable by patching
alsa source. As a newbie and not wanting to destroy my alsa source files can you
explain or refer me to a good howto of the steps needed?

Thanks
  
http://mailman.alsa-project.org/pipermail/alsa-devel/2009-May/016958.html
