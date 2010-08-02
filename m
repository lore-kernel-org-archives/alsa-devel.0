From: David Henningsson <david.henningsson@canonical.com>
Subject: ALC269 mixer nodes
Date: Mon, 02 Aug 2010 16:30:57 +0200
Message-ID: <4C56D6A1.5030805@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id EC2F8244D1
	for <alsa-devel@alsa-project.org>;
	Mon,  2 Aug 2010 16:30:58 +0200 (CEST)
Received: from hutte.canonical.com ([91.189.90.181])
	by adelie.canonical.com with esmtp (Exim 4.69 #1 (Debian))
	id 1Ofw2Z-0004h5-VK
	for <alsa-devel@alsa-project.org>; Mon, 02 Aug 2010 15:30:56 +0100
Received: from [88.83.60.91] (helo=[192.168.8.103])
	by hutte.canonical.com with esmtpsa
	(TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32) (Exim 4.69)
	(envelope-from <david.henningsson@canonical.com>) id 1Ofw2Z-0003eD-Ro
	for alsa-devel@alsa-project.org; Mon, 02 Aug 2010 15:30:55 +0100
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

Here's yet another ALC269 which I'm unsure of how to fix the right way.
There is no way to enable the microphone, and I think the trouble has to
do with that the auto parser does not check whether the node is a mixer
or a selector. It might be that the "alc269" vs "alc269vb" detection is
wrong as well (btw, what does vb stand for?).

I unfortunately do not have the full alsa-info output, but the
codec-proc is here:
http://launchpadlibrarian.net/49076615/Card0.Codecs.codec.2.txt
and PCI IDs:
http://launchpadlibrarian.net/49076618/PciMultimedia.txt

Thanks in advance,

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
