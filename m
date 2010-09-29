From: David Henningsson <david.henningsson@canonical.com>
Subject: Alsamixertest
Date: Wed, 29 Sep 2010 11:42:43 +0200
Message-ID: <4CA30A13.2030802@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 8D1931038C7
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Sep 2010 11:42:44 +0200 (CEST)
Received: from hutte.canonical.com ([91.189.90.181])
	by adelie.canonical.com with esmtp (Exim 4.69 #1 (Debian))
	id 1P0tBU-0005dy-9e
	for <alsa-devel@alsa-project.org>; Wed, 29 Sep 2010 10:42:44 +0100
Received: from c-83-233-18-148.cust.bredband2.com ([83.233.18.148]
	helo=[192.168.8.102]) by hutte.canonical.com with esmtpsa
	(TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32) (Exim 4.69)
	(envelope-from <david.henningsson@canonical.com>) id 1P0tBU-0008Vr-6f
	for alsa-devel@alsa-project.org; Wed, 29 Sep 2010 10:42:44 +0100
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
List-Id: alsa-devel@alsa-project.org

Here's the tool "one of the Mandriva guys" ;-) was talking about the 
other day. I should probably have announced it on both lists simultaneously.

Anyway, over the previous weeks I've been working on a small script 
which tests whether the ALSA mixer lives up to PA's expectations. If you 
are familiar with dbmeasure or dbverify by Lennart Poettering, this 
application's purpose is very similar, but this one is hopefully easier 
to set up, more user friendly, and also tests that the names of the 
volume controls are correct.
My hope is that this will aid as a debugging tool for all these 
"everything below 20% of my speaker is muted, and then 21% blows my 
speakers" bugs.

To use the tool, you'll need some kind of loopback. You can e g use a 
loopback cable and connect that between line in and line out, or test 
your laptop's internal speakers with your laptop's internal mic (just 
stop humming when you do so :-) ). Just set up the recording levels 
appropriately.

Alsamixertest is available for Ubuntu Lucid and Ubuntu Maverick from 
these PPAs:
Lucid: https://launchpad.net/~diwic/+archive/ppa
Maverick: https://launchpad.net/~diwic/+archive/maverick

For other distributions, download the tarball:
https://launchpad.net/~diwic/+archive/ppa/+files/alsamixertest_47.14.tar.gz
Unpack and read the readme file for compilation and install instructions.

When it is installed, run "alsamixertest -r" for a small tutorial and 
"alsamixertest -h" for command line options help.

Looking forward to your comments about this new little tool! I think it 
should be considered "beta" quality at this point.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
