From: "Nallasellan, Singaravelan" <singaravelan.nallasellan@intel.com>
Subject: start_threshold and stream controls for PCM streams
Date: Fri, 9 Dec 2011 11:05:19 +0530
Message-ID: <3CA6C6D9F70D314CA34352990B57DA1507CCB50120@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 1AF4624686
	for <alsa-devel@alsa-project.org>; Fri,  9 Dec 2011 06:36:23 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi,

Would like to know how start_threshold is expected to be used in 
single_threaded audio player? 

I assume that in blocking implementation,  the write call will block 
till the ring buffer becomes empty. Is it right?

If the audio player has to wait for the write call to be blocked, 
I guess it is possible that the delay to service the stream controls 
will be delayed as long as the buffer duration.

If so, how can I send stream control operations for the stream 
when the stream is blocked for the buffer?

What are the option to service stream controls immediately?

Thanks in advance. 

Thanks
-Sing
