From: Paul Davis <pbd@op.net>
Subject: Re: HDSP CardBus + Toshiba Satellite : found magic patch !
Date: Sat, 31 Aug 2002 09:59:29 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200208311357.PAA28600@alsa.alsa-project.org>
References: <1030708500.7462.12.camel@satellite.undata.org>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from newmx2.fast.net (newmx2.fast.net [209.92.1.32])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id PAA28600
	for <alsa-devel@alsa-project.org>; Sat, 31 Aug 2002 15:57:20 +0200
Received: from unknown (HELO someip.ppp.op.net) ([209.92.96.206]) (envelope-sender <pbd@op.net>)
          by newmx2.fast.net (qmail-ldap-1.03) with SMTP
          for <alsa-devel@alsa-project.org>; 31 Aug 2002 13:57:07 -0000
In-Reply-To: Your message of "30 Aug 2002 13:54:59 +0200."
             <1030708500.7462.12.camel@satellite.undata.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Patrick - 

I wanted to add this information to the h-dsp page, but when i try to
get there from the card matrix, it seemed more work to use that form
since i'm already on this list. 

Can you please add this note to the "Known Issues" for the H-DSP:

 - the PCMCIA interface requires a kernel that has been properly built
   to support CardBus devices. In addition, a kernel patch required to
   correctly handle certain Intel hardware. If not used, the PCMCIA
   card will not be usable. The patch is available at

    http://groups.google.fr/groups?hl=fr&lr=&ie=UTF-8&selm=20020816194825.A7086%40jurassic.park.msu.ru&rnum=2

   Correct kernel configuration options appear to include:

     Support for hot pluggable devices are compiled into the kernel
     pcmcia is compiled into the kernel
     Cardbus Support is compiled into the kernel
     i82365 compatible bridge is compiled into the kernel
     all other options concerning PCMCIA are disabled
     Hotplug support (PCI) is disabled
     Plug and Play support is disabled

thanks.


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
