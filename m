From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [RFC 3/5] compress: add API header and driver
 header files
Date: Sat, 03 Sep 2011 08:29:30 +0530
Message-ID: <1315018770.26251.49.camel@vkoul-udesk3>
References: <1314943585-11670-1-git-send-email-vinod.koul@linux.intel.com>
	<1314943585-11670-4-git-send-email-vinod.koul@linux.intel.com>
	<4E60DBD7.704@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 5BFA624519
	for <alsa-devel@alsa-project.org>;
	Sat,  3 Sep 2011 05:01:20 +0200 (CEST)
In-Reply-To: <4E60DBD7.704@ladisch.de>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2011-09-02 at 15:36 +0200, Clemens Ladisch wrote:
> Vinod Koul wrote:
> > +#define SNDRV_COMPRESS_GET_CAPS		_IOWR('C', 0x00, struct snd_compr_caps *)
> > +#define SNDRV_COMPRESS_GET_CODEC_CAPS	_IOWR('C', 0x01, struct snd_compr_codec_caps *)
> > +#define SNDRV_COMPRESS_SET_PARAMS	_IOW('C', 0x02, struct snd_compr_params *)
> > +#define SNDRV_COMPRESS_GET_PARAMS	_IOR('C', 0x03, struct snd_compr_params *)
> > +#define SNDRV_COMPRESS_TSTAMP		_IOR('C', 0x10, struct snd_compr_tstamp *)
> > +#define SNDRV_COMPRESS_AVAIL		_IOR('C', 0x11, struct snd_compr_avail *)
> 
> The type whose size is made part of the ioctl number is supposed to be
> the actual structure, not a pointer to it.
> 
> > +#define SNDRV_COMPRESS_PAUSE		_IO('C', 0x20)
> > +#define SNDRV_COMPRESS_RESUME		_IO('C', 0x21)
> > +#define SNDRV_COMPRESS_START		_IO('C', 0x22)
> > +#define SNDRV_COMPRESS_STOP		_IO('C', 0x23)
> > +#define SNDRV_COMPRESS_DRAIN		_IO('C', 0x24)
> 
> Please update Documentation/ioctl/ioctl-number.txt.
> (This also makes it easier to pick codes without conflicts.)
We are not using new ioctl major number here. Current piggy backed on
misc devices but this will for next rev be seen as using snd ioctl

-- 
~Vinod
