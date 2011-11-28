From: "Pierre-Louis Bossart" <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 5/6] compress: add the core file
Date: Mon, 28 Nov 2011 15:19:53 -0600
Message-ID: <34918.38142877$1322515211@news.gmane.org>
References: <1314943585-11670-1-git-send-email-vinod.koul@linux.intel.com>	<1321951920-4363-6-git-send-email-vinod.koul@linux.intel.com>
	<s5hbos2g4af.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id B6704244B1
	for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2011 22:19:55 +0100 (CET)
In-Reply-To: <s5hbos2g4af.wl%tiwai@suse.de>
Content-language: en-us
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Takashi Iwai' <tiwai@suse.de>, 'Vinod Koul' <vinod.koul@linux.intel.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

> A general note: it's not necessarily to split playback and capture
> devices.  For example, rawmidi has a single device for full-duplex.
> In the case of PCM, we had to split them because of mmap.  The mmap
> for the capture was supposed not to be read-only, some apps may want
> to add mark on the buffer.  

Beats me why an app would want to write anything into the capture ring
buffer. Do you have an example of this use case? Maybe there's a similar
need for compressed data. Thanks!
-Pierre
