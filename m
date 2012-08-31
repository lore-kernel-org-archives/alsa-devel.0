From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH 1/3] ALSA: pcm - introduce device_buffer
Date: Fri, 31 Aug 2012 20:32:25 +0530
Message-ID: <1346425345.1895.100.camel@vkoul-udesk3>
References: <1346375684-4145-1-git-send-email-vinod.koul@linux.intel.com>
 <1346375684-4145-2-git-send-email-vinod.koul@linux.intel.com>
 <50409695.1060904@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C68E265B51
 for <alsa-devel@alsa-project.org>; Fri, 31 Aug 2012 17:02:36 +0200 (CEST)
In-Reply-To: <50409695.1060904@perex.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: tiwai@suse.de, vkoul@infradead.org, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Fri, 2012-08-31 at 12:48 +0200, Jaroslav Kysela wrote:
> Date 31.8.2012 03:14, Vinod Koul wrote:
> > -		if (avail >= runtime->stop_threshold) {
> > +		snd_pcm_uframes_t actual_avail;
> > +		if (avail < runtime->device_buffer)
> > +			actual_avail = avail;
> > +		else
> > +			actual_avail = avail - runtime->device_buffer;
> > +		if (actual_avail  >= runtime->stop_threshold) {
> 
> Perhaps this may be simplified to:
> 	if (avail >= runtime->stop_threshold + runtime->device_buffer)
I see no reason why this wouldnt work, and dont know why i didnt take
this more intuitive approach. Let me grab some coffee for my jet lagged
mind and rethink :)
> 
> > +			snd_printd(KERN_ERR  "avail > stop_threshold!!\n");
> > +			snd_printd(KERN_ERR  "actual_avail %ld, avail %ld, device_buffer %ld!!\n",
> > +					actual_avail, avail,  runtime->device_buffer);
> 
> I would propose to enhance xrun_log() to show something about
> device_buffer and remove these printd calls from this location.
Yup
> 
> 					Jaroslav
> 


-- 
~Vinod
