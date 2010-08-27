From: David Henningsson <david.henningsson@canonical.com>
Subject: alsactl adds volume controls?
Date: Fri, 27 Aug 2010 16:39:25 +0200
Message-ID: <4C77CE1D.2070501@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 6DBC41038A3
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Aug 2010 16:39:28 +0200 (CEST)
Received: from hutte.canonical.com ([91.189.90.181])
	by adelie.canonical.com with esmtp (Exim 4.69 #1 (Debian))
	id 1Op05X-0008VB-4o
	for <alsa-devel@alsa-project.org>; Fri, 27 Aug 2010 15:39:27 +0100
Received: from c-83-233-18-148.cust.bredband2.com ([83.233.18.148]
	helo=[192.168.8.103]) by hutte.canonical.com with esmtpsa
	(TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32) (Exim 4.69)
	(envelope-from <david.henningsson@canonical.com>) id 1Op05X-0007OX-1Q
	for alsa-devel@alsa-project.org; Fri, 27 Aug 2010 15:39:27 +0100
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

So I've discovered that my sound card has a "PCM Playback Volume"
control, but changing that control does not alter the volume. This is
not only confusing but also a problem for PulseAudio. (PA merges this
control into it's overall volume, and so when the user moves PA's volume
control, in some ranges nothing happens.)

Interestingly enough, this control does not come from the HDA parser, it
is added by alsactl at boot time...! (Through alsa-lib's
snd_ctl_elem_add_integer, which does an snd_ctl_ioctl.)

So the question is, why is alsactl creating volume controls, and why is
userspace allowed to add controls in the first place, if the kernel
can't use them for anything anyway? That doesn't make sense to me.

This a generic problem, but sound card info, if that matters, is
available here:
https://launchpad.net/bugs/625149
Codec: http://launchpadlibrarian.net/54478760/Card0.Codecs.codec.0.txt

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
