From: Heiko =?iso-8859-1?q?St=FCbner?= <heiko@sntech.de>
Subject: Correct i2s implementation for s3c2416
Date: Mon, 4 Apr 2011 16:30:57 +0200
Message-ID: <201104041630.58529.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from s15407518.onlinehome-server.info
	(s15407518.onlinehome-server.info [82.165.136.167])
	by alsa0.perex.cz (Postfix) with ESMTP id 44D671037FF
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Apr 2011 16:31:10 +0200 (CEST)
Received: from p5ddab7bc.dip.t-dialin.net ([93.218.183.188]
	helo=nx4-rtr-0001.kes)
	by s15407518.onlinehome-server.info with esmtpa (Exim 4.69)
	(envelope-from <heiko@sntech.de>) id 1Q6ko6-0007ze-U2
	for alsa-devel@alsa-project.org; Mon, 04 Apr 2011 16:31:07 +0200
Received: from nx4-deb-0001.local ([192.168.30.162] helo=nx4-deb-0001.localnet)
	by nx4-rtr-0001.kes with esmtp (Exim 4.69)
	(envelope-from <heiko@sntech.de>) id 1Q6ko0-0001Hq-0i
	for alsa-devel@alsa-project.org; Mon, 04 Apr 2011 16:31:01 +0200
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

Hi,

I'm trying to make sound work on a s3c2416 based device and am quite confused 
about the underlying I2S stuff as it seems there are 3 different I2S 
implementations for samsung SoCs.

The i2s.c and .h seem to be made for the s3c64xx and up (according to the 
initial commit message). 
This leaves the s3c-i2s-v2+s3c2412_i2s combination and s3c24xx-iis.

Documentation on this seems a bit sparse and I'm still taking first steps in 
kernel-development at all - so I would be really thankfull for a pointer in 
the right direction.

Thanks
Heiko
