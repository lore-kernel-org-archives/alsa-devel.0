From: Matt Flax <flatmax@Matt.Flax>
Subject: A/D chips ... retro fitting a DJ mixer.
Date: Sun, 17 Oct 2004 15:47:50 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041017054750.GA28764@mffm.ee.unsw.edu.au>
Reply-To: Matt Flax <flatmax@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp-dist.unsw.edu.au (smtp-dist-02.services.comms.unsw.EDU.AU [149.171.97.17])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id E7B6C27E
	for <alsa-devel@alsa-project.org>; Sun, 17 Oct 2004 07:47:56 +0200 (MEST)
Received: from localhost (avspam-03.services.comms.unsw.edu.au [149.171.100.18])
	by smtp-dist.unsw.edu.au (8.13.1/8.13.1) with ESMTP id i9H5lr1q025698
	for <alsa-devel@alsa-project.org>; Sun, 17 Oct 2004 15:47:53 +1000 (EST)
Received: from maillationax ([149.171.36.140])
	by smtp.unsw.edu.au (8.13.1/8.13.1) with ESMTP id i9H5lpuZ015029
	for <alsa-devel@alsa-project.org>; Sun, 17 Oct 2004 15:47:52 +1000 (EST)
Received: from flatmax by maillationax with local (Exim 4.34 #1 (Debian))
	id 1CJ3tW-0007Ua-PV
	for <alsa-devel@alsa-project.org>; Sun, 17 Oct 2004 15:47:50 +1000
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: core sound <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello,

I am wondering whether any of the developers are aware of good A/D chips 
which are interfacable or include USB-2.0 output ?

I would like to digitise the following :
http://www.vestax.com/products/pmc05proII.htm

Essentially I would simply like a USB-2.0 plug on the chassis of the 
mixer. Internal to the mixer, I am going to wire an A/D chip directly to 
the mixer's channel boards ... I will probably use a voltage follower to 
buffer the A/D from the mixer analog system.

The mixer has 6 channels operating at once .. 
2xstereo lines/phonos 
2 microphone inputs

So I need at least a 6 channel A/D chip ideally I would like an 10 
channel A/D chip. The A/D should either be integrated into a 
microprocessor or a DSP chip ... this would allow for USB communication.

If anyone knows anything or has written a driver already for such an 
animal, then please let me know.

thanks
Matt

-- 
http://www.flatmax.org

WSOLA TimeScale Audio Mod  : http://mffmtimescale.sourceforge.net/
FFTw C++                   : http://mffmfftwrapper.sourceforge.net/
Vector Bass                : http://mffmvectorbass.sourceforge.net/
Multimedia Time Code       : http://mffmtimecode.sourceforge.net/


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
