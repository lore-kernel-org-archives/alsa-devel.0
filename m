From: Howard Abrams <abramsh@acm.org>
Subject: Simple ALSA capture/playback example and help wanted
Date: Thu, 28 Mar 2002 18:24:26 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CA3D05A.5060102@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from gemini.voidstar.org (12-236-25-36.client.attbi.com [12.236.25.36])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id DAA12601
	for <alsa-devel@alsa-project.org>; Fri, 29 Mar 2002 03:25:09 +0100
Received: from acm.org ([192.168.1.153])
	by gemini.voidstar.org (8.11.0/8.11.0) with ESMTP id g2T2Lux02231
	for <alsa-devel@alsa-project.org>; Thu, 28 Mar 2002 18:22:00 -0800
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


All,

I'm new to ALSA, and I'm using whatever version is in the
2.5.7 kernel w/ a Midiman Dio 2448 (cmipci driver).

I'm trying to write a simple app that reads some samples,
does a small bit of processing, and writes them back out
to the same device.

The card is full duplex, but I cannot seem to open a pcm
device for reading and writing at the same time. Even the
"latency.c" doesn't work. Is the driver just broke?

Two questions:

1. What is the best way to accomplish my task?

2. Does anyone have a simple example to do this?

Thanks,

h.
