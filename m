From: =?ISO-8859-1?Q?=22Timo_T=2EHyrsyl=E4=22?= <timo.hyrsyla@cc-systems.com>
Subject: Bad page state in process 'rmmod' cs4281
Date: Mon, 09 Mar 2009 10:32:02 +0200
Message-ID: <49B4D402.4050509@cc-systems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw2.cc-systems.com (mailgw2.cc-systems.com
	[213.132.102.109])
	by alsa0.perex.cz (Postfix) with ESMTP id 59E9110381A
	for <alsa-devel@alsa-project.org>; Mon,  9 Mar 2009 09:32:04 +0100 (CET)
Received: from mail-ua.ccs.local (mail-ua.ccs.local [192.168.2.223])
	by mailgw2.cc-systems.com (8.14.3/8.14.3) with ESMTP id n298W3Xx013597
	for <alsa-devel@alsa-project.org>; Mon, 9 Mar 2009 09:32:03 +0100
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

Trying to make Alsa work on our embedded arm system with ixdp425 and CS4281.

kernel is 2.6.20.3 and the Alsas (driver+lib+utils) latest 1.0.19

Other than the two below errors, the system seems to work ok.

When removing the snd_cs4281 module, dmesg reports multiple errors about 
bad page

<0>Bad page state in process 'rmmod'
<0>page:c4007300 flags:0x00004000 mapping:00000000 mapcount:0 count:0
<0>Trying to fix it up, but a reboot is needed
<0>Backtrace:
<0>Bad page state in process 'rmmod'
<0>page:c4007320 flags:0x00004000 mapping:00000000 mapcount:0 count:0
<0>Trying to fix it up, but a reboot is needed
<0>Backtrace:

I've managed to track down the error upto dma_free_coherent.

snd_pcm_free > snd_pcm_lib_preallocate_free_for_all > 
snd_pcm_lib_preallocate_free > snd_pcm_lib_preallocate_dma_free > 
snd_dma_free_pages > snd_free_dev_pages > dma_free_coherent


Another issue, possibly related, is that when running aplay with --mmap 
it will crash with:

Internal error: Oops: f3 [#1]
PC is at snd_pcm_mmap_data_nopage+0x10c/0x148 [snd_pcm]
LR is at __handle_mm_fault+0x16c/0x8ac



any helping ideas?



-- 
Timo TH.
