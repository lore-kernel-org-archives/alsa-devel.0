From: David Henningsson <david.henningsson@canonical.com>
Subject: VIA VT1708 bugs
Date: Tue, 04 Jan 2011 07:46:34 +0100
Message-ID: <4D22C24A.1080302@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id A1DF91038C7
	for <alsa-devel@alsa-project.org>; Tue,  4 Jan 2011 07:46:36 +0100 (CET)
Received: from hutte.canonical.com ([91.189.90.181])
	by adelie.canonical.com with esmtp (Exim 4.71 #1 (Debian))
	id 1Pa0fD-0006SM-81
	for <alsa-devel@alsa-project.org>; Tue, 04 Jan 2011 06:46:35 +0000
Received: from c-83-233-18-148.cust.bredband2.com ([83.233.18.148]
	helo=[192.168.8.102]) by hutte.canonical.com with esmtpsa
	(TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32) (Exim 4.71)
	(envelope-from <david.henningsson@canonical.com>) id 1Pa0fD-0003Al-4x
	for alsa-devel@alsa-project.org; Tue, 04 Jan 2011 06:46:35 +0000
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

Hi,

the state of VIA VT1708 in the current kernel is far from optimal. It 
would be good to improve the situation, at least for 2.6.38. On the 
machine here, I experience at least these bugs:

1) "Jack detect" switch has no function:

* When turning "Jack detect" off, quitting alsamixer, then restarting 
it, "Jack detect" is still on.
* When turning "Jack detect" off, then turning it on again, alsamixer 
crashes with the message "alsamixer: hcontrol.c:764: 
snd_hctl_handle_event: Assertion `elem' failed."

2) Plugging headphones in toggles "Front" switch control

* This should probably just be removed, especially with the latest 
opinion from Takashi of what "Front" really means. The problem is 
worsened by that PulseAudio seems to pick it up in some circumstances 
and thinks that it should mute everything.

3) Several users report headphones output being broken

* Symptoms vary a little and some might be due to bug 2), but some 
however report the headphones volume being "grayed out" in alsamixer. I 
haven't seen that in particular on the hardware here.

4) All these extra controls - "Independent HP", "Jack Detect", "Smart 5.1"

I assume they are meant to add extra functionality, and of course I 
don't mind that, but the problem is that since these are not very well 
described (or am I missing documentation somewhere?) it's difficult to 
know the exact intended functionality of these, and without knowing 
that, it's even more difficult to fix it when it's broken (or even 
knowing if it is broken or not!).

Any ideas and/or opinions? Should we talk to VIA about it, after all 
they seem to have written a lot of the code here? Or can someone here 
cast some light on these issues?

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
