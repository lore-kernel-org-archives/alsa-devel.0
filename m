From: Robert Vincent Krakora <rob.krakora@messagenetsystems.com>
Subject: Re: [Alsa-user] em28xx_alsa: disagrees about version
 of symbol xxx after upgrading CentOS 5.2 ALSA .14 for ALSA .17
Date: Fri, 03 Oct 2008 10:08:59 -0400
Message-ID: <48E6277B.5050307@messagenetsystems.com>
References: <48E3DE07.4000707@messagenetsystems.com>
	<48E4D486.9080801@googlemail.com>
	<48E524B8.80002@messagenetsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from unifiedpaging.messagenetsystems.com (unknown [24.123.23.170])
	by alsa0.perex.cz (Postfix) with ESMTP id 791482473C
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Oct 2008 16:09:01 +0200 (CEST)
In-Reply-To: <48E524B8.80002@messagenetsystems.com>
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
Cc: geisj@messagenetsystems.com
List-Id: alsa-devel@alsa-project.org

All:

I have searched on the web and it seems that at least one person has 
overcome the problem I am having by rebuilding soundcore.ko (See here: 
http://redmonk.com/sogrady/2008/04/29/sog-1-busted-sound-0-getting-audio-working-on-the-x300-under-ubuntu/). 
There is a sound_core.c in the ALSA tar ball. Why doesn't ALSA rebuild 
the soundcore.ko module? The functions that em28xx_alsa is complaining 
about reside in soundcore.ko according to my research. Basically, I 
downloaded .18rc3 driver, lib and util and configured, built and 
installed. I rebooted and em28xx_alsa complained that symbols that 
resided down in soundcore.ko did not jive with the versions of the same 
symbols for which it was trying to resolve linkages. I rebuilt the 
video4linux code, reinstalled and rebooted and the problem was still 
present. It looks as though one should be able to build an new 
soundcore.ko with a ALSA package but there are no instructions on how to 
do so. Please help!!!

Best Regards,
-- 
Rob Krakora
Software Engineer
MessageNet Systems
101 East Carmel Dr. Suite 105
Carmel, IN 46032
(317)566-1677 Ext. 206
(317)663-0808 Fax
