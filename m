From: Wojciech Myrda <vojcek@tlen.pl>
Subject: Asus E35M1-M Pro and Realtek AL887-VD - no love from
	ALSA for Sourround
Date: Thu, 17 Mar 2011 06:32:34 +0100
Message-ID: <4D819CF2.3040306@tlen.pl>
References: <4D7FB076.30300@codeaurora.org>	<20110316103814.GA8369@sirena.org.uk>	<1300273162.9428.10.camel@vkoul-udesk3>	<20110316115627.GC14125@opensource.wolfsonmicro.com>	<AANLkTinDzduAmCsTU2pD5vLnE47vgQHiTmpJTHRR6qWg@mail.gmail.com>
	<20110316175357.GB15605@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moh2-ve3.go2.pl (moh2-ve3.go2.pl [193.17.41.208])
	by alsa0.perex.cz (Postfix) with ESMTP id D5950103857
	for <alsa-devel@alsa-project.org>; Thu, 17 Mar 2011 06:32:48 +0100 (CET)
Received: from moh2-ve3.go2.pl (unknown [10.0.0.208])
	by moh2-ve3.go2.pl (Postfix) with ESMTP id 251C137017F
	for <alsa-devel@alsa-project.org>; Thu, 17 Mar 2011 06:32:43 +0100 (CET)
Received: from unknown (unknown [10.0.0.142])
	by moh2-ve3.go2.pl (Postfix) with SMTP
	for <alsa-devel@alsa-project.org>; Thu, 17 Mar 2011 06:32:43 +0100 (CET)
In-Reply-To: <20110316175357.GB15605@opensource.wolfsonmicro.com>
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

Hi all,

I recently purchased Asus e35M1-M Pro and I would like to get souround
sound going from my 5.1 system. I have it connected accordingly to the
manual (line in - rear speakers, line out - front speaker, mic in -
bass/center) but anywy I try that is using guides like
http://www.gentoo-wiki.info/HOWTO_Surround_Sound I am not able to get
sound from any other speaker then front left and right one. Alsamixer
does not show any devices as shared to be available to switch to the
output from input

speaker-test plays every file in the left and right front speaker at the
same time

Here is my system information using  2.6.38-rc8-git3
http://www.alsa-project.org/db/?f=0dd55b4640a8afff1552c4d0be0105e416ad1cf3
and 2.6.38-rc8-next-20110314
http://www.alsa-project.org/db/?f=a8733bf0083929540948f51b5f33d9c8a62d9994

My question is what should I try next?

Regards,
Wojciech
