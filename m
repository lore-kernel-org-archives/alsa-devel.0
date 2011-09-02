From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [RFC 3/5] compress: add API header and driver
 header files
Date: Fri, 02 Sep 2011 15:36:23 +0200
Message-ID: <4E60DBD7.704@ladisch.de>
References: <1314943585-11670-1-git-send-email-vinod.koul@linux.intel.com>
	<1314943585-11670-4-git-send-email-vinod.koul@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 6761824335
	for <alsa-devel@alsa-project.org>;
	Fri,  2 Sep 2011 15:36:25 +0200 (CEST)
In-Reply-To: <1314943585-11670-4-git-send-email-vinod.koul@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Vinod Koul wrote:
> +#define SNDRV_COMPRESS_GET_CAPS		_IOWR('C', 0x00, struct snd_compr_caps *)
> +#define SNDRV_COMPRESS_GET_CODEC_CAPS	_IOWR('C', 0x01, struct snd_compr_codec_caps *)
> +#define SNDRV_COMPRESS_SET_PARAMS	_IOW('C', 0x02, struct snd_compr_params *)
> +#define SNDRV_COMPRESS_GET_PARAMS	_IOR('C', 0x03, struct snd_compr_params *)
> +#define SNDRV_COMPRESS_TSTAMP		_IOR('C', 0x10, struct snd_compr_tstamp *)
> +#define SNDRV_COMPRESS_AVAIL		_IOR('C', 0x11, struct snd_compr_avail *)

The type whose size is made part of the ioctl number is supposed to be
the actual structure, not a pointer to it.

> +#define SNDRV_COMPRESS_PAUSE		_IO('C', 0x20)
> +#define SNDRV_COMPRESS_RESUME		_IO('C', 0x21)
> +#define SNDRV_COMPRESS_START		_IO('C', 0x22)
> +#define SNDRV_COMPRESS_STOP		_IO('C', 0x23)
> +#define SNDRV_COMPRESS_DRAIN		_IO('C', 0x24)

Please update Documentation/ioctl/ioctl-number.txt.
(This also makes it easier to pick codes without conflicts.)


Regards,
Clemens
