From: Peter Matthias <PeterMatthias@web.de>
Subject: default setting not fully working with new ALSA device
Date: Wed, 4 Jul 2007 16:48:54 +0200
Message-ID: <200707041648.54926.PeterMatthias@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fmmailgate02.web.de (fmmailgate02.web.de [217.72.192.227])
	by alsa0.perex.cz (Postfix) with ESMTP id 2396C244A7
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Jul 2007 16:49:15 +0200 (CEST)
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate02.web.de (Postfix) with ESMTP id 9876D8AD2FF9
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Jul 2007 16:49:14 +0200 (CEST)
Received: from [85.25.110.237] (helo=ktesibios.wotan.de)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.108 #197) id 1I66AM-0002m2-00
	for alsa-devel@alsa-project.org; Wed, 04 Jul 2007 16:49:14 +0200
Content-Disposition: inline
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

Hello,

I have got a 690G board with following lspic -nv output:

01:05.2 0403: 1002:7919
        Subsystem: 1002:7919
        Flags: bus master, fast devsel, latency 64, IRQ 19
        Memory at fe9e8000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0 
Enable-

With the default setting, microphone does not work. With module 
parameter "modprobe -i snd-hda-intel model=6stack-dig" microphone works well. 
Please add to default setting. It was written in Linux Kernel documentation 
to report this issue here.

Thank you,
	Peter
