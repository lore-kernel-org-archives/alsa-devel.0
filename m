From: David Henningsson <david.henningsson@canonical.com>
Subject: HDMI on HDA device=3
Date: Tue, 09 Nov 2010 15:42:33 +0100
Message-ID: <4CD95DD9.2070102@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 0ECF5103847
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2010 15:42:35 +0100 (CET)
Received: from hutte.canonical.com ([91.189.90.181])
	by adelie.canonical.com with esmtp (Exim 4.69 #1 (Debian))
	id 1PFpP7-0007CY-If
	for <alsa-devel@alsa-project.org>; Tue, 09 Nov 2010 14:42:33 +0000
Received: from c-83-233-18-148.cust.bredband2.com ([83.233.18.148]
	helo=[192.168.8.103]) by hutte.canonical.com with esmtpsa
	(TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32) (Exim 4.69)
	(envelope-from <david.henningsson@canonical.com>) id 1PFpP7-0000rw-FQ
	for alsa-devel@alsa-project.org; Tue, 09 Nov 2010 14:42:33 +0000
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I have seen a few HDMIs which share the HDA controller with the onboard 
sound card, but the codecs are different, e g the onboard one is at 
address #0 and the HDMI is at address #3 - or even #3, #7, #8 and #9 in 
some cases.

Now, if the user specifies the device string hdmi:x (where x is card 
name/number), I'd like it to kind of autodetect this and use DEV=3 
instead of DEV=0, and without breaking the cards where the hdmi is a 
separate card with a codec at address #0. However, it still seems like 
the device is at DEV=3 somehow.

Now, looking at /usr/share/alsa/cards/HDA-Intel.conf, I notice that 
there are entries HDA-Intel.pcm.hdmi.0 which sets DEV=3, so it seems 
like someone already thought of this. However, just using "hdmi:x" does 
not trigger "DEV=3". I'm still not grepping all of the alsa lisp 
architecture stuff, so could someone explain to me how the 
HDA-Intel.pcm.hdmi.0 entry relates to the "hdmi:x" alsa device string?

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
