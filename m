From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH 4/6] compress: add API header and driver
 header	files
Date: Tue, 22 Nov 2011 18:44:30 +0530
Message-ID: <1321967670.1516.221.camel@vkoul-udesk3>
References: <1314943585-11670-1-git-send-email-vinod.koul@linux.intel.com>
	<1321951920-4363-5-git-send-email-vinod.koul@linux.intel.com>
	<4ECB851E.7010806@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 4C07024394
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2011 14:18:13 +0100 (CET)
In-Reply-To: <4ECB851E.7010806@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-11-22 at 12:18 +0100, Clemens Ladisch wrote:
> Vinod Koul wrote:
> > This patch adds the header files for ioctl definations and header file for
> > driver APIs for lower level device drivers to use
> 
> > +++ b/include/sound/compress_offload.h
> > ...
> > +#define SNDRV_COMPRESS_GET_CAPS		_IOWR('C', 0x00, struct snd_compr_caps *)
> > +#define SNDRV_COMPRESS_GET_CODEC_CAPS	_IOWR('C', 0x01, struct snd_compr_codec_caps *)
> > +#define SNDRV_COMPRESS_SET_PARAMS	_IOW('C', 0x02, struct snd_compr_params *)
> > +#define SNDRV_COMPRESS_GET_PARAMS	_IOR('C', 0x03, struct snd_compr_params *)
> > +#define SNDRV_COMPRESS_TSTAMP		_IOR('C', 0x10, struct snd_compr_tstamp *)
> > +#define SNDRV_COMPRESS_AVAIL		_IOR('C', 0x11, struct snd_compr_avail *)
> 
> The type whose size is made part of the ioctl number is supposed to be
> the actual structure, not a pointer to it.
Right, I missed that.
Fixed now, thanks for pointing

-- 
~Vinod
