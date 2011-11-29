From: "Pierre-Louis Bossart" <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 5/6] compress: add the core file
Date: Tue, 29 Nov 2011 15:15:01 -0600
Message-ID: <7976.5937327922$1322601337@news.gmane.org>
References: <1314943585-11670-1-git-send-email-vinod.koul@linux.intel.com>	<1321951920-4363-6-git-send-email-vinod.koul@linux.intel.com>	<s5hbos2g4af.wl%tiwai@suse.de>	<1322106354.1516.951.camel@vkoul-udesk3>	<s5hfwhd29a5.wl%tiwai@suse.de>	<1322127157.1516.973.camel@vkoul-udesk3>
	<s5h1usrxujv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 0EEAF24599
	for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2011 22:15:16 +0100 (CET)
In-Reply-To: <s5h1usrxujv.wl%tiwai@suse.de>
Content-Language: en-us
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Takashi Iwai' <tiwai@suse.de>
Cc: 'Vinod Koul' <vinod.koul@linux.intel.com>, broonie@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

> > For playback, the decoder is expected to deal with such situations on
> its
> > own and find the block boundaries, meaning at the application level
> we can
> > just push bytes down to the decoder without worrying.
> 
> But is this restriction guaranteed to be applicable to all possible
> hardwares in future?  What happens if you'll get a hardware that
> doesn't support the byte-unit push for the playback?
> That said, I see no obvious reason to give a restriction coupled with
> the stream direction.

Power consumption will be more optimized if we push bytes without looking
for block boundaries on the host. But if your hardware requires parsing on
the host, there's no impact on the API. You'd just write block-by-block and
specify the block length instead of fixed-size value.
-Pierre
