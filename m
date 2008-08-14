From: Ben Stanley <Ben.Stanley@exemail.com.au>
Subject: SPDIF audio / non-audio bit
Date: Fri, 15 Aug 2008 00:48:41 +1000
Message-ID: <1218725321.32652.14.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.po.exetel.com.au (pecan.exetel.com.au [220.233.0.17])
	by alsa0.perex.cz (Postfix) with ESMTP id 29BB924733
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Aug 2008 16:48:47 +0200 (CEST)
Received: from 168.78.233.220.exetel.com.au ([220.233.78.168]
	helo=[192.168.1.2]) by smtp.po.exetel.com.au with esmtp (Exim 4.68)
	(envelope-from <Ben.Stanley@exemail.com.au>) id 1KTe82-0007Ck-9w
	for alsa-devel@alsa-project.org; Fri, 15 Aug 2008 00:48:42 +1000
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

Dear alsa-devel,

I recently advised this list of some problems I experienced with the
SPDIF audio / non-audio bit being set inappropriately while using the
ca0106 driver [1]. Seeing as I got no replies, I am trying again.

When playing AC3 encoded streams (Dolby Digital, DTS), the SPDIF
non-audio bit is set. Otherwise, for PCM streams, the SPDIF is set to
audio.

Could someone explain to me what part of the software is responsible for
correctly setting the SPDIF audio / non-audio bit? Is it
* alsa-driver
* alsa-lib
* application  ?

It seems to me that currently some applications (MythTV, xine) set it
correctly, but most other applications ignore it. So if it is set to
non-audio (because for example MythTV crashed before re-setting it to
audio), then all applications that are not aware of the setting have
their audio broken.

Could someone set me straight here so that I can try to produce a
permanent fix for this?

Thanks,
Ben Stanley.

[1] http://thread.gmane.org/gmane.linux.alsa.devel/54398/focus=55188
