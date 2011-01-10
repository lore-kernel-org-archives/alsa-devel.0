From: <jonas.rabbe@nokia.com>
Subject: PCM direct access functions for recording
Date: Mon, 10 Jan 2011 05:08:11 +0000
Message-ID: <C950D15B.2C65%jonas.rabbe@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da02.nokia.com (smtp.nokia.com [147.243.128.26])
	by alsa0.perex.cz (Postfix) with ESMTP id CD89E24333
	for <alsa-devel@alsa-project.org>; Mon, 10 Jan 2011 06:08:24 +0100 (CET)
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com
	[10.160.244.32])
	by mgw-da02.nokia.com (Switch-3.4.3/Switch-3.4.3) with ESMTP id
	p0A5890t027013
	for <alsa-devel@alsa-project.org>; Mon, 10 Jan 2011 07:08:22 +0200
Content-Language: en-US
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

I am trying to use the PCM direct access  (MMAP) functions for recording sound from an ALSA source, and reading the documentation has brought up a few questions. The documentation page for the mmap function [1] and the PCM test demo [2] both concern themselves with writing to the ring buffer. I was wondering if there was a similar example for reading from the ring buffer.

At this point I have been searching through the alsa-devel archives, alsa-project.org, and anything else google could throw at me, but it seems my google-fu is not as strong as I had thought. Any pointers and links concerning my use case would be most appreciated.

Thank you,

Jonas Rabbe
Software Engineer // Qt Multimedia / Brisbane / Australia

[1] http://www.alsa-project.org/alsa-doc/alsa-lib/group___p_c_m___direct.html
[2] http://www.alsa-project.org/alsa-doc/alsa-lib/_2test_2pcm_8c-example.html
