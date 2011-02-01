From: David Henningsson <david.henningsson@canonical.com>
Subject: Nvidia HDMI and four codecs
Date: Tue, 01 Feb 2011 09:10:19 +0100
Message-ID: <4D47BFEB.8040602@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 646F4243EA
	for <alsa-devel@alsa-project.org>; Tue,  1 Feb 2011 09:10:20 +0100 (CET)
Received: from youngberry.canonical.com ([91.189.89.112])
	by adelie.canonical.com with esmtp (Exim 4.71 #1 (Debian))
	id 1PkBJb-0000ye-2B
	for <alsa-devel@alsa-project.org>; Tue, 01 Feb 2011 08:10:19 +0000
Received: from c-83-233-18-148.cust.bredband2.com ([83.233.18.148]
	helo=[192.168.8.102]) by youngberry.canonical.com with esmtpsa
	(TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32) (Exim 4.71)
	(envelope-from <david.henningsson@canonical.com>) id 1PkBJa-0001ZV-WB
	for alsa-devel@alsa-project.org; Tue, 01 Feb 2011 08:10:19 +0000
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

I've seen a few Nvidia HDMI's recently which have four HDMI codecs 
connected to the same HDA controller. The problem is that we don't know 
which one(s) of these four that is the real one. So people will have to 
try devices "hdmi:Nvidia,0", "hdmi:Nvidia,1", "hdmi:Nvidia,2" and 
"hdmi:Nvidia,3" to figure out which one is the right one. (And by 
empirical testing we know that it isn't always the first one.)

Thinking PulseAudio and/or "Just Works", this is not good enough, so is 
there a way to know beforehand which one of these four that is actually 
physically connected?

I'd love BIOS to provide a good codec probe mask, a pin config default, 
or something similar, but given a codec-proc I can't see any difference 
between the real ones and the unconnected ones, so I don't know how to 
fix up the driver without hardcoding/quirking every one of them. Any hints?

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
