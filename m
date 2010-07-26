From: David Henningsson <david.henningsson@canonical.com>
Subject: Realtek alc269 questions
Date: Mon, 26 Jul 2010 12:01:50 +0200
Message-ID: <4C4D5D0E.6050900@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id EA04C24534
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Jul 2010 12:01:52 +0200 (CEST)
Received: from hutte.canonical.com ([91.189.90.181])
	by adelie.canonical.com with esmtp (Exim 4.69 #1 (Debian))
	id 1OdKVL-00006I-Fp
	for <alsa-devel@alsa-project.org>; Mon, 26 Jul 2010 11:01:51 +0100
Received: from c83-254-141-68.bredband.comhem.se ([83.254.141.68]
	helo=[192.168.8.103]) by hutte.canonical.com with esmtpsa
	(TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32) (Exim 4.69)
	(envelope-from <david.henningsson@canonical.com>) id 1OdKVL-00030n-Cb
	for alsa-devel@alsa-project.org; Mon, 26 Jul 2010 11:01:51 +0100
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

I'm trying to fix the sound on some Dell Optiplex machines, which are
running the ALC269 chip. I can "fix" them with some hda-verb commands,
but that won't get me auto-mute, so I'll have to make a model (or
possibly more than one) for them.

Anyway, I have a pair of questions:

1) In dmesg, there is a "SKU not ready" message at startup. What is SKU,
and is it a problem that it is not ready?

2) There are two DACs, and all models so far seem to use NID 0x03 for
headphones and NID 0x02 for everything else. But is there a single
stream going through the controller and then splitted into two on the
codec side, or is just one of the DACs activated at a time, depending on
the jack sensing state?

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
