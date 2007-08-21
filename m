From: Timur Tabi <timur@freescale.com>
Subject: hw_params function and OSS emulation
Date: Tue, 21 Aug 2007 13:15:16 -0500
Message-ID: <46CB2BB4.9060808@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 05ADA1038C5
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Aug 2007 20:15:22 +0200 (CEST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l7LIFHZS014196
	for <alsa-devel@alsa-project.org>; Tue, 21 Aug 2007 11:15:18 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l7LIFHZ2023065
	for <alsa-devel@alsa-project.org>; Tue, 21 Aug 2007 13:15:17 -0500 (CDT)
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

I'm working on an ASoC driver, and I noticed that with OSS emulation enabled, 
my snd_pcm_ops.hw_params and and snd_pcm_ops.hw_free are called multiple times 
when an OSS driver uses the OSS emulation.  In my case, .hw_params is called 
*four* times, each time with a different DMA buffer size and number of periods.

The problem is that my driver allocates a DMA buffer in my .hw_params 
function.  For now, I have it deallocate the buffers at the top of the 
function and then allocate new ones based on the new hw_params values.

This is really annoying.  So I have a few questions:

1) Is there any way this can be fixed?  Can't the OSS emulation code figure 
out what it needs and wait until it's done before it calls .hw_params?

As a solution to the DMA buffer deallocate/reallocate hack I'm using, would it 
be okay to move the actual allocations to snd_pcm_ops.prepare()?  My 
.hw_params function will collect the relevant data and keep them in some 
private structure.  Then when .prepare() is called, I do the actual buffer 
allocation.

2) Can I assume that .prepare() is called only once?

3) Can I assume that .hw_params() is never called after .prepare() is called?

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
