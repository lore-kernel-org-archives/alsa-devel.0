From: David Henningsson <david.henningsson@canonical.com>
Subject: Auto-muting line-outs?
Date: Tue, 03 Aug 2010 09:53:45 +0200
Message-ID: <4C57CB09.2090004@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 8B1F9103885
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Aug 2010 09:53:47 +0200 (CEST)
Received: from hutte.canonical.com ([91.189.90.181])
	by adelie.canonical.com with esmtp (Exim 4.69 #1 (Debian))
	id 1OgCJm-00081X-CD
	for <alsa-devel@alsa-project.org>; Tue, 03 Aug 2010 08:53:46 +0100
Received: from [88.83.60.91] (helo=[192.168.8.103])
	by hutte.canonical.com with esmtpsa
	(TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32) (Exim 4.69)
	(envelope-from <david.henningsson@canonical.com>) id 1OgCJm-00048H-8P
	for alsa-devel@alsa-project.org; Tue, 03 Aug 2010 08:53:46 +0100
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

I'm getting bug reports from downstream about auto-muting not working,
and when looking at some of them I find that the reason is that they
have a headphone + line-out combination instead of headphone + speaker.

Looking at commits such as 2a2ed0df, this is intentional. I'm not sure
what the majority of users want or expect in this case though, of course
the users who like it the way it is, aren't raising their voices. :-)

Anyway, for users that really want auto-muting for their line-outs,
would a suitable workaround to recommend them, be to tweak
user_pin_config, turning the line-out into a speaker-out, or would that
have undesirable side effects?

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
