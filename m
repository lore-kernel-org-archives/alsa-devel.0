From: David Pettit <David.Pettit@globalstar.com>
Subject: davinci-pcm debug
Date: Thu, 15 Sep 2011 23:04:35 +0000
Message-ID: <7B4FB10C4117DC479BE74BE8181DEEC6136047E2@PO1-COV.ad.corp.globalstar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ham.globalstar.com (ham.globalstar.com [206.220.220.92])
	by alsa0.perex.cz (Postfix) with ESMTP id 77B79103810
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Sep 2011 01:04:43 +0200 (CEST)
Received: from MX1-COV.ad.corp.globalstar.com (mx1-cov.ad.corp.globalstar.com
	[172.18.4.31]) by ham.globalstar.com with ESMTP id
	N0Q0RYkzCmYndBkK for <alsa-devel@alsa-project.org>;
	Thu, 15 Sep 2011 16:04:37 -0700 (PDT)
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
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I've written a new codec driver and tested it on an EVM for a TI Davinci ARM processor.  It appeared to be working there.  However, now I'm trying to debug buffer under-runs in my embedded system.  I've inserted a debugging trace in the function davinci_pcm_pointer() in davinci-pdm.c to print out the value of asp_count.  What I'm seeing is that when I first start playing an audio file, the value of asp_count increments very slowly.  After some time, the value of asp_count start incrementing by the period size and I start seeing the debugging trace "davinci-pcm: audio_set_dma_params_play ...".  Is this behavior expected?     

If I enable XRUN DEBUG and set the value to 5, then I occasionally see the message "PCM: hw_ptr skipping! (pos=17153, delta=23938, period=512, jdelta=0/49/0, hw_ptr=17279/17279)" where delta is always high.  The comments in pcm_lib.c indicate that delta should be small or zero.  What does a large value indicate?

Thanks,

David
