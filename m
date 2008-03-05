From: Mathieu Monney <zittix_all@xwaves.net>
Subject: Alsa MMAP emulation
Date: Wed, 05 Mar 2008 11:47:35 +0100
Message-ID: <47CE7A47.80009@xwaves.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pimpette.xwaves.net (pimpette.xwaves.net [193.58.255.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 7265C243D4
	for <alsa-devel@alsa-project.org>; Wed,  5 Mar 2008 11:47:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by pimpette.xwaves.net (Postfix) with ESMTP id 759007AF85
	for <alsa-devel@alsa-project.org>; Wed,  5 Mar 2008 11:50:01 +0100 (CET)
Received: from pimpette.xwaves.net ([127.0.0.1])
	by localhost (pimpette.xwaves.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f5xHYo3t2FFa for <alsa-devel@alsa-project.org>;
	Wed,  5 Mar 2008 11:49:56 +0100 (CET)
Received: from [192.168.0.151] (84-74-74-46.dclient.hispeed.ch [84.74.74.46])
	by pimpette.xwaves.net (Postfix) with ESMTP id F16517AF61
	for <alsa-devel@alsa-project.org>; Wed,  5 Mar 2008 11:49:55 +0100 (CET)
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

I'm trying to get working Alsa with the PortAudio library on an embedded 
device (Nokia N810). The problem is that the sound driver is not an 
hardware driver for Alsa but a plugin which deals with the internal DSP 
of the device. This plugin doesn't support mmap'ing at all. So I was 
wondering if it is possible to configure Alsa a way such PortAudio can 
use mmap'ing on my DSP plugin ? I saw there is a mmap_emulation flag but 
the problem is that it seems to be only available on HW driver and not 
on alsa plugins.

Any clues ?

Thank you in advance

Mathieu
